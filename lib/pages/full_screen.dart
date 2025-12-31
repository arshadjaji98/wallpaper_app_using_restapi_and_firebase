import 'dart:io';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class FullScreen extends StatefulWidget {
  String imagepath;

  FullScreen({super.key, required this.imagepath});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imagepath,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: widget.imagepath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: _isSaving ? null : _saveImage,
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                      left: 20,
                      right: 20,
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width / 1.7,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54, width: 1),
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [Color(0x36ffffff), Color(0x0fffffff)],
                      ),
                    ),
                    child: Center(
                      child: _isSaving
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Save Wallpaper",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Text(
                                  "Image will be saved in gallery",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveImage() async {
    setState(() => _isSaving = true);

    try {
      // Request permission
      if (!await _requestPermission(Permission.storage)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Permission denied")));
        setState(() => _isSaving = false);
        return;
      }

      // Download image
      final response = await http.get(Uri.parse(widget.imagepath));
      final bytes = response.bodyBytes;

      // Save to external storage
      final directory = await getExternalStorageDirectory();
      final folderPath = '${directory!.path}/Wallify';
      await Directory(folderPath).create(recursive: true);

      final fileName = 'wallpaper_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File('$folderPath/$fileName');
      await file.writeAsBytes(bytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image saved at $folderPath/$fileName')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save image: $e')));
    } finally {
      setState(() => _isSaving = false);
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }
}
