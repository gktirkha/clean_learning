// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clean_learning/core/common/cubits/app_user_cubit/app_user_cubit.dart'
    as _i673;
import 'package:clean_learning/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i310;
import 'package:clean_learning/features/auth/data/repositories/auth_repository_impl.dart'
    as _i159;
import 'package:clean_learning/features/auth/domain/repositories/auth_repository.dart'
    as _i113;
import 'package:clean_learning/features/auth/domain/use_cases/current_user_use_case.dart'
    as _i7;
import 'package:clean_learning/features/auth/domain/use_cases/user_logout_case.dart'
    as _i897;
import 'package:clean_learning/features/auth/domain/use_cases/user_sign_in_use_case.dart'
    as _i976;
import 'package:clean_learning/features/auth/domain/use_cases/user_sign_up_use_case.dart'
    as _i966;
import 'package:clean_learning/features/auth/presentation/bloc/auth_bloc.dart'
    as _i432;
import 'package:clean_learning/init_dependencies.dart' as _i18;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.singleton<_i673.AppUserCubit>(() => _i673.AppUserCubit());
    gh.lazySingleton<_i454.SupabaseClient>(() => appModule.supabaseClient);
    gh.factory<_i310.AuthRemoteDataSource>(
      () => _i310.SupabaseRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i113.AuthRepository>(
      () => _i159.AuthRepositoryImpl(gh<_i310.AuthRemoteDataSource>()),
    );
    gh.factory<_i7.CurrentUserUseCase>(
      () => _i7.CurrentUserUseCase(gh<_i113.AuthRepository>()),
    );
    gh.factory<_i897.UserLogoutCase>(
      () => _i897.UserLogoutCase(gh<_i113.AuthRepository>()),
    );
    gh.factory<_i976.UserUseSignInCase>(
      () => _i976.UserUseSignInCase(gh<_i113.AuthRepository>()),
    );
    gh.factory<_i966.UserSignUpUseCase>(
      () => _i966.UserSignUpUseCase(gh<_i113.AuthRepository>()),
    );
    gh.lazySingleton<_i432.AuthBloc>(
      () => _i432.AuthBloc(
        userSignUpUseCase: gh<_i966.UserSignUpUseCase>(),
        userUseSignInCase: gh<_i976.UserUseSignInCase>(),
        currentUserUseCase: gh<_i7.CurrentUserUseCase>(),
        appUserCubit: gh<_i673.AppUserCubit>(),
        userLogoutCase: gh<_i897.UserLogoutCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i18.AppModule {}
