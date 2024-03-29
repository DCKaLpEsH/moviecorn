part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ToggleLanguageEvent extends LanguageEvent {
  final LanguageEntity language;
  const ToggleLanguageEvent({
    required this.language,
  });
  @override
  List<Object> get props => [language];
}

class LoadPreferredLanguageEvent extends LanguageEvent {}
