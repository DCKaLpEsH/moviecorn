part of 'movie_videos_bloc.dart';

abstract class MovieVideosState extends Equatable {
  const MovieVideosState();

  @override
  List<Object> get props => [];
}

class MovieVideosInitial extends MovieVideosState {}

class MovieVideosLoaded extends MovieVideosState {
  final List<MovieVideosEntity> videos;
  const MovieVideosLoaded({
    required this.videos,
  });
  @override
  // TODO: implement props
  List<Object> get props => [videos];
}

class MovieVideosError extends MovieVideosState {}
