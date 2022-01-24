part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInitialEvent extends LoginEvent {
  final String username;
  final String password;
  LoginInitialEvent({
    required this.username,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        username,
        password,
      ];
}

class LogoutEvent extends LoginEvent {}
