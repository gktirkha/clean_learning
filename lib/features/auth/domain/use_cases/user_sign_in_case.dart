import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/user_entity/user_entity.dart';
import '../repositories/auth_repository.dart';

class UserSignInCase implements UseCase<UserEntity, UserSignInCaseParams> {
  UserSignInCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<FailableEither<UserEntity>> call(UserSignInCaseParams params) {
    return authRepository.signinWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInCaseParams {
  UserSignInCaseParams({required this.email, required this.password});
  final String email;
  final String password;
}
