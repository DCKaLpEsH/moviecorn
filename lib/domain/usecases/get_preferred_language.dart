import 'package:dartz/dartz.dart';

import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/no_params.dart';
import 'package:moviecorn/domain/repositories/local_app_repository.dart';
import 'package:moviecorn/domain/usecases/use_cases.dart';

class GetPreferredLanguage extends UseCase<String, NoParams> {
  final AppRepository repository;
  GetPreferredLanguage(
    this.repository,
  );

  @override
  Future<Either<AppError, String>> call(NoParams params) async {
    return await repository.getLanguage();
  }
}
