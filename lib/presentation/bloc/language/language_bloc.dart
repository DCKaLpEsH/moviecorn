import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:moviecorn/common/constants/languages.dart';
import 'package:moviecorn/domain/entities/language_entity.dart';
import 'package:moviecorn/domain/entities/no_params.dart';
import 'package:moviecorn/domain/usecases/get_preferred_language.dart';
import 'package:moviecorn/domain/usecases/update_language.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetPreferredLanguage getPreferredLanguage;
  final UpdateLanguage updateLanguage;
  LanguageBloc({
    required this.getPreferredLanguage,
    required this.updateLanguage,
  }) : super(
          LanguageLoadedState(locale: Locale(Languages.languages[0].code)),
        ) {
    on<LanguageEvent>((event, emit) async {
      if (event is ToggleLanguageEvent) {
        emit(
          LanguageLoadedState(
            locale: Locale(event.language.code),
          ),
        );
      } else if (event is LoadPreferredLanguageEvent) {
        final response = await getPreferredLanguage(NoParams());
        emit(
          response.fold((l) => LanguageErrorState(),
              (r) => LanguageLoadedState(locale: Locale(r))),
        );
      }
    });
  }
}
