import 'dart:io';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_write_blueprint/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:the_write_blueprint/core/common/widgets/button.dart';
import 'package:the_write_blueprint/core/common/widgets/loader.dart';
import 'package:the_write_blueprint/core/theme/app_pallete.dart';
import 'package:the_write_blueprint/core/utils/constants.dart';
import 'package:the_write_blueprint/core/utils/pick_image.dart';
import 'package:the_write_blueprint/core/utils/show_snackbar.dart';
import 'package:the_write_blueprint/core/common/widgets/time_and_date.dart';
import 'package:the_write_blueprint/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:the_write_blueprint/features/blog/presentation/pages/blog_page.dart';
import 'package:the_write_blueprint/features/blog/presentation/widgets/blog_editor.dart';
import 'package:the_write_blueprint/features/blog/presentation/widgets/upload_blog_image.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final _sizedBox = SizedBox(height: 16);
  final blogTitleController = TextEditingController();
  final blogContentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? image;
  final List<String> _selectedTopics = [];

  void _pickImage() async {
    final pickedImage = await pickAndCompressImage(context);

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    blogContentController.dispose();
    blogTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackbar(context, state.error, true);
            } else if (state is BlogUploadSuccess) {
              showSnackbar(context, 'Blog Posted', false);
              Navigator.pushAndRemoveUntil(
                  context, BlogPage.route(context), (route) => false);
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (image != null)
                      _uploadedImageWidget(context)
                    else
                      GestureDetector(
                        onTap: _pickImage,
                        child: UploadBlogImage(),
                      ),
                    _sizedBox,
                    _blogCategories(),
                    _sizedBox,
                    BlogEditor(
                        blogController: blogTitleController,
                        hintText: 'Title…'),
                    _sizedBox,
                    BlogEditor(
                        blogController: blogContentController,
                        hintText: 'Write something'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  SizedBox _uploadedImageWidget(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    image!,
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppPallete.backgroundColor
                    .withOpacity(0.8), // Background color
                shape: BoxShape.circle, // Circular shape for a round button
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (image != null) {
                      image = null;
                    }
                  });
                },
                child: Icon(
                  FeatherIcons.x,
                  size: 18,
                  color: AppPallete.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _draftDateTimeWidget(context),
      actions: [
        SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomElevatedButton(
            label: 'POST',
            onPressed: () => _uploadBlog(),
          ),
        ),
      ],
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(FeatherIcons.x),
      ),
    );
  }

  Column _draftDateTimeWidget(BuildContext context) {
    return Column(
      children: [
        Text(
          'Draft',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color
                  ?.withOpacity(0.8)),
        ),
        CurrentDateTimeWidget(date: DateTime.now()),
      ],
    );
  }

  Widget _blogCategories() {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: Constants.topicsList
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: GestureDetector(
                      onTap: () {
                        if (!_selectedTopics.contains(e) &&
                            _selectedTopics.length < 5) {
                          _selectedTopics.add(e);
                        } else {
                          _selectedTopics.remove(e);
                        }
                        setState(() {});
                      },
                      child: Chip(
                        label: Text(
                          e,
                          style: _selectedTopics.contains(e)
                              ? Theme.of(context).textTheme.bodyMedium
                              : Theme.of(context).primaryTextTheme.bodyMedium,
                        ),
                        color: _selectedTopics.contains(e)
                            ? WidgetStatePropertyAll(AppPallete.gradient1)
                            : null,
                        side: _selectedTopics.contains(e)
                            ? BorderSide.none
                            : BorderSide(
                                color: AppPallete.borderColor,
                              ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 10),
        if (_selectedTopics.length == 5)
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '5 is the max selected topics',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppPallete.errorColor),
            ),
          )
      ],
    );
  }

  void _uploadBlog() {
    if (formKey.currentState!.validate() && image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(
            BlogUpload(
              posterId: posterId,
              title: blogTitleController.text.trim(),
              content: blogContentController.text.trim(),
              image: image!,
              topics: _selectedTopics,
            ),
          );
    }
  }
}
