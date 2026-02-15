import 'package:injectable/injectable.dart';

import '../../../../core/common/entities/user_entity/user_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/auth_repository.dart';

@injectable
class SignUpUserUseCase
    implements UseCase<UserEntity, SignUpUserUseCaseParams> {
  SignUpUserUseCase(this.authRepository);

  final AuthRepository authRepository;
  @override
  Future<FailableEither<UserEntity>> call(
    SignUpUserUseCaseParams params,
  ) async {
    return await authRepository.signupWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpUserUseCaseParams {
  SignUpUserUseCaseParams({
    required this.name,
    required this.email,
    required this.password,
  });
  final String name;
  final String email;
  final String password;
}
