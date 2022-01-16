part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchSuccessState extends MovieSearchState {
  final List<MovieEntity> movies;
  const MovieSearchSuccessState({
    required this.movies,
  });

  @override
  // TODO: implement props
  List<Object> get props => [movies];
}

class MovieSearchErrorState extends MovieSearchState {
  final AppErrorType appErrorType;
  const MovieSearchErrorState({
    required this.appErrorType,
  });
  @override
  // TODO: implement props
  List<Object> get props => [appErrorType];
}
