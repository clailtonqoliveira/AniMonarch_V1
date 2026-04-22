// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimeAdapter extends TypeAdapter<Anime> {
  @override
  final int typeId = 0;

  @override
  Anime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Anime(
      id: fields[0] as int,
      title: fields[1] as String,
      imageUrl: fields[2] as String,
      synopsis: fields[3] as String,
      type: fields[4] as String,
      episodes: fields[5] as int?,
      score: fields[6] as String?,
      rated: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Anime obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.synopsis)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.episodes)
      ..writeByte(6)
      ..write(obj.score)
      ..writeByte(7)
      ..write(obj.rated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
