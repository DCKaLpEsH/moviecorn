part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LogoutSucces extends LoginState {}

class LoginError extends LoginState {
  final String message;
  const LoginError({
    required this.message,
  });

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
