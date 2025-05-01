import 'package:hive/hive.dart';
import 'package:the_write_blueprint/features/blog/data/models/blog_model.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;

  BlogLocalDataSourceImpl(this.box);

  @override
  List<BlogModel> loadBlogs() {
    try {
      // Use the injected box instance
      if (!box.isOpen) {
        throw Exception('Hive box "blogs" is not open');
      }
      List<BlogModel> blogs = [];
      for (var i = 0; i < box.length; i++) {
        final blogJson = box.get(i.toString());
        if (blogJson != null) {
          blogs.add(BlogModel.fromJson(Map<String, dynamic>.from(blogJson)));
        }
      }
      return blogs;
    } catch (e) {
      throw Exception('Failed to load blogs: $e');
    }
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    try {
      box.clear();
      for (var i = 0; i < blogs.length; i++) {
        box.put(i.toString(), blogs[i].toJson());
      }
    } catch (e) {
      throw Exception('Failed to upload blogs: $e');
    }
  }
}
