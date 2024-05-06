part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AuthenticatedState extends AppUserState {
  final User user;

  AuthenticatedState(this.user);
}

final class UnAuthenticatedState extends AppUserState {}
