part of 'movie_caruosel_bloc.dart';

abstract class MovieCarouselState extends Equatable {
  const MovieCarouselState();

  @override
  List<Object> get props => [];
}

class MovieCarouselInitial extends MovieCarouselState {}

class MovieCarouselError extends MovieCarouselState {}

class MovieCarouselLoaded extends MovieCarouselState {
  final List<MovieEntity> movies;
  final int defaultIndex;
  const MovieCarouselLoaded({
    required this.movies,
    required this.defaultIndex,
  });

  @override
  List<Object> get props => [movies, defaultIndex];
}
