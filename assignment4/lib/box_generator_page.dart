import 'dart:math';
import 'package:flutter/material.dart';

class BoxGeneratorPage extends StatefulWidget {
  const BoxGeneratorPage({super.key});

  @override
  State<BoxGeneratorPage> createState() => _BoxGeneratorPageState();
}

class _BoxGeneratorPageState extends State<BoxGeneratorPage> {
  Color boxColor = Colors.blue;

  void generateColor() {
    final r = Random();
    setState(() {
      boxColor = Color.fromARGB(
        255,
        r.nextInt(256),
        r.nextInt(256),
        r.nextInt(256),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Box Generator"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                "I'm custom made container",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            ElevatedButton(
              onPressed: generateColor,
              child: const Text("Change Color"),
            ),
          ],
        ),
      ),
    );
  }
}