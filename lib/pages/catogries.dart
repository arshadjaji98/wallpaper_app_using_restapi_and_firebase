import 'package:flutter/material.dart';
import 'package:wallpaper_application_firebase/pages/all_walllpaper.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final double containerHeight = 200;
  final double borderRadius = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            children: [
              const Center(
                child: Text("Categories",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins')),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AllWalllpaper(category: 'Wildlife ')));
                },
                child: _buildCategoryContainer(
                    context, "assets/animals.jpg", "WildLife", 0, 210),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AllWalllpaper(category: 'Foods')));
                },
                child: _buildCategoryContainer(
                    context, "assets/foods.jpg", "Foods", 0, 210),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AllWalllpaper(category: 'Nature')));
                },
                child: _buildCategoryContainer(
                    context, "assets/nature.jpg", "Nature", 0, 210),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AllWalllpaper(category: 'Places')));
                },
                child: _buildCategoryContainer(
                    context, "assets/city.jpg", "Places", 0, 210),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryContainer(BuildContext context, String imagePath,
      String label, double topPosition, double textBackgroundHeight) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      height: containerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            Image.asset(imagePath,
                width: MediaQuery.of(context).size.width,
                height: containerHeight,
                fit: BoxFit.cover),
            Positioned(
                top: topPosition,
                left: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: textBackgroundHeight,
                  color: Colors.black26,
                  child: Center(
                    child: Text(
                      label,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
