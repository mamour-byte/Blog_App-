import 'package:blogapp/pages/ProfilPage.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:blogapp/pages/HomePage.dart';
import 'package:blogapp/pages/AddPost.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  void setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEEEEEE)),
      home: Home(currentIndex: _currentIndex, setCurrentIndex: setCurrentIndex),
    );
  }
}

class Home extends StatelessWidget {
  final int currentIndex;
  final void Function(int) setCurrentIndex;

  const Home({required this.currentIndex, required this.setCurrentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          [
            "Accueil",
            "Add Post",
            "Profil",
          ][currentIndex],
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: [
        const HomePage(),
        const AddPostPage(),
        const Profilpage(),
      ][currentIndex],
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: Colors.blueGrey,
        selectedIndex: currentIndex,
        showElevation: false,
        onItemSelected: (index) => setCurrentIndex(index),
        items: [
          FlashyTabBarItem(
            icon: const Icon(
              Icons.home,
              size: 35,
            ),
            title: const Text("Home"),

          ),
          FlashyTabBarItem(
            icon: const Icon(
              Icons.add,
              size: 35,
            ),
            title: const Text("Add Post"),

          ),
          FlashyTabBarItem(
            icon: const Icon(
              Icons.person,
              size: 35,
            ),
            title: const Text("Profil"),
          ),
        ],
      ),
    );
  }
}
