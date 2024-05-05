part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class UserAuthenticatedState extends AppUserState {
  final User user;

  UserAuthenticatedState(this.user);
}
