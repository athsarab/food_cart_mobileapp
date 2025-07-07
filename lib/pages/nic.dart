import 'package:ffod_app/pages/home1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class nic extends StatefulWidget {
  const nic({super.key});

  @override
  State<nic> createState() => _nicState();
}

class _nicState extends State<nic> {
  TextEditingController nicController = TextEditingController();
  var nic = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 47, 65),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                const Image(
                  image: AssetImage('assets/id.png'),
                  width: 250,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                const Text('ජාතික හැදුරුම්පත් අංකය ඇතුලත් කරන්න',
                    style: TextStyle(
                        color: Color.fromARGB(255, 142, 166, 190),
                        fontSize: 13)),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: nicController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: 'NIC Number',
                        labelText: 'NIC Number',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.person_2_sharp),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 172, 172, 172)))),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                const Text('Please check if the number entered is correct',
                    style: TextStyle(color: Color.fromARGB(255, 93, 108, 123))),
                const Text('ඇතුලත් කල අංකය නිවැරදිදැයි පරික්ෂාකරන්න',
                    style: TextStyle(color: Color.fromARGB(255, 93, 108, 123))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 101, 102, 102)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => home(),
                              ),
                            );
                          },
                          child: const Text(
                            "Back",
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 3, 189, 251)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString(
                                'cus_nic', nicController.text.toUpperCase());
                          },
                          child: const Text(
                            "Next",
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
