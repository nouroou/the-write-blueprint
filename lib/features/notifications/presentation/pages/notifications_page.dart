import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => NotificationsPage());
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
