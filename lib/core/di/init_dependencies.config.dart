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

import '../../features/auth/data/data_sources/auth_remote_data_source/auth_remote_data_source.dart'
    as _i130;
import '../../features/auth/data/data_sources/auth_remote_data_source/mock_auth_remote_data_source.dart'
    as _i101;
import '../../features/auth/data/data_sources/auth_remote_data_source/supabase_remote_data_source.dart'
    as _i188;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/use_cases/current_user_use_case.dart'
    as _i410;
import '../../features/auth/domain/use_cases/user_logout_case.dart' as _i597;
import '../../features/auth/domain/use_cases/user_sign_in_use_case.dart'
    as _i397;
import '../../features/auth/domain/use_cases/user_sign_up_use_case.dart'
    as _i702;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../common/cubits/app_user_cubit/app_user_cubit.dart' as _i978;
import 'blog_app_module.dart' as _i331;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final blogAppModule = _$BlogAppModule();
    gh.singleton<_i978.AppUserCubit>(() => _i978.AppUserCubit());
    gh.lazySingleton<_i454.SupabaseClient>(() => blogAppModule.supabaseClient);
    gh.factory<_i130.AuthRemoteDataSource>(
      () => _i101.MockAuthRemoteDataSource(),
      instanceName: 'mock',
    );
    gh.factory<_i130.AuthRemoteDataSource>(
      () => _i188.SupabaseRemoteDataSource(gh<_i454.SupabaseClient>()),
      instanceName: 'supabase',
    );
    gh.factory<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i130.AuthRemoteDataSource>(instanceName: 'mock'),
      ),
    );
    gh.factory<_i597.UserLogoutCase>(
      () => _i597.UserLogoutCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i397.UserUseSignInCase>(
      () => _i397.UserUseSignInCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i702.UserSignUpUseCase>(
      () => _i702.UserSignUpUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i410.CurrentUserUseCase>(
      () => _i410.CurrentUserUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i797.AuthBloc>(
      () => _i797.AuthBloc(
        userSignUpUseCase: gh<_i702.UserSignUpUseCase>(),
        userUseSignInCase: gh<_i397.UserUseSignInCase>(),
        currentUserUseCase: gh<_i410.CurrentUserUseCase>(),
        appUserCubit: gh<_i978.AppUserCubit>(),
        userLogoutCase: gh<_i597.UserLogoutCase>(),
      ),
    );
    return this;
  }
}

class _$BlogAppModule extends _i331.BlogAppModule {}
