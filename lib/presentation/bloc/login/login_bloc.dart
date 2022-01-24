import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviecorn/common/constants/transalations_constants.dart';
import 'package:moviecorn/domain/entities/app_error.dart';
import 'package:moviecorn/domain/entities/login_request_params.dart';
import 'package:moviecorn/domain/entities/no_params.dart';

import 'package:moviecorn/domain/usecases/login_user.dart';
import 'package:moviecorn/domain/usecases/logout_user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;

  LoginBloc(this.loginUser, this.logoutUser) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginInitialEvent) {
        final Either<AppError, bool> eitherResponse = await loginUser(
          LoginRequestParams(
            password: event.password,
            userName: event.username,
          ),
        );

        emit(
          eitherResponse.fold((l) {
            var msg = getErrorMessage(l.appErrorType);
            print("MSG $msg");
            return LoginError(message: msg);
          }, (r) => LoginSuccess()),
        );
      } else if (event is LogoutEvent) {
        await logoutUser(NoParams());
        return emit(
          LogoutSucces(),
        );
      }
    });
  }

  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return TranslationsConstants.noNetwork;
      case AppErrorType.api:

      case AppErrorType.database:
        return TranslationsConstants.somethingWentWrong;
      case AppErrorType.sessionDenied:
        return TranslationsConstants.sessionDenied;
      default:
        return TranslationsConstants.wrongUsernamePassword;
    }
  }
}
