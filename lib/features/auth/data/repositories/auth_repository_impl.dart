import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.remoteDataSource);
  final AuthRemoteDataSource remoteDataSource;

  @override
  Future<FailableEither<String>> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signinWithEmailPassword(
        email: email,
        password: password,
      );
      return Right(userId);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<FailableEither<String>> signupWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signupWithEmailPassword(
        email: email,
        password: password,
        name: name,
      );
      return Right(userId);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
