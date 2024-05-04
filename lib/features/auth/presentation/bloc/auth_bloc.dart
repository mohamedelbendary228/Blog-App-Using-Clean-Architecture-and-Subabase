import 'package:blog_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SingUpUseCase _signUpUseCase;

  AuthBloc({
    required SingUpUseCase singUpUseCase,
  })  : _signUpUseCase = singUpUseCase,
        super(AuthInitialState()) {
    on<AuthSignUpEvent>((event, emit) {
      signUp(event, emit);
    });
  }

  Future<void> signUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    final result = await _signUpUseCase(
      SignUpParams(
          name: event.name, email: event.email, password: event.password),
    );
    result.fold(
      (l) => emit(AuthFailureState(l.message)),
      (r) => emit(AuthSuccessState(r)),
    );
  }
}
