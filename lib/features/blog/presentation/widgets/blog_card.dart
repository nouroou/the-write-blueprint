import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:the_write_blueprint/core/common/widgets/blog_image.dart';
import 'package:the_write_blueprint/core/theme/app_pallete.dart';
import 'package:the_write_blueprint/core/common/widgets/time_ago.dart';
import 'package:the_write_blueprint/features/blog/domain/entities/blog.dart';
import 'package:the_write_blueprint/features/blog/presentation/pages/blog_view_page.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  const BlogCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewPage.route(blog));
      },
      child: Container(
        margin: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _posterWidget(context),
                  SizedBox(height: 16),
                  _contentWidget(context),
                  SizedBox(height: 16),
                  _countersWidget(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _countersWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                FeatherIcons.bold,
                size: 18,
                color: AppPallete.gradient1,
              ),
              SizedBox(width: 12),
              TimeAgoWidget(dateTime: blog.updatedAt),
              SizedBox(width: 12),
              _likesWidget(context),
              SizedBox(width: 12),
              _repliesWidget(context),
            ],
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                FeatherIcons.minusCircle,
                color: AppPallete.whiteColor,
              ),
              SizedBox(width: 12),
              Icon(
                FeatherIcons.moreVertical,
                color: AppPallete.whiteColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _contentWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 12),
              Text(
                blog.content,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: BlogImage(
            blogImage: blog.imageUrl,
            height: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width / 4,
          ),
        )
      ],
    );
  }

  Row _posterWidget(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: AppPallete.greyColor,
          child: Icon(
            FeatherIcons.user,
            size: 18,
            color: AppPallete.backgroundColor,
          ),
        ),
        SizedBox(width: 10),
        Text(
          blog.posterName ?? '',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Flexible _repliesWidget(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FeatherIcons.messageCircle,
            size: 18,
            color: AppPallete.whiteColor,
          ),
          SizedBox(width: 6),
          Text(
            '1',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Flexible _likesWidget(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FeatherIcons.heart,
            size: 18,
            color: AppPallete.whiteColor,
          ),
          SizedBox(width: 6),
          Text(
            '12',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
