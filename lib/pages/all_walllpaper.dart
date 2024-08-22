// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallpaper_application_firebase/services/database.dart';

class AllWalllpaper extends StatefulWidget {
  String category;
  AllWalllpaper({required this.category, super.key});

  @override
  State<AllWalllpaper> createState() => _AllWalllpaperState();
}

class _AllWalllpaperState extends State<AllWalllpaper> {
  Stream? categoryStream;

  getonload() async {
    categoryStream = await DatabaseMethods().getCategory(widget.category);
    setState(() {});
  }

  Widget allWallpaper() {
    return StreamBuilder(
        stream: categoryStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(ds["Image"])),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Center(
              child: Text(widget.category,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins')),
            ),
          ],
        ),
      ),
    );
  }
}
