import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wallify/pages/home_screen.dart';
import 'package:wallify/pages/search_bar.dart';
import 'package:wallify/pages/wallpaper_categories.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentTabIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    Search(),
    WallpaperCategories(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTabIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: currentTabIndex,
        height: 60,
        backgroundColor: Colors.transparent,
        color: const Color(0xFF1C1C1E),
        buttonBackgroundColor: const Color(0xFF1C1C1E),
        items: [
          Icon(
            Icons.home,
            size: 28,
            color: currentTabIndex == 0 ? Colors.white : Colors.grey[400],
          ),
          Icon(
            Icons.search_outlined,
            size: 28,
            color: currentTabIndex == 1 ? Colors.white : Colors.grey[400],
          ),
          Icon(
            Icons.category,
            size: 28,
            color: currentTabIndex == 2 ? Colors.white : Colors.grey[400],
          ),
        ],
        onTap: (index) {
          setState(() {
            currentTabIndex = index;
          });
        },
      ),
    );
  }
}
