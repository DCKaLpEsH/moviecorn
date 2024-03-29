part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

class LanguageLoadedState extends LanguageState {
  final Locale locale;
  const LanguageLoadedState({
    required this.locale,
  });
  @override
  List<Object> get props => [locale.languageCode];
}

class LanguageErrorState extends LanguageState {}
