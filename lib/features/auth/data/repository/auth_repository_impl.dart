import 'package:fpdart/fpdart.dart';
import 'package:the_write_blueprint/core/common/network/connection_checker.dart';
import 'package:the_write_blueprint/core/error/exceptions.dart';
import 'package:the_write_blueprint/core/error/failure.dart';
import 'package:the_write_blueprint/core/utils/constants.dart';
import 'package:the_write_blueprint/features/auth/data/models/user_model.dart';
import 'package:the_write_blueprint/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:the_write_blueprint/core/common/entities/user.dart';
import 'package:the_write_blueprint/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;

  const AuthRepositoryImpl(
    this.authRemoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, User>> signinWithEmailPassword({
    required String password,
    required String email,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.signinWithEmailPassword(
        password: password,
        email: email,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signupWithEmailPassword({
    required String name,
    required String username,
    required String password,
    required String email,
    required String avatarUrl,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.signupWithEmailPassword(
        name: name,
        username: username,
        password: password,
        email: email,
        avatarUrl: avatarUrl,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final user = await fn();

      return Right(user);
    } on Exceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = authRemoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failure('User not logged in!'));
        }
        return right(UserModel(
            email: session.user.email ?? '',
            name: '',
            username: '',
            avatarUrl: '',
            id: session.user.id));
      }
      final user = await authRemoteDataSource.getCurrentUserData();

      if (user == null) {
        return left(Failure('User not logged in!'));
      }

      return right(user);
    } on Exceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
