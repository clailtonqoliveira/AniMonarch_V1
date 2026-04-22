import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:animonarch/data/models/anime_model.dart';
import 'package:animonarch/data/models/episode_model.dart';
import 'package:animonarch/data/repositories/anime_repository.dart';
import 'package:animonarch/data/services/api_service.dart';
import 'package:animonarch/data/services/jikan_api_service.dart';
import 'package:animonarch/data/services/firestore_service.dart';
import 'package:animonarch/data/services/cache_service.dart'; // Importa o CacheService
import 'package:animonarch/presentation/screens/home/home_screen.dart';
import 'package:animonarch/presentation/viewmodels/home_viewmodel.dart';
import 'package:animonarch/presentation/viewmodels/anime_details_viewmodel.dart';
import 'package:animonarch/core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialização do Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicialização do Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(AnimeAdapter());
  Hive.registerAdapter(EpisodeAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Serviços
        Provider<JikanApiService>(
          create: (_) => JikanApiService(),
        ),
        Provider<CacheService>(
          create: (_) => CacheService(),
        ),
        ProxyProvider<JikanApiService, ApiService>(
          update: (_, jikanApiService, __) => ApiService(jikanApiService: jikanApiService),
        ),
        Provider<FirestoreService>(
          create: (_) => FirestoreService(),
        ),

        // Repositórios
        ProxyProvider2<ApiService, CacheService, AnimeRepository>(
          update: (_, apiService, cacheService, __) => AnimeRepository(apiService, cacheService),
        ),

        // ViewModels
        ChangeNotifierProxyProvider<AnimeRepository, HomeViewModel>(
          create: (context) {
            final animeRepo = Provider.of<AnimeRepository>(context, listen: false);
            return HomeViewModel(animeRepo)..fetchData();
          },
          update: (_, animeRepo, previousViewModel) => previousViewModel ?? HomeViewModel(animeRepo),
        ),
        ChangeNotifierProxyProvider2<AnimeRepository, FirestoreService, AnimeDetailsViewModel>(
          create: (context) {
            final animeRepo = Provider.of<AnimeRepository>(context, listen: false);
            final firestoreService = Provider.of<FirestoreService>(context, listen: false);
            return AnimeDetailsViewModel(animeRepo, firestoreService);
          },
          update: (_, animeRepo, firestoreService, previousViewModel) => 
              previousViewModel ?? AnimeDetailsViewModel(animeRepo, firestoreService),
        )
      ],
      child: MaterialApp(
        title: 'Animonarch',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: const HomeScreen(),
      ),
    );
  }
}
