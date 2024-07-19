import 'package:flutter/material.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/order_page.dart';
import 'package:mobile_app/pages/profile_page.dart';
import 'package:mobile_app/pages/setting_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

 @override
  State<BottomNavBar> createState() {
    return _BottomNavBarState();
  }
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedPage = 0;

  final _pageOptions = [
    const HomePage(),
    const OrderPage(),
    const ProfilePage(),
    const SettingPage(),
  ];  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, size: 30),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30),
            label: 'Setting',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 15, 102, 86),
        elevation: 5.0,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        unselectedFontSize: 10,
        selectedFontSize: 12,
        currentIndex: selectedPage,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
         selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}