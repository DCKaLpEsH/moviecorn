part of 'movie_caruosel_bloc.dart';

abstract class MovieCarouselEvent extends Equatable {
  const MovieCarouselEvent();

  @override
  List<Object> get props => [];
}

class CarouselLoadEvent extends MovieCarouselEvent {
  final int? defaultIndex;
  CarouselLoadEvent({
    this.defaultIndex = 0,
  }) : assert(defaultIndex! >= 0, "defaultIndex should not be less than 0");
  @override
  List<Object> get props => [defaultIndex!];
}
