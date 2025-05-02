import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const PageTitle({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
        const SizedBox(height: 8),
        Text(subtitle, style: const TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }
}