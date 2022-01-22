import 'package:dartz/dartz.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/domain/entities/movie_params.dart';
import 'package:moviecorn/domain/entities/no_params.dart';
import 'package:moviecorn/domain/repositories/movie_repository.dart';

import 'use_cases.dart';

class CheckIfMovieFavourite extends UseCase<bool, MovieParams> {
  final MovieRepository repository;
  CheckIfMovieFavourite(this.repository);

  @override
  Future<Either<AppError, bool>> call(MovieParams params) async {
    return await repository.checkIfMovieFarourite(params.id);
  }
}
