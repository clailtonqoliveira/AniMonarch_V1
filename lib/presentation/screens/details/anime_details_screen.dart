import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animonarch/presentation/viewmodels/anime_details_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animonarch/core/theme/app_colors.dart';
import 'package:flutter/gestures.dart';

class AnimeDetailsScreen extends StatefulWidget {
  final int animeId;

  const AnimeDetailsScreen({super.key, required this.animeId});

  @override
  State<AnimeDetailsScreen> createState() => _AnimeDetailsScreenState();
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<AnimeDetailsViewModel>(context, listen: false);

    // Listener para exibir SnackBars
    viewModel.addListener(_showUserMessage);

    // Busca inicial de dados
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchAnimeDetails(widget.animeId);
    });
  }

  void _showUserMessage() {
    final viewModel = Provider.of<AnimeDetailsViewModel>(context, listen: false);
    if (viewModel.userMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.userMessage!),
          backgroundColor: AppColors.primaryNeon.withAlpha(204), // Correção aqui
        ),
      );
      // Limpa a mensagem após exibi-la para não mostrar novamente
      viewModel.clearUserMessage();
    }
  }

  @override
  void dispose() {
    Provider.of<AnimeDetailsViewModel>(context, listen: false).removeListener(_showUserMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AnimeDetailsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading || viewModel.anime == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          final anime = viewModel.anime!;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 350.0,
                pinned: true,
                actions: [
                  // Botão de Favorito
                  IconButton(
                    icon: Icon(
                      viewModel.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: viewModel.isFavorite ? AppColors.primaryNeon : Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      viewModel.toggleFavorite();
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(anime.title, style: const TextStyle(fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis,),
                  background: CachedNetworkImage(
                    imageUrl: anime.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.grey[800]),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sinopse", style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      _buildSynopsis(context, anime.synopsis),
                      const SizedBox(height: 24),
                      _buildInfoRow(context, "Tipo", anime.type),
                      _buildInfoRow(context, "Episódios", anime.episodes?.toString() ?? 'N/A'),
                      _buildInfoRow(context, "Nota", anime.score ?? 'N/A'),
                      _buildInfoRow(context, "Classificação", anime.rated ?? 'N/A'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSynopsis(BuildContext context, String synopsis) {
    final textSpan = TextSpan(
      text: _isExpanded ? synopsis : synopsis.substring(0, synopsis.length > 200 ? 200 : synopsis.length),
      style: Theme.of(context).textTheme.bodyMedium,
      children: synopsis.length > 200 ? <TextSpan>[
        TextSpan(
          text: _isExpanded ? '  ler menos' : '... ler mais',
          style: const TextStyle(color: AppColors.primaryNeon, fontWeight: FontWeight.bold),
          recognizer: TapGestureRecognizer()..onTap = () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
      ] : null,
    );

    return RichText(text: textSpan);
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text('$label: ', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
