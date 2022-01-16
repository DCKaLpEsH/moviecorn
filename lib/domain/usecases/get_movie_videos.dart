import 'package:dartz/dartz.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/movie_cast_entity.dart';
import 'package:moviecorn/domain/entities/movie_params.dart';
import 'package:moviecorn/domain/entities/movie_videos_entity.dart';
import 'package:moviecorn/domain/repositories/movie_repository.dart';

import 'use_cases.dart';

class GetMovieVideos extends UseCase<List<MovieVideosEntity>, MovieParams> {
  final MovieRepository repository;
  GetMovieVideos(this.repository);
  @override
  Future<Either<AppError, List<MovieVideosEntity>>> call(
      MovieParams params) async {
    return await repository.getMovieVideos(params.id);
  }
}
