import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_write_blueprint/core/theme/app_pallete.dart'; // Make sure to import this package

class TimeAgoWidget extends StatelessWidget {
  final DateTime dateTime;

  const TimeAgoWidget({super.key, required this.dateTime});

  String timeAgo(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);

    // Check if the year of the date is different from the current year
    if (dateTime.year != DateTime.now().year) {
      return DateFormat('MMM dd, yyyy')
          .format(dateTime); // Format to "mmm dd, yyyy"
    }

    // Time ago logic for the current year
    if (difference.inSeconds < 60) {
      return "${difference.inSeconds}s";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}min";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h";
    } else if (difference.inDays < 30) {
      return "${difference.inDays}d";
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return "$months ${months == 1 ? "month" : "months"} ago";
    } else {
      final years = (difference.inDays / 365).floor();
      return "$years ${years == 1 ? "year" : "years"} ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timeAgo(dateTime),
      style: TextStyle(
        color: AppPallete.whiteColor,
        fontSize: 14,
      ),
    );
  }
}
