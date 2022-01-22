import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/movie_detail_entity.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/domain/entities/movie_params.dart';
import 'package:moviecorn/domain/usecases/get_movie_detail.dart';
import 'package:moviecorn/presentation/bloc/cast/cast_bloc.dart';
import 'package:moviecorn/presentation/bloc/favorite/favorite_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastBloc castBloc;
  final FavoriteBloc favoriteBloc;
  MovieDetailBloc({
    required this.getMovieDetail,
    required this.castBloc,
    required this.favoriteBloc,
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
      favoriteBloc.add(CheckIfFavoriteMovieEvent(event.movieId));
      movieEither.fold((l) => emit(MovieDetailError()), (movieDetail) {
        emit(
          MovieDetailLoaded(movieDetailEntity: movieDetail),
        );
      });

      //todo jarr add event ithe kela tr cast load nai hoat, pn jar te add moviedetail chya initstate madhe kela tr load hote cast
      // castBloc.add(
      //   LoadCastEvent(id: event.movieId),
      //);
    }
  }
}
