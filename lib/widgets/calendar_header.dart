import 'package:calendar_pager/extensions/date_extensions.dart';
import 'package:calendar_pager/widgets/style/calendar_pager_style.dart';
import 'package:flutter/material.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime date;
  final CalendarHeaderStyle style;

  const CalendarHeader({
    super.key,
    required this.date,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: style.headerBackground,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: style.alignment,
        children: [
          RichText(
            text: TextSpan(
              text: date.getMonthName(),
              style: style.primaryText,
              children: [
                TextSpan(
                  text: ' ${date.year.toString()}',
                  style: style.secondaryText,
                )
              ],
            ),
          ),
          if (style.hasCompleteDate) ...[
            const SizedBox(height: 8),
            Text(
              date.getCompleteDate(),
              style: style.completeDateText,
            ),
          ]
        ],
      ),
    );
  }
}
