import 'package:dartz/dartz.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/movie_cast_entity.dart';
import 'package:moviecorn/domain/entities/movie_params.dart';
import 'package:moviecorn/domain/repositories/movie_repository.dart';

import 'use_cases.dart';

class GetMovieCast extends UseCase<List<MovieCastEntity>, MovieParams> {
  final MovieRepository repository;
  GetMovieCast(this.repository);
  @override
  Future<Either<AppError, List<MovieCastEntity>>> call(
      MovieParams params) async {
    return await repository.getMovieCast(params.id);
  }
}
