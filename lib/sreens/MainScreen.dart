import 'package:flutter/material.dart';
import 'package:instagram/sreens/SearchSreen.dart';
import 'SearchSreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(
      child: Text("Home", style: TextStyle(color: Colors.black, fontSize: 30)),
    ),
    SearchSreen(),
    const Center(
      child: Text("Reels", style: TextStyle(color: Colors.black, fontSize: 30)),
    ),
    const Center(
      child: Text("Shop", style: TextStyle(color: Colors.black, fontSize: 30)),
    ),
    const Center(
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
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
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
