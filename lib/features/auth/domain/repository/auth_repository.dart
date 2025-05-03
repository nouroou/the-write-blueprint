import 'package:fpdart/fpdart.dart';
import 'package:the_write_blueprint/core/error/failure.dart';
import 'package:the_write_blueprint/core/common/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signupWithEmailPassword({
    required String name,
    required String username,
    required String password,
    required String email,
    required String avatarUrl,
  });
  Future<Either<Failure, User>> signinWithEmailPassword({
    required String password,
    required String email,
  });

  Future<Either<Failure, User>> currentUser();
}
