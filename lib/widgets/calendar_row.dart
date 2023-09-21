import 'package:calendar_pager/widgets/theme/calendar_pager_theme.dart';
import 'package:flutter/material.dart';
import 'calendar_item.dart';

class CalendarRow extends StatelessWidget {
  final List<DateTime> week;
  final DateTime selectedDate;
  final Function(DateTime) onDayPressed;
  final CalendarPagerTheme theme;

  const CalendarRow({
    super.key,
    required this.week,
    required this.selectedDate,
    required this.onDayPressed,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.background,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: week.map(
          (day) {
            final isSelectedDate = selectedDate.isAtSameMomentAs(day);
            return CalendarItem(
              isSelectedDate: isSelectedDate,
              date: day,
              onPressed: selectedDate == day ? null : () => onDayPressed(day),
              theme: theme.itemTheme,
            );
          },
        ).toList(),
      ),
    );
  }
}
