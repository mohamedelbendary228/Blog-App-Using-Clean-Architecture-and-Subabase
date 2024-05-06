import 'package:blog_app/core/common/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  late User currentUser;

  void updateUser(User? user) {
    if (user == null) {
      emit(UnAuthenticatedState());
    } else {
      currentUser = user;
      emit(AuthenticatedState(user));
    }
  }
}
