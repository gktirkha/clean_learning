import '../../../../core/common/entities/user_entity/user_entity.dart';
import '../../../../core/error/failures.dart';

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

  Future<FailableEither<UserEntity>> currentUser();
}
