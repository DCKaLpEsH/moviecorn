import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviecorn/domain/entities/movie_entity.dart';

part 'movie_backdrop_event.dart';
part 'movie_backdrop_state.dart';

class MovieBackdropBloc extends Bloc<MovieBackdropEvent, MovieBackdropState> {
  MovieBackdropBloc() : super(MovieBackdropInitial()) {
    on<MovieBackdropEvent>(changed);
  }

  Future<void> changed(
      MovieBackdropEvent event, Emitter<MovieBackdropState> emit) async {
    print("BACKDROP");
    return emit(
      MovieBackdropChanged(movie: (event as MovieBackdropChangedEvent).movie),
    );
  }
}
