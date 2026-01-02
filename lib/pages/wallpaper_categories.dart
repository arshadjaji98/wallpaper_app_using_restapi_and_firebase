import 'package:flutter/material.dart';

class WallpaperCategories extends StatefulWidget {
  const WallpaperCategories({super.key});

  @override
  State<WallpaperCategories> createState() => _WallpaperCategoriesState();
}

class _WallpaperCategoriesState extends State<WallpaperCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 84, 87, 93),
        title: Text(
          'Wallpaper Categories',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10),
        children: [
          GestureDetector(
            onTap: () {},
            child: _buildCategoryContainer(
              context,
              "assets/animals.jpg",
              "WildLife",
              0,
              210,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {},
            child: _buildCategoryContainer(
              context,
              "assets/foods.jpg",
              "Food",
              0,
              210,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {},
            child: _buildCategoryContainer(
              context,
              "assets/nature.jpg",
              "Nature",
              0,
              210,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {},
            child: _buildCategoryContainer(
              context,
              "assets/cars.jpg",
              "Cars",
              0,
              210,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {},
            child: _buildCategoryContainer(
              context,
              "assets/technology.jpg",
              "Technology",
              0,
              210,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {},
            child: _buildCategoryContainer(
              context,
              "assets/sad.jpg",
              "Sad",
              0,
              210,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {},
            child: _buildCategoryContainer(
              context,
              "assets/happy.jpg",
              "Happy",
              0,
              210,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {},
            child: _buildCategoryContainer(
              context,
              "assets/dark.jpg",
              "Dark",
              0,
              210,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {},
            child: _buildCategoryContainer(
              context,
              "assets/city.jpg",
              "City",
              0,
              210,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildCategoryContainer(
  BuildContext context,
  String imagePath,
  String label,
  double topPosition,
  double textBackgroundHeight,
) {
  final double containerHeight = 200;
  final double borderRadius = 20;
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
          Image.asset(
            imagePath,
            width: MediaQuery.of(context).size.width,
            height: containerHeight,
            fit: BoxFit.cover,
          ),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
