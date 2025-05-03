import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_write_blueprint/core/common/widgets/custom_app_bar.dart';
import 'package:the_write_blueprint/core/common/widgets/loader.dart';
import 'package:the_write_blueprint/core/theme/app_pallete.dart';
import 'package:the_write_blueprint/core/utils/constants.dart';
import 'package:the_write_blueprint/core/utils/show_snackbar.dart';
import 'package:the_write_blueprint/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:the_write_blueprint/features/search/presentation/widgets/search_blog_card.dart';
import 'package:the_write_blueprint/features/search/presentation/widgets/search_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          hasTabs: false, title: 'Explore', actionButton: Container()),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(searchController: searchController),
            Constants().sizedHeight,
            _searchSuggestedTopics(),
            Constants().sizedHeight,
            Text('Trending for Entrepreneurs',
                style: Theme.of(context).textTheme.bodyLarge),
            Constants().sizedHeight,
            BlocConsumer<BlogBloc, BlogState>(
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
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.blogs.length,
                      itemBuilder: (context, index) {
                        final blog = state.blogs[index];
                        return Column(
                          children: [
                            SearchBlogCard(blog: blog),
                            Divider(thickness: 0.5)
                          ],
                        );
                      },
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _searchSuggestedTopics() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: Constants.topicsList
            .map((e) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Chip(
                    label: Text(e),
                    color: WidgetStatePropertyAll(AppPallete.borderColor),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
