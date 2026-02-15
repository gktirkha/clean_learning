import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'core/secrets/app_secrets.dart';
import 'core/utils/bloc_observer.dart';
import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/use_cases/current_user_use_case.dart';
import 'features/auth/domain/use_cases/user_sign_in_use_case.dart';
import 'features/auth/domain/use_cases/user_sign_up_use_case.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  final supaBase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnon,
  );
  serviceLocator.registerSingleton<SupabaseClient>(supaBase.client);
  serviceLocator.registerSingleton<AppUserCubit>(AppUserCubit());
  _initAuth();
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => SupabaseRemoteDataSource(serviceLocator()),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerFactory(() => UserSignUpUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => UserUseSignInCase(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUserUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      userSignUpUseCase: serviceLocator(),
      userUseSignInCase: serviceLocator(),
      currentUserUseCase: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}
