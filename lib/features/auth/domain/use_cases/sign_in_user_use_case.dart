import 'package:injectable/injectable.dart';

import '../../../../core/common/entities/user_entity/user_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/auth_repository.dart';

@injectable
class SignInUserUseCase
    implements UseCase<UserEntity, SignInUserUseCaseParams> {
  SignInUserUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<FailableEither<UserEntity>> call(SignInUserUseCaseParams params) {
    return authRepository.signinWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInUserUseCaseParams {
  SignInUserUseCaseParams({required this.email, required this.password});
  final String email;
  final String password;
}
