import 'package:fpdart/fpdart.dart';
import 'package:the_write_blueprint/core/error/failure.dart';
import 'package:the_write_blueprint/core/usecase/usecase.dart';
import 'package:the_write_blueprint/core/common/entities/user.dart';
import 'package:the_write_blueprint/features/auth/domain/repository/auth_repository.dart';

class UserSignin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  UserSignin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return authRepository.signinWithEmailPassword(
        password: params.password, email: params.email);
  }
}

class UserLoginParams {
  final String email, password;

  UserLoginParams({required this.email, required this.password});
}
