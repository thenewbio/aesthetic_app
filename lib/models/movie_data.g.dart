// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDataAdapter extends TypeAdapter<MovieData> {
  @override
  final int typeId = 0;

  @override
  MovieData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieData(
      name: fields[0] as String,
      director: fields[1] as String,
      posterImage: fields[2] as Uint8List,
      watched: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MovieData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.director)
      ..writeByte(2)
      ..write(obj.posterImage)
      ..writeByte(3)
      ..write(obj.watched);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
