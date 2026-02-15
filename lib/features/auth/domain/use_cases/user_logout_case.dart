import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/auth_repository.dart';

@injectable
class UserLogoutCase implements UseCase<void, NoParams> {
  UserLogoutCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<FailableEither<void>> call(NoParams params) {
    return authRepository.signOut().then((value) => Right(value));
  }
}
