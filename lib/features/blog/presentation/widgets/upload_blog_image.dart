import 'package:dotted_border/dotted_border.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:the_write_blueprint/core/theme/app_pallete.dart';

class UploadBlogImage extends StatelessWidget {
  const UploadBlogImage({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [12, 6],
      radius: Radius.circular(8),
      borderType: BorderType.RRect,
      color: AppPallete.borderColor,
      strokeWidth: 2,
      strokeCap: StrokeCap.round,
      child: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FeatherIcons.upload,
              size: 48,
              color: Theme.of(context).iconTheme.color,
            ),
            SizedBox(height: 20),
            Text(
              'Select Your Image',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
