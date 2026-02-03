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
    final width = MediaQuery.of(context).size.width;
    final isWeb = width >= 800;

    return isWeb ? _webLayout() : _mobileLayout();
  }

  // 📱 MOBILE LAYOUT
  Widget _mobileLayout() {
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

  // 🖥 WEB / DESKTOP LAYOUT
  Widget _webLayout() {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: currentTabIndex,
            onDestinationSelected: (index) {
              setState(() {
                currentTabIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            backgroundColor: const Color(0xFF1C1C1E),
            selectedIconTheme: const IconThemeData(color: Colors.white),
            unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
            selectedLabelTextStyle: const TextStyle(color: Colors.white),
            unselectedLabelTextStyle: TextStyle(color: Colors.grey[400]),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search_outlined),
                label: Text('Search'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.category),
                label: Text('Categories'),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: pages[currentTabIndex]),
        ],
      ),
    );
  }
}
