import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:the_write_blueprint/core/common/widgets/custom_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        hasTabs: false,
        actionButton: _settingsButton(context),
      ),
    );
  }

  IconButton _settingsButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          //Navigator.push(context, NotificationsPage.route());
        },
        icon: Icon(FeatherIcons.settings));
  }
}
