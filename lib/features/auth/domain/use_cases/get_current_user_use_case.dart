import 'package:injectable/injectable.dart';

import '../../../../core/common/entities/user_entity/user_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/auth_repository.dart';

@injectable
class GetCurrentUserUseCase implements UseCase<UserEntity?, NoParams> {
  GetCurrentUserUseCase(this.repository);

  final AuthRepository repository;

  @override
  Future<FailableEither<UserEntity>> call(NoParams params) async {
    return await repository.currentUser();
  }
}
