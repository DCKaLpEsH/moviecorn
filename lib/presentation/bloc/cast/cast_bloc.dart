import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviecorn/domain/entities/app_error.dart';

import 'package:moviecorn/domain/entities/movie_cast_entity.dart';
import 'package:moviecorn/domain/entities/movie_params.dart';
import 'package:moviecorn/domain/usecases/get_movie_cast.dart';

part 'cast_event.dart';
part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  CastBloc(
    this.getMovieCast,
  ) : super(CastInitial()) {
    on<CastEvent>(getCast);
  }

  final GetMovieCast getMovieCast;

  Future<void> getCast(CastEvent event, Emitter<CastState> emit) async {
    if (event is LoadCastEvent) {
      final Either<AppError, List<MovieCastEntity>> castEither =
          await getMovieCast(MovieParams(id: event.id));
      castEither.fold(
        (l) {
          print("CASTERROR");
          return emit(
            CastError(),
          );
        },
        (movieCast) {
          print("CASTLOADED");
          return emit(
            CastLoaded(movieCast: movieCast),
          );
        },
      );
    }
  }
}
