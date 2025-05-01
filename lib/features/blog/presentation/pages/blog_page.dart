import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_write_blueprint/core/common/widgets/custom_app_bar.dart';
import 'package:the_write_blueprint/core/common/widgets/loader.dart';
import 'package:the_write_blueprint/core/utils/show_snackbar.dart';
import 'package:the_write_blueprint/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:the_write_blueprint/features/blog/presentation/pages/add_new_blog.dart';
import 'package:the_write_blueprint/features/blog/presentation/widgets/blog_card.dart';
import 'package:the_write_blueprint/features/notifications/presentation/pages/notifications_page.dart';
import 'package:the_write_blueprint/home_page.dart';

class BlogPage extends StatefulWidget {
  static route(BuildContext context) =>
      MaterialPageRoute(builder: (context) => const HomePage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Home',
          hasTabs: true,
          actionButton: _notificationsButton(context),
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackbar(context, state.error, true);
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            }
            if (state is BlogDisplaySuccess) {
              return TabBarView(
                children: [
                  ListView.builder(
                    itemCount: state.blogs.length,
                    itemBuilder: (context, index) {
                      final blog = state.blogs[index];
                      return Column(
                        children: [
                          BlogCard(blog: blog),
                          Divider(thickness: 0.5)
                        ],
                      );
                    },
                  ),
                  Center(child: Text('Following'))
                ],
              );
            }
            return SizedBox();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, AddNewBlogPage.route()),
          child: Icon(
            FeatherIcons.penTool,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }

  IconButton _notificationsButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(context, NotificationsPage.route());
        },
        icon: Icon(FeatherIcons.bell));
  }
}
