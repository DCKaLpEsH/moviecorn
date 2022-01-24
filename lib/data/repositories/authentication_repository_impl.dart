import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:moviecorn/data/core/unauthorised_exception.dart';
import 'package:moviecorn/data/data_sources/authentication_local_data_source.dart';

import 'package:moviecorn/data/data_sources/authentication_remote_data_source.dart';
import 'package:moviecorn/data/models/request_token_model.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AuthenticationLocalDataSource _authenticationLocalDataSource;

  AuthenticationRepositoryImpl(
    this._authenticationRemoteDataSource,
    this._authenticationLocalDataSource,
  );

  Future<Either<AppError, RequestTokenModel>> _getRequestToken() async {
    try {
      final response = await _authenticationRemoteDataSource.getRequestToken();
      print("GOT TOKEN");
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> loginUser(Map<String, dynamic> body) async {
    final requestTokenEitherResponse = await _getRequestToken();
    final token1 =
        requestTokenEitherResponse.getOrElse(() => null!).requestToken ?? '';
    print("TOKEN1 : $token1");
    try {
      print("INSIDE");
      body.putIfAbsent('request_token', () => token1);
      print(body.containsKey('request_token'));

      final validateWithLoginToken =
          await _authenticationRemoteDataSource.validateWithLogin(body);
      final sessionId = await _authenticationRemoteDataSource
          .createSession(validateWithLoginToken.toJson());
      if (sessionId != null) {
        await _authenticationLocalDataSource.saveSessionId(sessionId);
        return const Right(true);
      }
      return const Left(AppError(AppErrorType.sessionDenied));
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> logoutUser() async {
    final sessionId = await _authenticationLocalDataSource.getSessionId();
    print("HERE RN");
    await Future.wait([
      _authenticationRemoteDataSource.deleteSession(sessionId),
      _authenticationLocalDataSource.deleteSession(),
    ]);
    // print("LOGOUT ID: ${await _authenticationLocalDataSource.getSessionId()}");
    return const Right(Unit);
  }
}
