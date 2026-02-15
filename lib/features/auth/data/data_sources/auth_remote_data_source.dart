import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../domain/entities/user_entity/user_entity.dart';
import '../model/user_model/user_model.dart';

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
    return _getUser(
      () async => await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      ),
    );
  }

  @override
  Future<UserEntity> signinWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<UserEntity> _getUser(Future<AuthResponse> Function() fn) async {
    try {
      final response = await fn();

      final user = response.user;
      if (user == null) {
        throw ServerException('User is null');
      }

      return UserModel(
        id: user.id,
        email: user.email ?? 'Email Not Found',
        name: response.user?.userMetadata?['name'] ?? 'Name Not Found',
      );
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
