import 'package:blog_app/core/error/server_exception.dart';
import 'package:blog_app/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;
  @override
  Future<UserModel> loginInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const ServerException("user has null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw const ServerException("user has null!");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient.from('profiles').select().eq(
              'id',
              currentUserSession!.user.id,
            );

        return UserModel.fromJson(userData.first);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
