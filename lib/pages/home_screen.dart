import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import 'package:wallify/pages/full_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> wallpaperImages = [];
  String apiKey = 'xJ3GSJTJPtUTe2UZybPOJ011SYze6s7r6w2PpM5CYGbWDHPGiwz3PTAs';
  int page = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    fetchWallpapers();
  }

  Future<void> fetchWallpapers({bool loadMore = false}) async {
    if (loadMore) {
      setState(() => isLoadingMore = true);
    }

    final response = await http.get(
      Uri.parse(
        'https://api.pexels.com/v1/search?query=wallpapers&per_page=20&page=$page',
      ),
      headers: {'Authorization': apiKey},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List photos = data['photos'];

      List<String> images = photos
          .map<String>((photo) => photo['src']['portrait'] as String)
          .toList();

      images.shuffle(); // optional randomness

      setState(() {
        if (loadMore) {
          wallpaperImages.addAll(images); // append new images
          isLoadingMore = false;
        } else {
          wallpaperImages = images;
        }
        page++; // next page
      });
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 84, 87, 93),
        title: const Text(
          'Wallify',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoadingMore &&
              scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 200) {
            fetchWallpapers(loadMore: true); // load next page
          }
          return false;
        },
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: wallpaperImages.length,
          itemBuilder: (context, index) {
            final url = wallpaperImages[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreen(imagepath: url),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: Colors.grey[300]),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
