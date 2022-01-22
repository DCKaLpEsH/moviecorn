import 'package:hive/hive.dart';
import 'package:pedantic/pedantic.dart';

abstract class LanguageLocalDataSource {
  Future<void> updateLanguage(String languageCode);
  Future<String> getLanguage();
}

class LanguageLocalDataSourceImpl extends LanguageLocalDataSource {
  @override
  Future<String> getLanguage() async {
    final languageBox = await Hive.openBox('languageBox');
    return languageBox.get(
      'preferred_language',
    );
  }

  @override
  Future<void> updateLanguage(String languageCode) async {
    final languageBox = await Hive.openBox('languageBox');
    unawaited(
      languageBox.put(
        'preferred_language',
        languageCode,
      ),
    );
  }
}
