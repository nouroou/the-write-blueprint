import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:the_write_blueprint/features/blog/presentation/pages/blog_page.dart';
import 'package:the_write_blueprint/features/profile/presentation/pages/profile_page.dart';
import 'package:the_write_blueprint/features/saved/presentation/pages/saved_page.dart';
import 'package:the_write_blueprint/features/search/presentation/pages/search_page.dart';

class HomePage extends StatefulWidget {
  static route(BuildContext context) =>
      MaterialPageRoute(builder: (context) => const HomePage());
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BlogPage(),
    SearchPage(),
    SavedPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, // Set the selected tab
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Update the selected tab
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(FeatherIcons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(FeatherIcons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(FeatherIcons.bookmark), label: 'Saved'),
            BottomNavigationBarItem(
                icon: Icon(FeatherIcons.user), label: 'Profile'),
          ]),
    );
  }
}
