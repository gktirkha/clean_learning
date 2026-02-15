import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/state/app_user_cubit/app_user_cubit.dart';
import '../../../../core/common/entities/user_entity/user_entity.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../../core/utils/snack_bar_utils.dart';
import '../../domain/use_cases/get_current_user_use_case.dart';
import '../../domain/use_cases/logout_user_use_case.dart';
import '../../domain/use_cases/sign_in_user_use_case.dart';
import '../../domain/use_cases/sign_up_user_use_case.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignUpUserUseCase userSignUpUseCase,
    required SignInUserUseCase userUseSignInCase,
    required GetCurrentUserUseCase currentUserUseCase,
    required AppUserCubit appUserCubit,
    required LogoutUserUseCase userLogoutCase,
  }) : _userSignUpUseCase = userSignUpUseCase,
       _userUseSignInCase = userUseSignInCase,
       _currentUserUseCase = currentUserUseCase,
       _appUserCubit = appUserCubit,
       _userLogoutCase = userLogoutCase,
       super(const AuthState.initial()) {
    on<AuthEvent>(_onEvent);
  }

  final SignUpUserUseCase _userSignUpUseCase;
  final SignInUserUseCase _userUseSignInCase;
  final GetCurrentUserUseCase _currentUserUseCase;
  final AppUserCubit _appUserCubit;
  final LogoutUserUseCase _userLogoutCase;

  Future<void> _onEvent(AuthEvent event, Emitter<AuthState> emit) async {
    emit(const .loading());
    await event.when(
      started: () async {
        emit(const AuthState.initial());
      },

      signup: (name, email, password) async {
        await _signUp(name, email, password, emit);
      },

      signIn: (email, password) async {
        await _signIn(email, password, emit);
      },

      isLoggedIn: () async {
        await _checkCurrentUser(emit);
      },
      signOut: () async {
        await _signOut(emit);
      },
    );
  }

  Future<void> _signUp(
    String name,
    String email,
    String password,
    Emitter<AuthState> emit,
  ) async {
    final result = await _userSignUpUseCase(
      SignUpUserUseCaseParams(name: name, email: email, password: password),
    );

    result.fold((failure) {
      emit(.failure(message: failure.message));
      showAppSnackBar(failure.message);
    }, (user) => _emitAuthSuccess(user, emit));
  }

  Future<void> _signIn(
    String email,
    String password,
    Emitter<AuthState> emit,
  ) async {
    final result = await _userUseSignInCase(
      SignInUserUseCaseParams(email: email, password: password),
    );

    result.fold((failure) {
      emit(.failure(message: failure.message));
      showAppSnackBar(failure.message);
    }, (user) => _emitAuthSuccess(user, emit));
  }

  Future<void> _checkCurrentUser(Emitter<AuthState> emit) async {
    final result = await _currentUserUseCase(NoParams());

    result.fold((failure) {
      emit(const .initial());
    }, (user) => _emitAuthSuccess(user, emit));
  }

  void _emitAuthSuccess(UserEntity user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(.success(user: user));
  }

  Future<void> _signOut(Emitter<AuthState> emit) async {
    await _userLogoutCase(NoParams());

    _appUserCubit.updateUser(null);
    emit(const .initial());
  }
}
