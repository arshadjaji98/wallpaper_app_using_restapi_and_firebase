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
  getSearchWallpaper(String searchQuery) async {
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
      jsonData["photos"].forEach((element) {
        PhotosModel photosModel = PhotosModel.fromMap(element);
        fetchedPhotos.add(photosModel);
      });
      setState(() {
        photos = fetchedPhotos;
      });
    } else {
      if (kDebugMode) {
        print('Failed to load wallpapers: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Search",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 213, 213, 218),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: searchController,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  final query = value.trim();
                  if (query.isNotEmpty) {
                    FocusScope.of(context).unfocus(); // close keyboard properly
                    getSearchWallpaper(query);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search wallpapers',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      final query = searchController.text.trim();
                      if (query.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                        getSearchWallpaper(query);
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: wallpaper(photos, context)),
          ],
        ),
      ),
    );
  }
}
