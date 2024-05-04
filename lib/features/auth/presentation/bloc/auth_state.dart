part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final String userId;

  AuthSuccessState(this.userId);
}

final class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState(this.message);
}
