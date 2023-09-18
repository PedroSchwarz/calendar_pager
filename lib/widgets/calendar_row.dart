import 'package:calendar_pager/calendar_pager.dart';
import 'package:flutter/material.dart';
import 'calendar_item.dart';

class CalendarRow extends StatelessWidget {
  final List<DateTime> week;
  final DateTime selectedDate;
  final Function(DateTime) onDayPressed;
  final CalendarRowStyle style;

  const CalendarRow({
    super.key,
    required this.week,
    required this.selectedDate,
    required this.onDayPressed,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: style.rowBackground,
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
            );
          },
        ).toList(),
      ),
    );
  }
}
