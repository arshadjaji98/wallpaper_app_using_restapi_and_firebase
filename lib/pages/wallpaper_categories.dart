import 'package:flutter/material.dart';
import 'package:wallify/pages/categoroy_wallpaper.dart';

class WallpaperCategories extends StatefulWidget {
  const WallpaperCategories({super.key});

  @override
  State<WallpaperCategories> createState() => _WallpaperCategoriesState();
}

class _WallpaperCategoriesState extends State<WallpaperCategories>
    with AutomaticKeepAliveClientMixin {
  final List<Map<String, String>> categories = [
    {"label": "WildLife", "image": "assets/animals.jpg"},
    {"label": "Food", "image": "assets/foods.jpg"},
    {"label": "Nature", "image": "assets/nature.jpg"},
    {"label": "Cars", "image": "assets/cars.jpg"},
    {"label": "Technology", "image": "assets/technology.jpg"},
    {"label": "Sad", "image": "assets/sad.jpg"},
    {"label": "Happy", "image": "assets/happy.jpg"},
    {"label": "Dark", "image": "assets/dark.jpg"},
    {"label": "City", "image": "assets/city.jpg"},
    {"label": "Space", "image": "assets/space.jpg"},
    {"label": "Minimal", "image": "assets/minimal.jpg"},
    {"label": "Sports", "image": "assets/sports.jpg"},
  ];

  @override
  void initState() {
    super.initState();
    // Preload all images
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var cat in categories) {
        precacheImage(AssetImage(cat['image']!), context);
      }
    });
  }

  @override
  bool get wantKeepAlive => true; // Keeps the screen alive

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Categories",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryWallpapers(category: cat['label']!),
                ),
              );
            },
            child: _buildCategoryContainer(
              context,
              cat['image']!,
              cat['label']!,
              0,
              210,
            ),
          );
        },
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
