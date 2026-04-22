import 'package:flutter/material.dart';
import 'package:animonarch/data/models/anime_model.dart';
import 'package:animonarch/presentation/screens/details/anime_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AnimeCarousel extends StatelessWidget {
  final List<Anime> animeList;

  const AnimeCarousel({super.key, required this.animeList});

  @override
  Widget build(BuildContext context) {
    return SizedBox( // Alterado de Container para SizedBox
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: animeList.length,
        itemBuilder: (context, index) {
          final anime = animeList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimeDetailsScreen(animeId: anime.id),
                ),
              );
            },
            child: Container(
              width: 140,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: anime.imageUrl,
                      height: 180,
                      width: 120,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    anime.title,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
