import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'full_screen.dart';

class CategoryWallpapers extends StatefulWidget {
  final String category;

  const CategoryWallpapers({super.key, required this.category});

  @override
  State<CategoryWallpapers> createState() => _CategoryWallpapersState();
}

class _CategoryWallpapersState extends State<CategoryWallpapers> {
  List<String> wallpapers = [];
  int page = 1;
  bool isLoading = true;
  bool isLoadingMore = false;

  final String apiKey =
      'xJ3GSJTJPtUTe2UZybPOJ011SYze6s7r6w2PpM5CYGbWDHPGiwz3PTAs';

  @override
  void initState() {
    super.initState();
    fetchCategoryWallpapers();
  }

  Future<void> fetchCategoryWallpapers({bool loadMore = false}) async {
    if (isLoadingMore) return;

    setState(() {
      if (loadMore) {
        isLoadingMore = true;
      } else {
        isLoading = true;
      }
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://api.pexels.com/v1/search'
          '?query=${widget.category}&per_page=30&page=$page',
        ),
        headers: {'Authorization': apiKey},
      );

      final data = jsonDecode(response.body);
      final List photos = data['photos'];

      List<String> images = photos
          .map<String>((photo) => photo['src']['portrait'] as String)
          .toList();

      images.shuffle(Random());

      setState(() {
        wallpapers.addAll(images);
        page++;
      });
    } catch (_) {
      // Handle error
    }

    setState(() {
      isLoading = false;
      isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : NotificationListener<ScrollNotification>(
              onNotification: (scroll) {
                if (scroll.metrics.pixels >=
                    scroll.metrics.maxScrollExtent - 200) {
                  fetchCategoryWallpapers(loadMore: true);
                }
                return false;
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: wallpapers.length,
                itemBuilder: (context, index) {
                  final url = wallpapers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullScreen(imagepath: url),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            Container(color: Colors.grey[300]),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
