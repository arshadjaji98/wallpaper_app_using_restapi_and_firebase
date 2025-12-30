import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

Future<void> saveImageMobile(Uint8List data, BuildContext context) async {
  if (await _requestPermission(Permission.storage)) {
    final result = await ImageGallerySaver.saveImage(data);

    if (result['isSuccess']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image saved successfully: ${result['filePath']}'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to save image: ${result['errorMessage']}"),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Permission to access storage was denied")),
    );
  }
}

Future<bool> _requestPermission(Permission permission) async {
  final status = await permission.request();
  return status.isGranted;
}
