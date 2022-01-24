import 'package:dartz/dartz.dart';

import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/login_request_params.dart';
import 'package:moviecorn/domain/entities/no_params.dart';
import 'package:moviecorn/domain/repositories/authentication_repository.dart';
import 'package:moviecorn/domain/usecases/use_cases.dart';

class LogoutUser extends UseCase<void, NoParams> {
  final AuthenticationRepository _authenticationRepository;
  LogoutUser(
    this._authenticationRepository,
  );

  @override
  Future<Either<AppError, void>> call(NoParams params) {
    return _authenticationRepository.logoutUser();
  }
}
