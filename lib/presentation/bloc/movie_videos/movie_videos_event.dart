part of 'movie_videos_bloc.dart';

abstract class MovieVideosEvent extends Equatable {
  const MovieVideosEvent();

  @override
  List<Object> get props => [];
}

class MovieVideosLoadingEvent extends MovieVideosEvent {
  final int movieId;
  const MovieVideosLoadingEvent({
    required this.movieId,
  });

  @override
  // TODO: implement props
  List<Object> get props => [movieId];
}
