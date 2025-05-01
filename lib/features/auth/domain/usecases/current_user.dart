// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:the_write_blueprint/core/error/failure.dart';
import 'package:the_write_blueprint/core/usecase/usecase.dart';
import 'package:the_write_blueprint/core/common/entities/user.dart';
import 'package:the_write_blueprint/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  AuthRepository authRepository;

  CurrentUser(
    this.authRepository,
  );

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
