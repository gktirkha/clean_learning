import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/common/entities/user_entity/user_entity.dart';
import '../../../../../core/exceptions/exceptions.dart';
import '../../models/user_model/user_model.dart';
import 'auth_remote_data_source.dart';
import 'auth_remote_data_source_types.dart';

@Named(AuthRemoteDataSourceTypes.mock)
@Injectable(as: AuthRemoteDataSource)
class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<UserEntity> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return UserModel(id: 'mock_id', email: email, name: name);
  }

  @override
  Future<UserEntity> signinWithEmailPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    if (password == 'password') {
      return UserModel(id: 'mock_id', email: email, name: 'Mock User');
    } else {
      throw ServerException('Invalid credentials');
    }
  }

  @override
  Session? get session => null;

  @override
  Future<UserEntity?> getUserData() async {
    return const UserModel(
      id: 'mock_id',
      email: 'mock@example.com',
      name: 'Mock User',
    );
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
