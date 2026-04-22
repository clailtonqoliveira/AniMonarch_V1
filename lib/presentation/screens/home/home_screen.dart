import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animonarch/presentation/viewmodels/home_viewmodel.dart';
import 'package:animonarch/presentation/widgets/anime_carousel.dart';
import 'package:animonarch/presentation/widgets/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animonarch'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implementar busca
            },
          ),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.trendingAnimes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Erro ao carregar: ${viewModel.errorMessage}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.fetchData(),
                    child: const Text('Tentar Novamente'),
                  )
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.fetchData(),
            child: ListView(
              children: [
                const SectionHeader(title: 'Em Alta'),
                AnimeCarousel(animeList: viewModel.trendingAnimes),
                const SectionHeader(title: 'Temporada Atual'),
                AnimeCarousel(animeList: viewModel.seasonalAnimes),
                const SectionHeader(title: 'Top Animes'),
                AnimeCarousel(animeList: viewModel.topAnimes),
              ],
            ),
          );
        },
      ),
    );
  }
}
