import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/movie_params.dart';

import 'package:moviecorn/domain/entities/movie_videos_entity.dart';
import 'package:moviecorn/domain/usecases/get_movie_videos.dart';

part 'movie_videos_event.dart';
part 'movie_videos_state.dart';

class MovieVideosBloc extends Bloc<MovieVideosEvent, MovieVideosState> {
  final GetMovieVideos getMovieVideos;
  MovieVideosBloc({
    required this.getMovieVideos,
  }) : super(MovieVideosInitial()) {
    on<MovieVideosEvent>(getVideos);
  }

  Future<void> getVideos(
      MovieVideosEvent event, Emitter<MovieVideosState> emit) async {
    if (event is MovieVideosLoadingEvent) {
      final Either<AppError, List<MovieVideosEntity>> videosEither =
          await getMovieVideos(MovieParams(id: event.movieId));
      videosEither.fold((l) {
        emit(
          MovieVideosError(),
        );
      }, (videos) {
        emit(
          MovieVideosLoaded(videos: videos),
        );
      });
    }
  }
}
