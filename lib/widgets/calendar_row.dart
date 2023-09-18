import 'package:flutter/material.dart';
import 'calendar_item.dart';

class CalendarRow extends StatelessWidget {
  final List<DateTime> week;
  final DateTime selectedDate;
  final Function(DateTime) onDayPressed;

  const CalendarRow({
    super.key,
    required this.week,
    required this.selectedDate,
    required this.onDayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
