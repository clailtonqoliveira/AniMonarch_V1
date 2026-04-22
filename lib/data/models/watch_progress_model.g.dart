// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_progress_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WatchProgressAdapter extends TypeAdapter<WatchProgress> {
  @override
  final int typeId = 1;

  @override
  WatchProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchProgress(
      animeId: fields[0] as int,
      watchedEpisodes: (fields[1] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, WatchProgress obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.animeId)
      ..writeByte(1)
      ..write(obj.watchedEpisodes.toList());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
