import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting date and time

class CurrentDateTimeWidget extends StatelessWidget {
  final DateTime date;
  const CurrentDateTimeWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    DateTime now = DateTime.now();

    // Format date and time
    String formattedDate =
        DateFormat('yy/MM/dd').format(now); // Format: 2025-01-12
    String formattedTime = DateFormat('HH:mm').format(now); // Format: 14:30:45
    String todayDate = DateFormat('yy/MM/dd').format(now);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          formattedTime,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.color
                  ?.withOpacity(0.6)),
        ),
        if (formattedDate != todayDate)
          Row(
            children: [
              const SizedBox(width: 8),
              Text(
                formattedDate,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.color
                        ?.withOpacity(0.6)),
              ),
            ],
          )
        else
          Container(),
      ],
    );
  }
}
