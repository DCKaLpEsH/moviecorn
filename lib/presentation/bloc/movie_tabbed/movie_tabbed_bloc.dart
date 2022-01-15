import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';
import 'package:moviecorn/domain/entities/no_params.dart';

import 'package:moviecorn/domain/usecases/get_coming_soon.dart';
import 'package:moviecorn/domain/usecases/get_playing_now.dart';
import 'package:moviecorn/domain/usecases/get_popular.dart';

part 'movie_tabbed_event.dart';
part 'movie_tabbed_state.dart';

class MovieTabbedBloc extends Bloc<MovieTabbedEvent, MovieTabbedState> {
  final GetPopular? getPopular;
  final GetComingSoon? getComingSoon;
  final GetPlayingNow? getPlayingNow;
  MovieTabbedBloc({
    required this.getPopular,
    required this.getComingSoon,
    required this.getPlayingNow,
  }) : super(MovieTabbedInitial()) {
    on<MovieTabbedEvent>(tabPressed);
  }

  Future<void> tabPressed(
      MovieTabbedEvent event, Emitter<MovieTabbedState> emit) async {
    if (event is MovieTabChangedEvent) {
      Either<AppError, List<MovieEntity>>? moviesEither;
      switch (event.currentTabIndex) {
        case 0:
          moviesEither = await getPopular!(NoParams());
          break;
        case 1:
          moviesEither = await getPlayingNow!(NoParams());
          break;
        case 2:
          moviesEither = await getComingSoon!(NoParams());
          break;
      }
      return emit(
        moviesEither!.fold(
          (l) => MovieTabLoadError(
            appErrorType: l.appErrorType,
            currentTabIndex: event.currentTabIndex,
          ),
          (movies) {
            return MovieTabChanged(
              currentTabIndex: event.currentTabIndex,
              movies: movies,
            );
          },
        ),
      );
    }
  }
}
