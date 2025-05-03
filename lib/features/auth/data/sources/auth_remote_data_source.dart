// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_write_blueprint/core/error/exceptions.dart';
import 'package:the_write_blueprint/core/utils/supa_base_constants.dart';
import 'package:the_write_blueprint/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signupWithEmailPassword({
    required String name,
    required String username,
    required String password,
    required String email,
    required String avatarUrl,
  });

  Future<UserModel> signinWithEmailPassword({
    required String password,
    required String email,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({
    required this.supabaseClient,
  });

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signinWithEmailPassword({
    required String password,
    required String email,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      // ignore: unnecessary_null_comparison
      if (response == null) {
        throw const Exceptions('User is Null');
      }
      return UserModel.fromJson(response.user!.toJson()).copyWith(
        email: currentUserSession!.user.email,
      );
    } on AuthException catch (e) {
      throw Exceptions(e.message);
    } catch (e) {
      throw Exceptions(e.toString());
    }
  }

  @override
  Future<UserModel> signupWithEmailPassword({
    required String name,
    required String username,
    required String password,
    required String email,
    required String avatarUrl,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
          'username': username,
          'avatar_url': avatarUrl,
        },
      );
      // ignore: unnecessary_null_comparison
      if (response == null) {
        throw const Exceptions('User is Null');
      }
      return UserModel.fromJson(response.user!.toJson()).copyWith(
        email: currentUserSession!.user.email,
      );
    } on AuthException catch (e) {
      throw Exceptions(e.message);
    } catch (e) {
      throw Exceptions(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from(SupaBaseConstants.supabaseUserTableName)
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
        );
      }
      return null;
    } catch (e) {
      throw Exceptions(e.toString());
    }
  }
}
