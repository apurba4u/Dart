import 'package:flutter/material.dart';
import 'box_generator_page.dart';
import 'user_profile_page.dart';
import 'random_image_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Menu",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            ListTile(
              title: const Text("Box Generator"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BoxGeneratorPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Random Image"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RandomImagePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text("Home Dashboard"),
      ),
    );
  }
}