import 'package:flutter/material.dart';
import 'package:animonarch/data/models/episode_model.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;
  final VoidCallback onTap;

  const EpisodeCard({super.key, required this.episode, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(episode.title),
        subtitle: Text('Episode ${episode.malId}'),
        onTap: onTap,
      ),
    );
  }
}
