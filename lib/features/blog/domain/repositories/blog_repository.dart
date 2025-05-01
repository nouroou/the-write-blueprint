import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:the_write_blueprint/core/error/failure.dart';
import 'package:the_write_blueprint/features/blog/domain/entities/blog.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });

  Future<Either<Failure, List<Blog>>> getAllBlogs();
}
