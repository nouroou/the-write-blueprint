import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:the_write_blueprint/core/theme/app_pallete.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget actionButton;
  final bool hasTabs;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.hasTabs,
    required this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 120,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      centerTitle: false,
      actions: [actionButton],
      bottom: hasTabs
          ? PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      FeatherIcons.plus,
                      color: AppPallete.gradient3,
                    ),
                    onPressed: () {
                      // Action for the "+" icon
                    },
                  ),
                  Expanded(
                    child: TabBar(
                      isScrollable:
                          true, // Ensure tabs can be scrolled if content overflows

                      tabAlignment: TabAlignment.start,
                      tabs: const [
                        Tab(text: "For You"),
                        Tab(text: "Following"),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
