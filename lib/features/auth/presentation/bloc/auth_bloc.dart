import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/snack_bar_utils.dart';
import '../../domain/entities/user_entity/user_entity.dart';
import '../../domain/use_cases/user_sign_in_case.dart';
import '../../domain/use_cases/user_sign_up_use_case.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required UserSignUpUseCase userSignUpUseCase,
    required UserSignInCase userSignInCase,
  }) : super(const _Initial()) {
    _userSignUpUseCase = userSignUpUseCase;
    _userSignInCase = userSignInCase;
    on<_SignUp>(_signUp);
    on<_SignIn>(_signIn);
  }

  late final UserSignUpUseCase _userSignUpUseCase;
  late final UserSignInCase _userSignInCase;

  FutureOr<void> _signUp(_SignUp event, Emitter<AuthState> emit) async {
    emit(const _Loading());
    final result = await _userSignUpUseCase(
      UserSignUpUseCaseParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    result.fold(
      (l) {
        emit(_Failure(message: l.message));
        showAppSnackBar(l.message);
      },
      (r) {
        emit(_Success(user: r));
      },
    );
  }

  FutureOr<void> _signIn(_SignIn event, Emitter<AuthState> emit) async {
    emit(const _Loading());
    final result = await _userSignInCase(
      UserSignInCaseParams(email: event.email, password: event.password),
    );
    result.fold(
      (l) {
        emit(_Failure(message: l.message));
        showAppSnackBar(l.message);
      },
      (r) {
        emit(_Success(user: r));
      },
    );
  }
}
