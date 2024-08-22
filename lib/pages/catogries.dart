import 'package:flutter/material.dart';

class Catogries extends StatefulWidget {
  const Catogries({super.key});

  @override
  State<Catogries> createState() => _CatogriesState();
}

class _CatogriesState extends State<Catogries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              const Center(
                child: Text("Categories",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins')),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/animals.jpg",
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                    ),
                    Positioned(
                      top: 46,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 210,
                        color: Colors.black26,
                        child: const Center(
                          child: Text(
                            "WildLife",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/foods.jpg",
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                    ),
                    Positioned(
                      top: 33,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 235,
                        color: Colors.black26,
                        child: const Center(
                          child: Text(
                            "Foods",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/nature.jpg",
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                    ),
                    Positioned(
                      top: 12,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 270,
                        color: Colors.black26,
                        child: const Center(
                          child: Text(
                            "Nature",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/city.jpg",
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                    ),
                    Positioned(
                      top: 36,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 228,
                        color: Colors.black26,
                        child: const Center(
                          child: Text(
                            "Places",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
