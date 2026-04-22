import 'package:flutter/material.dart';
import 'package:animonarch/data/models/anime_model.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  final VoidCallback onTap;

  const AnimeCard({super.key, required this.anime, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            Image.network(anime.imageUrl, fit: BoxFit.cover),
            Text(anime.title),
          ],
        ),
      ),
    );
  }
}
