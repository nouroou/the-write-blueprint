import 'package:fpdart/fpdart.dart';
import 'package:the_write_blueprint/core/error/failure.dart';
import 'package:the_write_blueprint/core/usecase/usecase.dart';
import 'package:the_write_blueprint/features/blog/domain/entities/blog.dart';
import 'package:the_write_blueprint/features/blog/domain/repositories/blog_repository.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
