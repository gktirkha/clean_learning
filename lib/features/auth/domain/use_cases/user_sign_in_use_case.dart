import '../../../../core/common/entities/user_entity/user_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/auth_repository.dart';

class UserUseSignInCase implements UseCase<UserEntity, UserSignInCaseParams> {
  UserUseSignInCase(this.authRepository);

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
