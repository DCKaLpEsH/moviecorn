import 'package:moviecorn/domain/entities/language_entity.dart';

class Languages {
  const Languages._();

  static List<LanguageEntity> languages = [
    LanguageEntity(code: 'en', value: "English"),
    LanguageEntity(code: 'es', value: "Spanish"),
  ];
}
