// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List wallpaperImage = [
    'assets/wallpaper1.jpg',
    'assets/wallpaper2.jpg',
    'assets/wallpaper3.jpg'
  ];

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                        backgroundImage: AssetImage(
                          "assets/boy.jpg",
                        ))),
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
              itemCount: wallpaperImage.length,
              itemBuilder: (context, index, realindex) {
                final res = wallpaperImage[index];
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
      count: 3,
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
            child: Image.asset(
              urlImage,
              fit: BoxFit.cover,
            )),
      );
}
