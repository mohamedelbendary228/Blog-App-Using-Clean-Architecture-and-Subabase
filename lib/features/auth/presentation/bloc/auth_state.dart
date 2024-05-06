part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final User user;

  AuthSuccessState(this.user);
}

final class LoginSuccessState extends AuthState {
  final User user;

  LoginSuccessState(this.user);
}

final class SignUpSuccessState extends AuthState {
  final User user;

  SignUpSuccessState(this.user);
}

final class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState(this.message);
}

final class LoginFailureState extends AuthState {
  final String message;

  LoginFailureState(this.message);
}

final class SignUpFailureState extends AuthState {
  final String message;

  SignUpFailureState(this.message);
}
