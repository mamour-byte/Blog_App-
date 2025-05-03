import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilpage extends StatefulWidget {
  const Profilpage({super.key});

  @override
  State<Profilpage> createState() => _ProfilpageState();
}

class _ProfilpageState extends State<Profilpage> {
  String name = "John Doe";
  String email = "johndoe@example.com";
  String profileImage =
      "https://www.gravatar.com/avatar/placeholder?s=200&d=mp"; // Remplace par l'URL réelle

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name") ?? "John Doe";
      email = prefs.getString("email") ?? "johndoe@example.com";
      profileImage = prefs.getString("profileImage") ??
          "https://www.gravatar.com/avatar/placeholder?s=200&d=mp";
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(profileImage),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              email,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            ProfileOption(
              icon: Icons.edit,
              title: "Modifier mes informations",
              onTap: () {
                // Naviguer vers la page de modification
              },
            ),
            ProfileOption(
              icon: Icons.lock,
              title: "Changer le mot de passe",
              onTap: () {
                // Naviguer vers changement de mot de passe
              },
            ),
            ProfileOption(
              icon: Icons.logout,
              title: "Déconnexion",
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
