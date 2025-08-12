import 'package:flutter/material.dart';

class FeaturedItemTile extends StatelessWidget {
  final String title;
  final String price;
  final String imagePath;
  final VoidCallback? onTap;

  const FeaturedItemTile({
    Key? key,
    required this.title,
    required this.price,
    required this.imagePath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Image.asset(imagePath, fit: BoxFit.cover, height: 100),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
