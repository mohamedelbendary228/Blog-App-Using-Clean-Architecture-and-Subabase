import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SingUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;
  final CurrentUserUseCase _currentUserUseCase;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required SingUpUseCase singUpUseCase,
    required LoginUseCase loginUseCase,
    required CurrentUserUseCase currentUserUseCase,
    required AppUserCubit appUserCubit,
  })  : _signUpUseCase = singUpUseCase,
        _loginUseCase = loginUseCase,
        _currentUserUseCase = currentUserUseCase,
        _appUserCubit = appUserCubit,
        super(AuthInitialState()) {
    // on<AuthEvent>((_, emit) => emit(AuthLoadingState()));
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
    on<IsUserLoggedInEvent>(_isUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await _signUpUseCase(
      SignUpParams(
          name: event.name, email: event.email, password: event.password),
    );
    result.fold(
      (l) => emit(SignUpFailureState(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await _loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (l) => emit(LoginFailureState(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _isUserLoggedIn(
    IsUserLoggedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final result = await _currentUserUseCase(NoParams());
    result.fold(
      (l) => emit(AuthFailureState(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) async {
    _appUserCubit.updateUser(user);
    emit(AuthSuccessState(user));
  }

  @override
  void onChange(Change<AuthState> change) {
    print("AuthBloc $change");
  }
}
