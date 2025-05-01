import 'package:flutter/material.dart';
import 'package:the_write_blueprint/core/common/widgets/blog_image.dart';
import 'package:the_write_blueprint/core/common/widgets/time_ago.dart';
import 'package:the_write_blueprint/core/theme/app_pallete.dart';
import 'package:the_write_blueprint/core/utils/calculate_reading_time.dart';
import 'package:the_write_blueprint/features/blog/domain/entities/blog.dart';

class BlogViewPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
      builder: (context) => BlogViewPage(
            blog: blog,
          ));

  final Blog blog;

  const BlogViewPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlogImage(
                  blogImage: blog.imageUrl,
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(height: 20),
                Text(
                  blog.title,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    CircleAvatar(),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'By ${blog.posterName}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppPallete.whiteColor),
                        ),
                        Row(
                          children: [
                            Text('${calculateReadingTime(blog.content)} read '),
                            Text('•'),
                            TimeAgoWidget(dateTime: blog.updatedAt),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(blog.content,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(height: 1.8)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
