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

import '../../features/auth/data/datasources/auth_remote_data_source/auth_remote_data_source.dart'
    as _i738;
import '../../features/auth/data/datasources/auth_remote_data_source/mock_auth_remote_data_source.dart'
    as _i598;
import '../../features/auth/data/datasources/auth_remote_data_source/supabase_remote_data_source.dart'
    as _i271;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/use_cases/get_current_user_use_case.dart'
    as _i129;
import '../../features/auth/domain/use_cases/logout_user_use_case.dart'
    as _i699;
import '../../features/auth/domain/use_cases/sign_in_user_use_case.dart'
    as _i389;
import '../../features/auth/domain/use_cases/sign_up_user_use_case.dart'
    as _i510;
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
    gh.factory<_i738.AuthRemoteDataSource>(
      () => _i271.SupabaseRemoteDataSource(gh<_i454.SupabaseClient>()),
      instanceName: 'supabase',
    );
    gh.factory<_i738.AuthRemoteDataSource>(
      () => _i598.MockAuthRemoteDataSource(),
      instanceName: 'mock',
    );
    gh.factory<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i738.AuthRemoteDataSource>(instanceName: 'mock'),
      ),
    );
    gh.factory<_i699.LogoutUserUseCase>(
      () => _i699.LogoutUserUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i389.SignInUserUseCase>(
      () => _i389.SignInUserUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i510.SignUpUserUseCase>(
      () => _i510.SignUpUserUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i129.GetCurrentUserUseCase>(
      () => _i129.GetCurrentUserUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i797.AuthBloc>(
      () => _i797.AuthBloc(
        userSignUpUseCase: gh<_i510.SignUpUserUseCase>(),
        userUseSignInCase: gh<_i389.SignInUserUseCase>(),
        currentUserUseCase: gh<_i129.GetCurrentUserUseCase>(),
        appUserCubit: gh<_i978.AppUserCubit>(),
        userLogoutCase: gh<_i699.LogoutUserUseCase>(),
      ),
    );
    return this;
  }
}

class _$BlogAppModule extends _i331.BlogAppModule {}
