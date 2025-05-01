import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_write_blueprint/core/error/exceptions.dart';
import 'package:the_write_blueprint/core/utils/supa_base_constants.dart';
import 'package:the_write_blueprint/features/blog/data/models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl extends BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await supabaseClient
          .from(SupaBaseConstants.supabaseBlogTableName)
          .insert(blog.toJson())
          .select();
      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch (e) {
      throw Exceptions(e.message);
    } catch (e) {
      throw Exceptions(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage
          .from(SupaBaseConstants.supabaseBlogBucketName)
          .upload(blog.id, image);
      return supabaseClient.storage
          .from(SupaBaseConstants.supabaseBlogBucketName)
          .getPublicUrl(blog.id);
    } on StorageException catch (e) {
      throw Exceptions(e.message);
    } catch (e) {
      throw Exceptions(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await supabaseClient
          .from(SupaBaseConstants.supabaseBlogTableName)
          .select('*, ${SupaBaseConstants.supabaseUserTableName} (name)');
      return blogs
          .map((blog) => BlogModel.fromJson(blog).copyWith(
                posterName: blog[SupaBaseConstants.supabaseUserTableName]
                    ['name'],
              ))
          .toList();
    } on PostgrestException catch (e) {
      throw Exceptions(e.message);
    } catch (e) {
      throw Exceptions(e.toString());
    }
  }
}
