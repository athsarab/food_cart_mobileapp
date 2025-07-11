import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ffod_app/pages/nic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffod_app/pages/auth/signin_screen.dart';

class customer extends StatefulWidget {
  const customer({Key? key}) : super(key: key);

  @override
  State<customer> createState() => _customerState();
}

class _customerState extends State<customer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? user = _auth.currentUser;

      if (user != null) {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();

        if (doc.exists) {
          setState(() {
            userData = doc.data() as Map<String, dynamic>;
          });
        }
      } else {
        // If no user is logged in, navigate to sign in screen
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const SignInScreen()),
          );
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const SignInScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 0,
        title: const Text(
          'Customer Profile',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: _signOut,
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4CAF50),
              ),
            )
          : userData == null
              ? const Center(
                  child: Text(
                    'No user data found. Please sign in.',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF4CAF50),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 6),
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            const CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              userData!['name'] ?? 'User',
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              userData!['address'] ?? 'Location Not Available',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "ID: ${_auth.currentUser?.uid.substring(0, 5) ?? ''}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Joined: ${_formatDate(userData!['createdAt'])}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 200),
                        child: Column(
                          children: [
                            _buildInfoCard(
                              title: 'Contact Information',
                              children: [
                                _buildInfoRow(
                                    'Email',
                                    userData!['email'] ??
                                        'Email Not Available'),
                                const SizedBox(height: 10),
                                _buildInfoRow(
                                    'Address',
                                    userData!['address'] ??
                                        'Address Not Available'),
                              ],
                            ),
                            _buildInfoCard(
                              title: 'Order History',
                              children: [
                                _buildInfoRow('Total Orders', '0'),
                                const SizedBox(height: 10),
                                _buildInfoRow('Last Order', 'No orders yet'),
                              ],
                            ),
                            _buildInfoCard(
                              title: 'Account Settings',
                              children: [
                                _buildAccountSettingTile(
                                  icon: Icons.edit,
                                  title: 'Edit Profile',
                                  onTap: () {
                                    // Add edit profile functionality
                                  },
                                ),
                                _buildAccountSettingTile(
                                  icon: Icons.lock_outline,
                                  title: 'Change Password',
                                  onTap: () {
                                    // Add change password functionality
                                  },
                                ),
                                _buildAccountSettingTile(
                                  icon: Icons.notifications_outlined,
                                  title: 'Notification Settings',
                                  onTap: () {
                                    // Add notification settings functionality
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4CAF50),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const nic(),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return 'N/A';

    if (timestamp is Timestamp) {
      DateTime date = timestamp.toDate();
      return "${date.day}/${date.month}/${date.year}";
    }

    return 'N/A';
  }

  Widget _buildInfoCard(
      {required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSettingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF4CAF50).withOpacity(0.1),
        child: Icon(
          icon,
          color: const Color(0xFF4CAF50),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
