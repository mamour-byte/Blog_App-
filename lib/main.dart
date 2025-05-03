import 'package:blogapp/screen/ProfilPage.dart';
import 'package:blogapp/screen/login.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:blogapp/screen/HomePage.dart';
import 'package:blogapp/screen/AddPost.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasData && snapshot.data == true) {
            return const MainApp(); // Ici on peut mettre l'index si on veut
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}


class MainApp extends StatefulWidget {
  final int initialIndex;

  const MainApp({super.key, this.initialIndex = 0});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Home(
      currentIndex: _currentIndex,
      setCurrentIndex: setCurrentIndex,
    );
  }
}


class Home extends StatelessWidget {
  final int currentIndex;
  final void Function(int) setCurrentIndex;

  const Home({
    required this.currentIndex,
    required this.setCurrentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(["Accueil", "Add Post", "Profil"][currentIndex]),
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
            icon: Icon(Icons.home, size: 35),
            title: Text("Home"),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.add, size: 35),
            title: Text("Add Post"),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.person, size: 35),
            title: Text("Profil"),
          ),
        ],
      ),
    );
  }
}
