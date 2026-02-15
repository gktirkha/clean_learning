// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../../app/state/app_user_cubit/app_user_cubit.dart' as _i250;
import '../data/datasources/auth_remote_data_source/auth_remote_data_source.dart'
    as _i43;
import '../data/datasources/auth_remote_data_source/mock_auth_remote_data_source.dart'
    as _i470;
import '../data/datasources/auth_remote_data_source/supabase_remote_data_source.dart'
    as _i742;
import '../data/repositories/auth_repository_impl.dart' as _i74;
import '../domain/repositories/auth_repository.dart' as _i800;
import '../domain/use_cases/get_current_user_use_case.dart' as _i455;
import '../domain/use_cases/logout_user_use_case.dart' as _i34;
import '../domain/use_cases/sign_in_user_use_case.dart' as _i102;
import '../domain/use_cases/sign_up_user_use_case.dart' as _i264;
import '../presentation/bloc/auth_bloc.dart' as _i244;
import 'auth_module.dart' as _i784;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final authModule = _$AuthModule();
    gh.lazySingleton<_i454.SupabaseClient>(() => authModule.supabaseClient);
    gh.factory<_i43.AuthRemoteDataSource>(
      () => _i742.SupabaseRemoteDataSource(gh<_i454.SupabaseClient>()),
      instanceName: 'supabase',
    );
    gh.factory<_i43.AuthRemoteDataSource>(
      () => _i470.MockAuthRemoteDataSource(),
      instanceName: 'mock',
    );
    gh.factory<_i800.AuthRepository>(
      () => _i74.AuthRepositoryImpl(
        gh<_i43.AuthRemoteDataSource>(instanceName: 'mock'),
      ),
    );
    gh.factory<_i34.LogoutUserUseCase>(
      () => _i34.LogoutUserUseCase(gh<_i800.AuthRepository>()),
    );
    gh.factory<_i102.SignInUserUseCase>(
      () => _i102.SignInUserUseCase(gh<_i800.AuthRepository>()),
    );
    gh.factory<_i264.SignUpUserUseCase>(
      () => _i264.SignUpUserUseCase(gh<_i800.AuthRepository>()),
    );
    gh.factory<_i455.GetCurrentUserUseCase>(
      () => _i455.GetCurrentUserUseCase(gh<_i800.AuthRepository>()),
    );
    gh.lazySingleton<_i244.AuthBloc>(
      () => _i244.AuthBloc(
        userSignUpUseCase: gh<_i264.SignUpUserUseCase>(),
        userUseSignInCase: gh<_i102.SignInUserUseCase>(),
        currentUserUseCase: gh<_i455.GetCurrentUserUseCase>(),
        appUserCubit: gh<_i250.AppUserCubit>(),
        userLogoutCase: gh<_i34.LogoutUserUseCase>(),
      ),
    );
    return this;
  }
}

class _$AuthModule extends _i784.AuthModule {}
