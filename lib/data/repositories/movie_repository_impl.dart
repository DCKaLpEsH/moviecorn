import 'dart:io';
import 'dart:math';

import 'package:dartz/dartz.dart';

import 'package:moviecorn/data/data_sources/movie_local_data_source.dart';
import 'package:moviecorn/data/data_sources/remote_data_source.dart';
import 'package:moviecorn/data/models/movie_cast_model.dart';
import 'package:moviecorn/data/models/movie_detail_model.dart';
import 'package:moviecorn/data/models/movie_model.dart';
import 'package:moviecorn/data/models/movie_vidoes_model.dart';
import 'package:moviecorn/data/tables/movie_table.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/movie_cast_entity.dart';
import 'package:moviecorn/domain/entities/movie_detail_entity.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/domain/entities/movie_videos_entity.dart';
import 'package:moviecorn/domain/repositories/movie_repository.dart';
import 'package:moviecorn/domain/usecases/get_movie_cast.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  MovieRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
  );

  @override
  Future<Either<AppError, List<MovieModel>>> getTrending() async {
    try {
      final movies = await remoteDataSource.getTrending();
      return Right(movies);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow() async {
    try {
      final movies = await remoteDataSource.getPlayingNow();
      return Right(movies);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPopular() async {
    try {
      final movies = await remoteDataSource.getPopular();
      return Right(movies);
    } on SocketException {
      throw const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getComingSoon() async {
    try {
      final movies = await remoteDataSource.getComingSoon();
      return Right(movies);
    } on SocketException {
      throw const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, MovieDetailModel>> getMovieDetail(int id) async {
    try {
      final movieDetail = await remoteDataSource.getMovieDetail(id);
      return Right(movieDetail);
    } on SocketException {
      throw const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<CastModel>>> getMovieCast(int id) async {
    try {
      final movieCast = await remoteDataSource.getMovieCast(id);
      return Right(movieCast);
    } on SocketException {
      throw const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieVideoModel>>> getMovieVideos(int id) async {
    try {
      final movieVideos = await remoteDataSource.getMovieVideos(id);
      return Right(movieVideos);
    } on SocketException {
      throw const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getSearchedMovies(
      String searchTerm) async {
    try {
      final movies = await remoteDataSource.getSearchedMovie(searchTerm);
      return Right(movies);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> checkIfMovieFarourite(int movieId) async {
    try {
      final response = await localDataSource.checkIfMovieFav(movieId);
      return Right(response);
    } on Exception {
      return const Left(
        AppError(AppErrorType.database),
      );
    }
  }

  @override
  Future<Either<AppError, void>> deleteFavouriteMovies(int movieId) async {
    try {
      final response = await localDataSource.deleteMovie(movieId);
      return Right(response);
    } on Exception {
      return const Left(
        AppError(AppErrorType.database),
      );
    }
  }

  @override
  Future<Either<AppError, List<MovieTable>>> getFavouriteMovies() async {
    try {
      final response = await localDataSource.getMovies();
      return Right(response);
    } on Exception {
      return Left(
        AppError(AppErrorType.database),
      );
    }
  }

  @override
  Future<Either<AppError, void>> saveFavouriteMovie(
      MovieEntity movieEntity) async {
    try {
      final response = await localDataSource.saveMovie(
        MovieTable.fromMovieEntity(movieEntity),
      );
      return Right(response);
    } on Exception {
      return const Left(
        AppError(AppErrorType.database),
      );
    }
  }
}
