import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/movie_detail_entity.dart';

import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/domain/entities/movie_params.dart';
import 'package:moviecorn/domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  MovieDetailBloc({
    required this.getMovieDetail,
  }) : super(MovieDetailInitial()) {
    on<MovieDetailEvent>(getDetail);
  }

  Future<void> getDetail(
      MovieDetailEvent event, Emitter<MovieDetailState> emit) async {
    if (event is MovieDetailLoadEvent) {
      final Either<AppError, MovieDetailEntity> movieEither =
          await getMovieDetail(
        MovieParams(id: event.movieId),
      );
      movieEither.fold((l) => emit(MovieDetailError()), (movieDetail) {
        return emit(
          MovieDetailLoaded(movieDetailEntity: movieDetail),
        );
      });
    }
  }
}
