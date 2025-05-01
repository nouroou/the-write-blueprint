import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:the_write_blueprint/core/common/network/connection_checker.dart';
import 'package:the_write_blueprint/core/error/exceptions.dart';
import 'package:the_write_blueprint/core/error/failure.dart';
import 'package:the_write_blueprint/core/utils/constants.dart';
import 'package:the_write_blueprint/features/blog/data/models/blog_model.dart';
import 'package:the_write_blueprint/features/blog/data/sources/blog_local_data_source.dart';
import 'package:the_write_blueprint/features/blog/data/sources/blog_remote_data_source.dart';
import 'package:the_write_blueprint/features/blog/domain/entities/blog.dart';
import 'package:the_write_blueprint/features/blog/domain/repositories/blog_repository.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl(this.blogRemoteDataSource, this.blogLocalDataSource,
      this.connectionChecker);
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        left(Failure(Constants.noConnectionErrorMessage));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on Exceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);

      return right(blogs);
    } on Exceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
