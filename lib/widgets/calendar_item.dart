part of 'calendar_pager_view.dart';

class _CalendarItem extends StatelessWidget {
  final bool isSelectedDate;
  final DateTime date;
  final Function()? onPressed;
  final CalendarItemTheme theme;

  const _CalendarItem({
    super.key,
    required this.isSelectedDate,
    required this.date,
    this.onPressed,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          date.getDayName(),
          style: isSelectedDate ? theme.selectedDayNameText : theme.dayNameText,
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
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelectedDate
                        ? theme.selectedBorderColor
                        : theme.borderColor,
                    width: 3,
                  ),
                  shape: BoxShape.circle,
                  color: isSelectedDate
                      ? theme.selectedItemBackground
                      : theme.itemBackground,
                  boxShadow: [
                    if (theme.hasShadow)
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
                  style:
                      isSelectedDate ? theme.selectedDateText : theme.dateText,
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
              color: theme.currentDateIndicatorColor,
            ),
          ),
      ],
    );
  }
}
