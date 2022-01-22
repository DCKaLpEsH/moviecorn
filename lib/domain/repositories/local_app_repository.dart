import 'package:dartz/dartz.dart';

import 'package:moviecorn/data/data_sources/language_local_data_source.dart';
import 'package:moviecorn/domain/entities/app_error.dart';

abstract class AppRepository {
  Future<Either<AppError, void>> updateLanguage(String languageCode);
  Future<Either<AppError, String>> getLanguage();
}

class AppRepositoryImpl extends AppRepository {
  final LanguageLocalDataSource languageLocalDataSource;
  AppRepositoryImpl({
    required this.languageLocalDataSource,
  });

  @override
  Future<Either<AppError, String>> getLanguage() async {
    try {
      final response = await languageLocalDataSource.getLanguage();
      return Right(response);
    } on Exception {
      return const Left(
        AppError(
          AppErrorType.database,
        ),
      );
    }
  }

  @override
  Future<Either<AppError, void>> updateLanguage(String languageCode) async {
    try {
      final response =
          await languageLocalDataSource.updateLanguage(languageCode);
      return Right(response);
    } on Exception {
      return const Left(
        AppError(
          AppErrorType.database,
        ),
      );
    }
  }
}
