// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EpisodeAdapter extends TypeAdapter<Episode> {
  @override
  final int typeId = 1;

  @override
  Episode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Episode(
      malId: fields[0] as int,
      title: fields[1] as String,
      aired: fields[2] as String?,
      score: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Episode obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.malId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.aired)
      ..writeByte(3)
      ..write(obj.score)
      ..writeByte(4)
      ..write(obj.episodeNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpisodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
