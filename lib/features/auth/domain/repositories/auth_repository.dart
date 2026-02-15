import '../../../../core/error/failures.dart';
import '../entities/user_entity/user_entity.dart';

abstract interface class AuthRepository {
  Future<FailableEither<UserEntity>> signupWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<FailableEither<UserEntity>> signinWithEmailAndPassword({
    required String email,
    required String password,
  });
}
