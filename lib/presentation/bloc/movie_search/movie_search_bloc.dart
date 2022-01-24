import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/domain/entities/movie_search_params.dart';
import 'package:moviecorn/domain/usecases/get_searched_movies.dart';
import 'package:moviecorn/presentation/bloc/loading/loading_bloc.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final GetSearchedMovies getSearchedMovies;
  final LoadingBloc loadingBloc;
  MovieSearchBloc(
    this.getSearchedMovies,
    this.loadingBloc,
  ) : super(MovieSearchInitial()) {
    on<MovieSearchEvent>(searchMovie);
  }

  Future<void> searchMovie(
      MovieSearchEvent event, Emitter<MovieSearchState> emit) async {
    if (event is MovieSearchingEvent) {
      loadingBloc.add(
        StartLoadingEvent(),
      );
      final moviesEither = await getSearchedMovies(
        MovieSearchParams(
          searchTerm: event.searchTerm,
        ),
      );
      moviesEither.fold((l) {
        emit(
          MovieSearchErrorState(appErrorType: l.appErrorType),
        );
      }, (movies) {
        emit(
          MovieSearchSuccessState(movies: movies),
        );
      });
      loadingBloc.add(
        FinishLoadingEvent(),
      );
    }
  }
}
