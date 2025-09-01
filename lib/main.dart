import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:instagram/sreens/SearchSreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _MainScreen());
  }
}

class _MainScreen extends StatefulWidget {
  const _MainScreen({super.key});

  @override
  State<_MainScreen> createState() => __MainScreenState();
}

class __MainScreenState extends State<_MainScreen> {
  int _selectedIndex = 0;

  // Pages for each tab
  final List<Widget> _pages = [
    Center(
      child: Text("Home", style: TextStyle(color: Colors.black, fontSize: 30)),
    ),
    SearchSreen(),
    Center(
      child: Text("Reels", style: TextStyle(color: Colors.black, fontSize: 30)),
    ),
    Center(
      child: Text("Shop", style: TextStyle(color: Colors.black, fontSize: 30)),
    ),
    Center(
      child: Text(
        "Profile",
        style: TextStyle(color: Colors.black, fontSize: 30),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex],

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, // removes ripple
          highlightColor: Colors.transparent, // removes highlight
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 30,
          //remove tap effect
          mouseCursor: SystemMouseCursors.basic,
          enableFeedback: false,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library_outlined),
              label: "Reels",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop_outlined),
              label: "Shop",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
