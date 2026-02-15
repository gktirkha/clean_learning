import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../domain/entities/user_entity/user_entity.dart';

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
}

class SupabaseRemoteDataSource implements AuthRemoteDataSource {
  SupabaseRemoteDataSource(this.supabaseClient);

  final SupabaseClient supabaseClient;

  @override
  Future<UserEntity> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user == null) {
        throw ServerException('User is null');
      }

      return UserEntity.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserEntity> signinWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw ServerException('User is null');
      }

      return UserEntity.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
