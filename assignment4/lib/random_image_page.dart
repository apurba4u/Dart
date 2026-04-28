import 'dart:math';
import 'package:flutter/material.dart';

class RandomImagePage extends StatefulWidget {
  const RandomImagePage({super.key});

  @override
  State<RandomImagePage> createState() => _RandomImagePageState();
}

class _RandomImagePageState extends State<RandomImagePage> {
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    generateImage();
  }

  void generateImage() {
    final r = Random().nextInt(1000);
    setState(() {
      imageUrl = "https://picsum.photos/300/300?random=$r";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Image"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              child: imageUrl.isEmpty
                  ? const CircularProgressIndicator()
                  : Image.network(imageUrl),
            ),
            ElevatedButton(
              onPressed: generateImage,
              child: const Text("Load New Image"),
            ),
          ],
        ),
      ),
    );
  }
}