import 'package:fpdart/fpdart.dart';
import 'package:the_write_blueprint/core/error/failure.dart';
import 'package:the_write_blueprint/core/usecase/usecase.dart';
import 'package:the_write_blueprint/core/common/entities/user.dart';
import 'package:the_write_blueprint/features/auth/domain/repository/auth_repository.dart';

class UserSignup implements UseCase<User, UserSignupParams> {
  final AuthRepository authRepository;

  const UserSignup(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async {
    return await authRepository.signupWithEmailPassword(
      name: params.name,
      username: params.username,
      password: params.password,
      email: params.email,
      avatarUrl: params.avatarUrl,
    );
  }
}

class UserSignupParams {
  final String email, password, username, name, avatarUrl;

  UserSignupParams({
    required this.email,
    required this.password,
    required this.username,
    required this.name,
    required this.avatarUrl,
  });
}
