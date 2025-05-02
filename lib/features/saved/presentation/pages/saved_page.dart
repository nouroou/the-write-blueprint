import 'package:flutter/material.dart';
import 'package:the_write_blueprint/core/common/widgets/custom_app_bar.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        hasTabs: false,
        title: 'Explore',
        actionButton: _newListButton(),
      ),
    );
  }

  ElevatedButton _newListButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text('New List'),
    );
  }
}
