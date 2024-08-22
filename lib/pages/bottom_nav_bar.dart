import 'package:flutter/material.dart';
import 'package:wallpaper_application_firebase/pages/catogries.dart';
import 'package:wallpaper_application_firebase/pages/home_screen.dart';
import 'package:wallpaper_application_firebase/pages/search_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late HomeScreen home;
  late Catogries catogries;
  late Search search;
  late Widget currentPage;

  @override
  void initState() {
    home = HomeScreen();
    search = Search();
    catogries = Catogries();
    currentPage = HomeScreen();
    pages = [home, search, catogries];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.white,
        height: 65,
        color: Color.fromARGB(255, 84, 87, 93),
        animationDuration: Duration(microseconds: 500),
        onTap: (int index) {
          setState(
            () {
              currentTabIndex = index;
            },
          );
        },
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.search_outlined, color: Colors.white),
          Icon(Icons.category, color: Colors.white),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
