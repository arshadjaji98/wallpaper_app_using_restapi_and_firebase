import 'dart:io';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

// ignore: must_be_immutable
class FullScreen extends StatefulWidget {
  String imagepath;

  FullScreen({super.key, required this.imagepath});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  bool _isSavingGallery = false;
  bool _isSettingLock = false;

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
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: _isSavingGallery ? null : _saveImageToGallery,
                  child: _buildButton(
                    "Save Wallpaper",
                    "Image will be saved in gallery",
                    _isSavingGallery,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _isSettingLock ? null : _setLockScreenWallpaper,
                  child: _buildButton(
                    "Set as Lock Screen",
                    "Image will be set as lock screen",
                    _isSettingLock,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
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

  Widget _buildButton(String title, String subtitle, bool isLoading) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _saveImageToGallery() async {
    setState(() => _isSavingGallery = true);

    try {
      if (!await _requestPermission(Permission.storage)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Permission denied")));
        setState(() => _isSavingGallery = false);
        return;
      }

      final response = await http.get(Uri.parse(widget.imagepath));
      final bytes = response.bodyBytes;

      // Save in public Pictures/Wallify folder
      final dirs = await getExternalStorageDirectories(
        type: StorageDirectory.pictures,
      );
      final folderPath = '${dirs!.first.path}/Wallify';
      await Directory(folderPath).create(recursive: true);

      final fileName = 'wallpaper_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File('$folderPath/$fileName');
      await file.writeAsBytes(bytes);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Image saved in gallery!')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save image: $e')));
    } finally {
      setState(() => _isSavingGallery = false);
    }
  }

  Future<void> _setLockScreenWallpaper() async {
    setState(() => _isSettingLock = true);

    try {
      if (!await _requestPermission(Permission.storage)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Permission denied")));
        setState(() => _isSettingLock = false);
        return;
      }

      final response = await http.get(Uri.parse(widget.imagepath));
      final bytes = response.bodyBytes;

      // Save to temp file
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/wallpaper_temp.png');
      await file.writeAsBytes(bytes);

      // Set lock screen
      await WallpaperManagerFlutter().setWallpaper(
        file,
        WallpaperManagerFlutter.lockScreen,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lock screen wallpaper set!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to set wallpaper: $e')));
    } finally {
      setState(() => _isSettingLock = false);
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }
}
