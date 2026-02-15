import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_entity/user_entity.dart';
import '../../domain/use_cases/user_sign_up_use_case.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required UserSignUpUseCase userSignUpUseCase})
    : super(const _Initial()) {
    on<_SignUp>(_signUp);
    _userSignUpUseCase = userSignUpUseCase;
  }

  late UserSignUpUseCase _userSignUpUseCase;

  FutureOr<void> _signUp(_SignUp event, Emitter<AuthState> emit) async {
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
      },
      (r) {
        emit(_Success(uid: r));
      },
    );
  }
}
