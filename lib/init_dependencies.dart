import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/sign_up_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton<AppUserCubit>(() => AppUserCubit());
}

void _initAuth() {
  // Register Auth DataSource
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );

  // Register Auth Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  // Register SignUpUseCase
  serviceLocator.registerFactory(
    () => SingUpUseCase(serviceLocator()),
  );

  // Register LoginUseCase
  serviceLocator.registerFactory(
    () => LoginUseCase(serviceLocator()),
  );

  // Register CurrentUserUseCase
  serviceLocator.registerFactory(
    () => CurrentUserUseCase(serviceLocator()),
  );

  // Register Auth Bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      singUpUseCase: serviceLocator<SingUpUseCase>(),
      loginUseCase: serviceLocator<LoginUseCase>(),
      currentUserUseCase: serviceLocator<CurrentUserUseCase>(),
      appUserCubit: serviceLocator<AppUserCubit>(),
    ),
  );
}
