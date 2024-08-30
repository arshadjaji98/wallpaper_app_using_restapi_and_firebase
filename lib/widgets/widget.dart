import 'package:flutter/material.dart';
import 'package:wallpaper_application_firebase/model/photos_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallpaper_application_firebase/pages/full_screen.dart';

Widget wallpaper(List<PhotosModel> listPhotos, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      padding: const EdgeInsets.all(4),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      children: listPhotos.map((PhotosModel photosModel) {
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FullScreen(imagepath: photosModel.src!.portrait!)));
          },
          child: Hero(
              tag: photosModel.src!.portrait!,
              child: Container(
                child: CachedNetworkImage(
                  imageUrl: photosModel.src!.portrait!,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              )),
        ));
      }).toList(),
    ),
  );
}
