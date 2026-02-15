import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/user_entity/user_entity.dart';
import '../repositories/auth_repository.dart';

class UserSignUpUseCase
    implements UseCase<UserEntity, UserSignUpUseCaseParams> {
  UserSignUpUseCase(this.authRepository);

  final AuthRepository authRepository;
  @override
  Future<FailableEither<UserEntity>> call(
    UserSignUpUseCaseParams params,
  ) async {
    return await authRepository.signupWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpUseCaseParams {
  UserSignUpUseCaseParams({
    required this.name,
    required this.email,
    required this.password,
  });
  final String name;
  final String email;
  final String password;
}
