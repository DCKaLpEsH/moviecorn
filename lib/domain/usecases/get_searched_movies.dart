import 'package:dartz/dartz.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/movie_cast_entity.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/domain/entities/movie_params.dart';
import 'package:moviecorn/domain/entities/movie_search_params.dart';
import 'package:moviecorn/domain/entities/movie_videos_entity.dart';
import 'package:moviecorn/domain/repositories/movie_repository.dart';

import 'use_cases.dart';

class GetSearchedMovies extends UseCase<List<MovieEntity>, MovieSearchParams> {
  final MovieRepository repository;
  GetSearchedMovies(this.repository);
  @override
  Future<Either<AppError, List<MovieEntity>>> call(
      MovieSearchParams params) async {
    return await repository.getSearchedMovies(params.searchTerm);
  }
}
