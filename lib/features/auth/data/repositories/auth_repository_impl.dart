import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../domain/entities/user_entity/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.remoteDataSource);
  final AuthRemoteDataSource remoteDataSource;

  @override
  Future<FailableEither<UserEntity>> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _getUser(
      () async => await remoteDataSource.signinWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<FailableEither<UserEntity>> signupWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _getUser(
      () async => await remoteDataSource.signupWithEmailPassword(
        email: email,
        password: password,
        name: name,
      ),
    );
  }

  Future<FailableEither<UserEntity>> _getUser(
    Future<UserEntity> Function() fn,
  ) async {
    try {
      final user = await fn();
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
