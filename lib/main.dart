import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 150, bottom: 25),
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                image: const DecorationImage(
                  image: AssetImage('assets/images/image_2.png'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(width: 10),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          buildCarousel(),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Label Modal Gaveta",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            
                            ),
                          ],
                        ),
                      );
                    });
              },
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size(300, 48)),
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              child: const Text(
                "Clique Aqui para Abrir",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ))
        ],
      ),
    );
  }

  Widget buildCarousel() {
    List<String> images = [
      'assets/images/delete.png',
      'assets/images/download.png',
      'assets/images/reload.png',
    ];

    return CarouselSlider.builder(
      itemCount: images.length,
      options: CarouselOptions(
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 1),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final blur = index != _current ? 5.0 : 0.0;

        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: const Border(
                      left: BorderSide(
                        color: Color.fromARGB(255, 178, 176, 176),
                        width: 2.5,
                      ),
                      right: BorderSide(
                        color: Color.fromARGB(255, 178, 176, 176),
                        width: 2.5,
                      ),
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 178, 176, 176),
                        width: 2.5,
                      ),
                      top: BorderSide(
                        color: Color.fromARGB(255, 178, 176, 176),
                        width: 2.5,
                      ),
                    ),
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                      child: Container(
                        color: const Color.fromARGB(255, 247, 169, 169)
                            .withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
