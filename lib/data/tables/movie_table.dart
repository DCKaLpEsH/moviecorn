import 'package:hive/hive.dart';

import 'package:moviecorn/domain/entities/movie_entity.dart';

part 'movie_table.g.dart';

@HiveType(typeId: 0)
class MovieTable extends MovieEntity {
  @HiveField(0)
  final int movieId;
  @HiveField(1)
  final String posterPath;
  @HiveField(2)
  final String title;

  const MovieTable({
    required this.movieId,
    required this.posterPath,
    required this.title,
  }) : super(
          id: movieId,
          posterPath: posterPath,
          title: '',
          voteAverage: 0,
          backdropPath: '',
          releaseDate: '',
        );

  factory MovieTable.fromMovieEntity(
    MovieEntity movieEntity,
  ) {
    return MovieTable(
      movieId: movieEntity.id,
      posterPath: movieEntity.posterPath,
      title: movieEntity.title,
    );
  }
}
