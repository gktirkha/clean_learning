import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/common/entities/user_entity/user_entity.dart';
import '../../../../core/exceptions/exceptions.dart';
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
  Session? get session;
  Future<UserEntity?> getUserData();
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

  @override
  Session? get session => supabaseClient.auth.currentSession;

  @override
  Future<UserEntity?> getUserData() async {
    try {
      {
        if (session != null) {
          final data =
              (await supabaseClient
                      .from('profiles')
                      .select()
                      .eq('id', session!.user.id))
                  .first;

          return UserModel.fromJson(
            data,
          ).copyWith(email: session?.user.email ?? 'No Email Found');
        }
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
