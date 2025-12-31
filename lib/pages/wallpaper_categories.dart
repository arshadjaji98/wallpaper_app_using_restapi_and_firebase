import 'package:flutter/material.dart';

class WallpaperCategories extends StatefulWidget {
  const WallpaperCategories({super.key});

  @override
  State<WallpaperCategories> createState() => _WallpaperCategoriesState();
}

class _WallpaperCategoriesState extends State<WallpaperCategories> {
  final List<String> categories = [
    'Nature',
    'Cars',
    'Anime',
    'Abstract',
    'Minimal',
    'Dark',
    'Technology',
    'Space',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wallpaper Categories')),
      body: SizedBox(
        height: 45,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Handle category tap
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 84, 87, 93),
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  categories[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
