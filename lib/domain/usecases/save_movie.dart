import 'package:dartz/dartz.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/domain/entities/no_params.dart';
import 'package:moviecorn/domain/repositories/movie_repository.dart';

import 'use_cases.dart';

class SaveMovie extends UseCase<void, MovieEntity> {
  final MovieRepository repository;
  SaveMovie(this.repository);
  @override
  Future<Either<AppError, void>> call(MovieEntity params) async {
    return await repository.saveFavouriteMovie(params);
  }
}
