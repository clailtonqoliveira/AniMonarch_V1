import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animonarch/presentation/viewmodels/my_list_viewmodel.dart';
import 'package:animonarch/presentation/widgets/anime_list_item.dart';

class MyListScreen extends StatelessWidget {
  const MyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Lista'),
      ),
      body: Consumer<MyListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.myList.isEmpty) {
            return const Center(
              child: Text('Sua lista está vazia.'),
            );
          }
          return ListView.builder(
            itemCount: viewModel.myList.length,
            itemBuilder: (context, index) {
              final anime = viewModel.myList[index];
              return AnimeListItem(anime: anime);
            },
          );
        },
      ),
    );
  }
}
