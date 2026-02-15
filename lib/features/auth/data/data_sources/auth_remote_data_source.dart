import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exceptions/exceptions.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> signinWithEmailPassword({
    required String email,
    required String password,
  });
}

class SupabaseRemoteDataSource implements AuthRemoteDataSource {
  SupabaseRemoteDataSource(this.supabaseClient);

  final SupabaseClient supabaseClient;

  @override
  Future<String> signupWithEmailPassword({
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

      return response.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> signinWithEmailPassword({
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

      return response.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
