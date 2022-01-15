part of 'movie_tabbed_bloc.dart';

abstract class MovieTabbedState extends Equatable {
  final int? currentTabIndex;
  const MovieTabbedState({this.currentTabIndex});

  @override
  List<Object> get props => [currentTabIndex!];
}

class MovieTabbedInitial extends MovieTabbedState {}

class MovieTabLoadError extends MovieTabbedState {
  const MovieTabLoadError({
    required this.appErrorType,
    int? currentTabIndex,
  }) : super(currentTabIndex: currentTabIndex);
  final AppErrorType appErrorType;
}

class MovieTabChanged extends MovieTabbedState {
  final List<MovieEntity>? movies;
  const MovieTabChanged({int? currentTabIndex, this.movies})
      : super(currentTabIndex: currentTabIndex);

  @override
  // TODO: implement props
  List<Object> get props => [currentTabIndex!, movies!];
}
