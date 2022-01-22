import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:moviecorn/domain/entities/app_error.dart';

import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/domain/entities/movie_params.dart';
import 'package:moviecorn/domain/entities/no_params.dart';
import 'package:moviecorn/domain/usecases/check_movie_fav.dart';
import 'package:moviecorn/domain/usecases/delete_fav_movie.dart';
import 'package:moviecorn/domain/usecases/get_fav_movie.dart';
import 'package:moviecorn/domain/usecases/save_movie.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final SaveMovie saveMovie;
  final DeleteFavouriteMovie deleteFavouriteMovie;
  final GetFavouriteMovies getFavouriteMovies;
  final CheckIfMovieFavourite checkIfMovieFavourite;
  FavoriteBloc(
    this.saveMovie,
    this.deleteFavouriteMovie,
    this.getFavouriteMovies,
    this.checkIfMovieFavourite,
  ) : super(FavoriteInitial()) {
    on<FavoriteEvent>(mapEventToState);
  }

  Future<void> mapEventToState(
      FavoriteEvent event, Emitter<FavoriteState> emit) async {
    if (event is ToggleFavoriteMovieEvent) {
      if (event.isFavorite) {
        await deleteFavouriteMovie(
          MovieParams(id: event.movieEntity.id),
        );
      } else {
        await saveMovie(event.movieEntity);
      }
      final response = await checkIfMovieFavourite(
        MovieParams(
          id: event.movieEntity.id,
        ),
      );
      emit(
        response.fold(
          (l) => FavoriteMovieError(),
          (r) => IsFavoriteMovie(r),
        ),
      );
    } else if (event is LoadFavoriteMovieEvent) {
      final Either<AppError, List<MovieEntity>> response =
          await getFavouriteMovies(NoParams());

      emit(
        response.fold(
          (l) => FavoriteMovieError(),
          (r) => FavoriteMovieLoaded(r),
        ),
      );
    } else if (event is CheckIfFavoriteMovieEvent) {
      final response = await checkIfMovieFavourite(
        MovieParams(
          id: event.movieId,
        ),
      );
      emit(
        response.fold(
          (l) => FavoriteMovieError(),
          (r) => IsFavoriteMovie(r),
        ),
      );
    } else if (event is DeleteFavoriteMovieEvent) {
      await deleteFavouriteMovie(MovieParams(id: event.movieId));
      final Either<AppError, List<MovieEntity>> response =
          await getFavouriteMovies(NoParams());

      emit(
        response.fold(
          (l) => FavoriteMovieError(),
          (r) => FavoriteMovieLoaded(r),
        ),
      );
    }
  }
}
