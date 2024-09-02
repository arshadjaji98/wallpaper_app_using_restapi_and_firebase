// ignore: depend_on_referenced_packages
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/foundation.dart";

class DatabaseMethods {
  Future addWallpaper(
      Map<String, dynamic> wallpaperInfoMap, String id, String category) async {
    try {
      await FirebaseFirestore.instance
          .collection(category)
          .doc(id)
          .set(wallpaperInfoMap);
      if (kDebugMode) {
        print('Wallpaper added successfully to $category');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding wallpaper: $e');
      }
      rethrow;
    }
  }

  Future<Stream<QuerySnapshot>> getCategory(String name) async {
    return FirebaseFirestore.instance.collection(name).snapshots();
  }
}
