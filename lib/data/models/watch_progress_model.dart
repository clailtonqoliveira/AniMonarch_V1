import 'package:hive/hive.dart';

part 'watch_progress_model.g.dart';

@HiveType(typeId: 1)
class WatchProgress extends HiveObject {
  @HiveField(0)
  final int animeId;

  @HiveField(1)
  final Set<int> watchedEpisodes;

  WatchProgress({
    required this.animeId,
    required this.watchedEpisodes,
  });
}
