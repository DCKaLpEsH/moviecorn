part of 'cast_bloc.dart';

abstract class CastState extends Equatable {
  const CastState();

  @override
  List<Object> get props => [];
}

class CastInitial extends CastState {}

class CastLoaded extends CastState {
  final List<MovieCastEntity> movieCast;
  const CastLoaded({
    required this.movieCast,
  });
  @override
  List<Object> get props => [movieCast];
}

class CastError extends CastState {}
