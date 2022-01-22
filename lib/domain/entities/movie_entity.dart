import 'package:equatable/equatable.dart';

import 'movie_detail_entity.dart';

class MovieEntity extends Equatable {
  final String posterPath;
  final String title;
  final String releaseDate;
  final String? overview;
  final String backdropPath;
  final int id;
  final num voteAverage;
  const MovieEntity({
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.backdropPath,
    required this.id,
    required this.voteAverage,
    this.overview,
  });

  factory MovieEntity.fromMovieDetailEntity(
      MovieDetailEntity movieDetailEntity) {
    return MovieEntity(
      posterPath: movieDetailEntity.posterPath!,
      id: movieDetailEntity.id!,
      backdropPath: movieDetailEntity.backdropPath!,
      title: movieDetailEntity.title!,
      voteAverage: movieDetailEntity.voteAverage!,
      releaseDate: movieDetailEntity.releaseDate!,
    );
  }

  @override
  List<Object?> get props => [id, title];

  @override
  bool? get stringify => true;
}
