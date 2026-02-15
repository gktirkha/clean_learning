import '../../../../core/error/failures.dart';

abstract interface class AuthRepository {
  Future<FailableEither<String>> signupWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<FailableEither<String>> signinWithEmailAndPassword({
    required String email,
    required String password,
  });
}
