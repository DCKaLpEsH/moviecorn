import 'package:dartz/dartz.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/movie_detail_entity.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/domain/entities/movie_params.dart';
import 'package:moviecorn/domain/entities/no_params.dart';
import 'package:moviecorn/domain/repositories/movie_repository.dart';

import 'use_cases.dart';

class GetMovieDetail extends UseCase<MovieDetailEntity, MovieParams> {
  final MovieRepository repository;
  GetMovieDetail(this.repository);

  @override
  Future<Either<AppError, MovieDetailEntity>> call(
      MovieParams movieParams) async {
    return await repository.getMovieDetail(movieParams.id);
  }
}
