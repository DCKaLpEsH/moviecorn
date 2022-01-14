import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:moviecorn/common/constants/languages.dart';
import 'package:moviecorn/domain/entities/language_entity.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc()
      : super(
          LanguageLoadedState(
            locale: Locale(Languages.languages[0].code),
          ),
        ) {
    on<LanguageEvent>((event, emit) {
      if (event is ToggleLanguageEvent) {
        return emit(
          LanguageLoadedState(
            locale: Locale(event.language.code),
          ),
        );
      }
    });
  }
}
