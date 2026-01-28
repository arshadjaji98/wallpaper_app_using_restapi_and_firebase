import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallify/pages/full_screen.dart';
import 'package:wallify/widgets/flush_bar.dart';

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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWallpapers();
  }

  Future<void> fetchWallpapers({bool loadMore = false}) async {
    if (loadMore) setState(() => isLoadingMore = true);
    if (!loadMore) setState(() => isLoading = true);

    try {
      int randomPage = Random().nextInt(50) + 1; // random page between 1 and 50
      final response = await http.get(
        Uri.parse(
          'https://api.pexels.com/v1/search?query=wallpapers&per_page=20&page=$randomPage',
        ),
        headers: {'Authorization': apiKey},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List photos = data['photos'];

        List<String> images = photos
            .map<String>((photo) => photo['src']['portrait'] as String)
            .toList();

        images.shuffle(Random());

        setState(() {
          if (loadMore) {
            wallpaperImages.addAll(images);
          } else {
            wallpaperImages = images;
          }
          page++;
        });
      } else {
        throw Exception('Failed to load wallpapers');
      }
    } catch (e) {
      if (mounted) {
        showMessage(
          context,
          title: 'Error',
          message:
              'Could not fetch wallpapers. Check your internet connection.',
          backgroundColor: Colors.white,
          iconData: Icons.error,
          iconColor: Colors.black,
        );
      }
    } finally {
      setState(() {
        isLoadingMore = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Wallpapers',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (!isLoadingMore &&
              scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 200) {
            fetchWallpapers(loadMore: true);
          }
          return false;
        },
        child: isLoading && wallpaperImages.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  page = 1;
                  wallpaperImages.clear();
                  await fetchWallpapers();
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: wallpaperImages.length + (isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == wallpaperImages.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
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
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey[300]),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
