import 'package:dalali_hub/app/pages/broker_home/broker_home.dart';
import 'package:dalali_hub/app/pages/chat/contact_screen.dart';
import 'package:dalali_hub/app/pages/customer_home/customer_home.dart';
import 'package:dalali_hub/app/pages/settings/settings.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State {
  int _selectedTab = 0;

  final List _pages = [
    const CustomerHomePage(),
    const BrokerHomePage(),
    const ContactScreem(),
    const Settings(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: AppColors.nauticalCreatures,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Messages"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
