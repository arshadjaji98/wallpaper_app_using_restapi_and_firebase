// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> wallpaperImages = [];
  int activeIndex = 0;
  String apiKey = 'xJ3GSJTJPtUTe2UZybPOJ011SYze6s7r6w2PpM5CYGbWDHPGiwz3PTAs';

  @override
  void initState() {
    super.initState();
    fetchWallpapers();
  }

  Future<void> fetchWallpapers() async {
    final response = await http.get(
      Uri.parse(
          'https://api.pexels.com/v1/search?query=wallpapers&per_page=100'),
      headers: {
        'Authorization': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List photos = data['photos'];
      setState(() {
        wallpaperImages = photos
            .map<String>((photo) => photo['src']['portrait'] as String)
            .toList();
      });
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallpaperImages.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
                child: Column(children: [
                  Row(children: [
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(60),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage("assets/boy.jpg"))),
                    ),
                    const SizedBox(width: 80),
                    const Text("Walify",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins')),
                  ]),
                  const SizedBox(height: 30),
                  CarouselSlider.builder(
                    itemCount: wallpaperImages.length,
                    itemBuilder: (context, index, realindex) {
                      final res = wallpaperImages[index];
                      return buildImage(res, index);
                    },
                    options: CarouselOptions(
                        autoPlay: true,
                        height: MediaQuery.of(context).size.height / 1.5,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        }),
                  ),
                  const SizedBox(height: 10),
                  Center(child: buildIndicator())
                ]),
              ),
            ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: wallpaperImages.length,
      effect: const ExpandingDotsEffect(
          activeDotColor: Color.fromARGB(255, 84, 87, 93),
          dotWidth: 10,
          dotHeight: 10));

  Widget buildImage(String urlImage, int index) => Container(
        margin: const EdgeInsets.only(right: 10),
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              urlImage,
              fit: BoxFit.cover,
            )),
      );
}
