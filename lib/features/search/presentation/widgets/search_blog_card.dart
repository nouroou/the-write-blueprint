import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:the_write_blueprint/core/common/widgets/blog_image.dart';
import 'package:the_write_blueprint/core/theme/app_pallete.dart';
import 'package:the_write_blueprint/core/common/widgets/time_ago.dart';
import 'package:the_write_blueprint/features/blog/domain/entities/blog.dart';
import 'package:the_write_blueprint/features/blog/presentation/pages/blog_view_page.dart';

class SearchBlogCard extends StatelessWidget {
  final Blog blog;
  const SearchBlogCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewPage.route(blog));
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _posterWidget(context),
                  SizedBox(height: 10),
                  _contentWidget(context),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _contentWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(width: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Icon(
                          FeatherIcons.bold,
                          size: 18,
                          color: AppPallete.gradient1,
                        ),
                        SizedBox(width: 12),
                        TimeAgoWidget(dateTime: blog.updatedAt),
                      ],
                    ),
                  ),
                  Icon(
                    FeatherIcons.moreVertical,
                    color: AppPallete.whiteColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: BlogImage(
              blogImage: blog.imageUrl,
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width / 5,
            ),
          ),
        ),
      ],
    );
  }

  Row _posterWidget(BuildContext context) {
    return Row(
      children: [
        Text(
          '1',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(width: 10),
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
}
