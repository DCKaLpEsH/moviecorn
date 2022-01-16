import 'dart:io';

import 'package:equatable/equatable.dart';

class MovieCastEntity extends Equatable {
  String creditId;
  String name;
  String posterPath;
  String character;
  MovieCastEntity({
    required this.creditId,
    required this.name,
    required this.posterPath,
    required this.character,
  });

  @override
  List<Object?> get props => [creditId, name, posterPath, character];
}
