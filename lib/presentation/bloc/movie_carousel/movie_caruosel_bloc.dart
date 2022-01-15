import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviecorn/domain/entities/app_error.dart';

import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/domain/entities/no_params.dart';
import 'package:moviecorn/domain/usecases/get_trending.dart';
import 'package:moviecorn/presentation/bloc/movie_backdrop/movie_backdrop_bloc.dart';

part 'movie_caruosel_event.dart';
part 'movie_caruosel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackdropBloc movieBackdropBloc;
  MovieCarouselBloc({
    required this.getTrending,
    required this.movieBackdropBloc,
  }) : super(MovieCarouselInitial()) {
    on<MovieCarouselEvent>(getMovies);
  }

  Future<void> getMovies(
      MovieCarouselEvent event, Emitter<MovieCarouselState> emit) async {
    if (event is CarouselLoadEvent) {
      final movies = await getTrending(NoParams());
      return movies.fold((l) {
        return emit(MovieCarouselError(appErrorType: l.appErrorType));
      }, (movies) {
        movieBackdropBloc.add(
          MovieBackdropChangedEvent(
            movie: movies[event.defaultIndex!],
          ),
        );
        return emit(MovieCarouselLoaded(
          movies: movies,
          defaultIndex: event.defaultIndex!,
        ));
      });
    }
    // return MovieCarouselError();
  }
}
