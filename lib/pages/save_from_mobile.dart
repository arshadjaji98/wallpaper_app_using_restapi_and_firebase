import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> saveImageToGallery(Uint8List bytes, BuildContext context) async {
  // Request storage permission (Android)
  final status = await Permission.storage.request();
  if (!status.isGranted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Permission denied")));
    return;
  }

  try {
    // Get external storage directory
    final directory = await getExternalStorageDirectory();
    final folderPath = '${directory!.path}/Wallify'; // your folder
    await Directory(folderPath).create(recursive: true);

    // Save file
    final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File('$folderPath/$fileName');
    await file.writeAsBytes(bytes);

    // Notify Android to scan the file so it appears in gallery
    final result = await Process.run('am', [
      'broadcast',
      '-a',
      'android.intent.action.MEDIA_SCANNER_SCAN_FILE',
      '-d',
      'file://${file.path}',
    ]);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image saved at $folderPath/$fileName')),
    );
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Failed to save image: $e')));
  }
}
