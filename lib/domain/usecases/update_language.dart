import 'package:dartz/dartz.dart';

import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/no_params.dart';
import 'package:moviecorn/domain/repositories/local_app_repository.dart';
import 'package:moviecorn/domain/usecases/use_cases.dart';

class UpdateLanguage extends UseCase<void, String> {
  final AppRepository repository;
  UpdateLanguage(
    this.repository,
  );

  @override
  Future<Either<AppError, void>> call(String languageCode) async {
    return await repository.updateLanguage(languageCode);
  }
}
