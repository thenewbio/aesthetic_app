import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'movie_data.g.dart';

@HiveType(typeId: 0)
class MovieData {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String director;
  @HiveField(2)
  final Uint8List posterImage;
  @HiveField(3)
  final bool watched;

  MovieData(
      {required this.name,
      required this.director,
      required this.posterImage,
      required this.watched});
}
