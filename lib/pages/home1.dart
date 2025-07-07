import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String user = '';
  int _selectedIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  static const List<Widget> _pageNav = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: _pageNav[_selectedIndex],
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 29, 29, 29),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
                backgroundColor: const Color.fromARGB(255, 29, 29, 29),
                activeColor: Color.fromARGB(255, 4, 148, 184),
                tabBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
                gap: 8,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                padding: const EdgeInsets.all(15),
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'HOME',
                  ),
                  GButton(
                    icon: Icons.description_outlined,
                    text: 'INVOICE',
                  ),
                  GButton(
                    icon: Icons.cloud_queue,
                    text: 'STOCK',
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: 'Settings',
                  )
                ]),
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
