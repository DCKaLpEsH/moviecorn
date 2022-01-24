import 'package:dartz/dartz.dart';

import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/login_request_params.dart';
import 'package:moviecorn/domain/repositories/authentication_repository.dart';
import 'package:moviecorn/domain/usecases/use_cases.dart';

class LoginUser extends UseCase<bool, LoginRequestParams> {
  final AuthenticationRepository _authenticationRepository;
  LoginUser(
    this._authenticationRepository,
  );

  @override
  Future<Either<AppError, bool>> call(LoginRequestParams params) {
    return _authenticationRepository.loginUser(
      params.toJson(),
    );
  }
}
