import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SingUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;

  AuthBloc({
    required SingUpUseCase singUpUseCase,
    required LoginUseCase loginUseCase,
  })  : _signUpUseCase = singUpUseCase,
        _loginUseCase = loginUseCase,
        super(AuthInitialState()) {
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
  }

  void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await _signUpUseCase(
      SignUpParams(
          name: event.name, email: event.email, password: event.password),
    );
    result.fold(
      (l) => emit(AuthFailureState(l.message)),
      (user) => emit(AuthSuccessState(user)),
    );
  }

  void _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await _loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (l) => emit(AuthFailureState(l.message)),
      (user) => emit(AuthSuccessState(user)),
    );
  }

  @override
  void onChange(Change<AuthState> change) {
    print("AuthBloc $change");
  }
}
