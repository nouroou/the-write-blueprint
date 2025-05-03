import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:the_write_blueprint/core/theme/app_pallete.dart';

class SearchField extends StatelessWidget {
  final TextEditingController searchController;
  const SearchField({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      decoration: InputDecoration(
          prefixIcon: Icon(FeatherIcons.search),
          prefixIconColor: AppPallete.whiteColor,
          hintText: 'Search…'),
    );
  }
}
