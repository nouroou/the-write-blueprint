import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController blogController;
  final String hintText;
  const BlogEditor(
      {super.key, required this.blogController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: blogController,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      maxLines: null,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is empty';
        } else {
          return null;
        }
      },
    );
  }
}
