import 'package:flutter/material.dart';
import 'package:the_write_blueprint/core/common/widgets/snackbar.dart';
import 'package:the_write_blueprint/core/error/user_friendly_error.dart';

void showSnackbar(BuildContext context, String content, bool isError) {
  String userFriendlyMessage = parseSupabaseError(content);

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      CustomSnackBar(
        content: userFriendlyMessage,
        isError: isError,
      ),
    );
}
