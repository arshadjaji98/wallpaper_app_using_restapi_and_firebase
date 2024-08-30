import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

// ignore: must_be_immutable
class FullScreen extends StatefulWidget {
  String imagepath;

  FullScreen({required this.imagepath});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
              tag: widget.imagepath,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: widget.imagepath,
                  fit: BoxFit.cover,
                ),
              )),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(children: [
                  GestureDetector(
                    onTap: () {
                      _save();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 20, right: 20),
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.7,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54, width: 1),
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                              colors: [Color(0x36ffffff), Color(0x0fffffff)])),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Set Wallpaper",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Poppins')),
                            Text("Image will be saved in gallery",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontFamily: 'Poppins')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: 'Poppins')))
              ],
            ),
          )
        ],
      ),
    );
  }

  void _save() async {
    var response = await Dio().get(widget.imagepath,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(response.data);
    print(result);
    Navigator.pop(context);
  }
}
