part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class MovieSearchingEvent extends MovieSearchEvent {
  final String searchTerm;
  const MovieSearchingEvent({
    required this.searchTerm,
  });

  @override
  List<Object> get props => [searchTerm];
}

class MovieNotFoundEvent extends MovieSearchEvent {}

class MovieSearchErrorEvent extends MovieSearchEvent {}
