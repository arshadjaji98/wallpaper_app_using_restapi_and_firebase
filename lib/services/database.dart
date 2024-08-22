import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseMethods {
  Future addWallpaper(
      Map<String, dynamic> wallpaperInfoMap, String id, String category) async {
    try {
      await FirebaseFirestore.instance
          .collection(category)
          .doc(id)
          .set(wallpaperInfoMap);
      print('Wallpaper added successfully to $category');
    } catch (e) {
      print('Error adding wallpaper: $e');
      throw e;
    }
  }

  Future<Stream<QuerySnapshot>> getCategory(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }
}
