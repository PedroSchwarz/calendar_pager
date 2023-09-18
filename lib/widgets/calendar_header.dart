import 'package:calendar_pager/extensions/date_extensions.dart';
import 'package:flutter/material.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime date;
  final Color? primary;
  final Color? secondary;

  const CalendarHeader(
      {super.key, required this.date, this.primary, this.secondary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                // Primary
                text: TextSpan(
                  text: date.getMonthName(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  // Secondary
                  children: [
                    TextSpan(
                      text: ' ${date.year.toString()}',
                      style: const TextStyle(fontSize: 24),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Text(
              //   date.getCompleteDate(),
              //   style: theme.typography.p4,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
