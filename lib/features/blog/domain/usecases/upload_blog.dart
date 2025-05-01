import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:the_write_blueprint/core/error/failure.dart';
import 'package:the_write_blueprint/core/usecase/usecase.dart';
import 'package:the_write_blueprint/features/blog/domain/entities/blog.dart';
import 'package:the_write_blueprint/features/blog/domain/repositories/blog_repository.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
