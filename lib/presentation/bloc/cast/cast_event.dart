part of 'cast_bloc.dart';

abstract class CastEvent extends Equatable {
  const CastEvent();

  @override
  List<Object> get props => [];
}

class LoadCastEvent extends CastEvent {
  final int id;
  const LoadCastEvent({
    required this.id,
  });
  @override
  // TODO: implement props
  List<Object> get props => [id];
}
