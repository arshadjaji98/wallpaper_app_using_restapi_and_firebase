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
  List<String> recentSearches = [];

  Future<void> getSearchWallpaper(String searchQuery) async {
    if (_scrollController.hasClients) _scrollController.jumpTo(0);

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
          if (!recentSearches.contains(searchQuery)) {
            recentSearches.insert(0, searchQuery);
            if (recentSearches.length > 5) recentSearches.removeLast();
          }
        });
      }
    } catch (e) {
      if (kDebugMode) print("Error fetching wallpapers: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
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
                decoration: InputDecoration(
                  hintText: "Search wallpapers...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  suffixIcon: searchController.text.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            searchController.clear();
                            setState(() {});
                          },
                        ),
                ),
                onChanged: (_) => setState(() {}),
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
    );
  }

  Widget _buildRecentSearches() {
    if (recentSearches.isEmpty || hasSearched) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Wrap(
        spacing: 8,
        children: recentSearches
            .map(
              (e) => ActionChip(
                label: Text(e),
                onPressed: () {
                  searchController.text = e;
                  getSearchWallpaper(e);
                },
                backgroundColor: Colors.grey.shade300,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wallpaper, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 15),
            const Text(
              "No wallpapers found.\nTry a different keyword.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return const LinearProgressIndicator(
      color: Color.fromARGB(255, 84, 87, 93),
      backgroundColor: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
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
          _buildSearchBar(),
          _buildRecentSearches(),
          if (isLoading) _buildLoadingShimmer(),
          if (!isLoading && photos.isEmpty && hasSearched) _buildEmptyState(),
          if (photos.isNotEmpty)
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  final query = searchController.text.trim();
                  if (query.isNotEmpty) await getSearchWallpaper(query);
                },
                child: wallpaper(
                  photos,
                  context,
                  controller: _scrollController,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
