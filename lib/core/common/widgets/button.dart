import 'package:flutter/material.dart';
import 'package:the_write_blueprint/core/theme/app_pallete.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final double? elevation;

  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 4.0,
    this.elevation = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        elevation: elevation,
        side: BorderSide.none,
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppPallete.gradient2, fontWeight: FontWeight.w700),
      ),
    );
  }
}
