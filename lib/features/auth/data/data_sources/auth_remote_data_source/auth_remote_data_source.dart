import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/common/entities/user_entity/user_entity.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserEntity> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserEntity> signinWithEmailPassword({
    required String email,
    required String password,
  });
  Session? get session;
  Future<UserEntity?> getUserData();
  Future<void> logout();
}
