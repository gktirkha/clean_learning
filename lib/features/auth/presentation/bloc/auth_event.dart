part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.signup({
    required String name,
    required String email,
    required String password,
  }) = _SignUp;

  const factory AuthEvent.signIn({
    required String email,
    required String password,
  }) = _SignIn;

  const factory AuthEvent.checkLogin() = _CheckLogin;
  const factory AuthEvent.signOut() = _SignOut;
}
