import 'package:calendar_pager/extensions/date_extensions.dart';
import 'package:calendar_pager/widgets/theme/calendar_pager_theme.dart';
import 'package:flutter/material.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime date;
  final CalendarHeaderTheme theme;

  const CalendarHeader({
    super.key,
    required this.date,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: theme.headerBackground,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: theme.alignment,
        children: [
          RichText(
            text: TextSpan(
              text: date.getMonthName(),
              style: theme.primaryText,
              children: [
                TextSpan(
                  text: ' ${date.year.toString()}',
                  style: theme.secondaryText,
                )
              ],
            ),
          ),
          if (theme.hasCompleteDate) ...[
            const SizedBox(height: 8),
            Text(
              date.getCompleteDate(),
              style: theme.completeDateText,
            ),
          ]
        ],
      ),
    );
  }
}
