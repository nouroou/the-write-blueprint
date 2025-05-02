import 'package:fpdart/fpdart.dart';
import 'package:the_write_blueprint/core/error/failure.dart';

abstract interface class UseCase<SuccesType, Params> {
  Future<Either<Failure, SuccesType>> call(Params params);
}

class NoParams {}
