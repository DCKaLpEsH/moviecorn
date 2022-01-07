import 'package:dartz/dartz.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/domain/entities/no_params.dart';
import 'package:moviecorn/domain/repositories/movie_repository.dart';

import 'use_cases.dart';

class GetComingSoon extends UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;
  GetComingSoon(this.repository);
  @override
  Future<Either<AppError, List<MovieEntity>>> call(NoParams noParams) async {
    return await repository.getComingSoon();
  }
}
