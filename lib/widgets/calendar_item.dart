import 'package:calendar_pager/extensions/date_extensions.dart';
import 'package:flutter/material.dart';

class CalendarItem extends StatelessWidget {
  final bool isSelectedDate;
  final DateTime date;
  final Function()? onPressed;

  const CalendarItem({
    super.key,
    required this.isSelectedDate,
    required this.date,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          date.getDayName(),
          style: TextStyle(
            fontWeight: isSelectedDate ? FontWeight.bold : null,
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            GestureDetector(
              onTap: onPressed,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 40,
                width: 40,
                alignment: Alignment.center,
                // Context primary
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black26,
                    width: 3,
                  ),
                  shape: BoxShape.circle,
                  // Context primary and background secondary
                  color: isSelectedDate ? Colors.amber : Colors.black26,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    // Is Selected
                    fontSize: 16,
                    fontWeight: isSelectedDate ? FontWeight.bold : null,
                    color: isSelectedDate ? Colors.white : Colors.amber,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (date.getIsCurrentDate())
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.amber,
            ),
          ),
      ],
    );
  }
}
