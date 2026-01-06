import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallify/model/photos_model.dart';
import 'package:wallify/widgets/widget.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<PhotosModel> photos = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  bool hasSearched = false;
  final ScrollController _scrollController = ScrollController();

  Future<void> getSearchWallpaper(String searchQuery) async {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }

    setState(() {
      isLoading = true;
      hasSearched = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
          "https://api.pexels.com/v1/search?query=$searchQuery&per_page=30",
        ),
        headers: {
          "Authorization":
              "xJ3GSJTJPtUTe2UZybPOJ011SYze6s7r6w2PpM5CYGbWDHPGiwz3PTAs",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List<PhotosModel> fetchedPhotos = [];

        for (var element in jsonData["photos"]) {
          fetchedPhotos.add(PhotosModel.fromMap(element));
        }

        setState(() {
          photos = fetchedPhotos;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching wallpapers: $e");
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Search Wallpapers',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        final query = value.trim();
                        if (query.isNotEmpty) getSearchWallpaper(query);
                      },
                      decoration: const InputDecoration(
                        hintText: "Search wallpapers...",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.black87),
                    onPressed: () {
                      final query = searchController.text.trim();
                      if (query.isNotEmpty) getSearchWallpaper(query);
                    },
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            const LinearProgressIndicator(
              color: Color.fromARGB(255, 84, 87, 93),
              backgroundColor: Colors.grey,
            ),
          if (!isLoading && photos.isEmpty && hasSearched)
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "No wallpapers found. Try a different keyword.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: wallpaper(photos, context, controller: _scrollController),
          ),
        ],
      ),
    );
  }
}
