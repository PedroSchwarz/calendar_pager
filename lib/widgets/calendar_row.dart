part of 'calendar_pager_view.dart';

class _CalendarRow extends StatelessWidget {
  final List<DateTime> week;
  final Color background;
  final Color borderColor;
  final Widget Function(int, DateTime) itemBuilder;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;
  final Color? dateText;

  const _CalendarRow({
    super.key,
    required this.week,
    required this.background,
    required this.borderColor,
    required this.itemBuilder,
    required this.onPreviousWeek,
    required this.onNextWeek,
    this.dateText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        spacing: 8,
        children: [
          if (Platform.isMacOS)
            GestureDetector(
              onTap: onPreviousWeek,
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor, width: 3),
                  shape: BoxShape.circle,
                  color: background,
                ),
                child: Icon(Icons.chevron_left, color: dateText),
              ),
            ),
          ...week.indexed.map((item) => itemBuilder(item.$1, item.$2)),
          if (Platform.isMacOS)
            GestureDetector(
              onTap: onNextWeek,
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor, width: 3),
                  shape: BoxShape.circle,
                  color: background,
                ),
                child: Icon(Icons.chevron_right, color: dateText),
              ),
            ),
        ].toList(),
      ),
    );
  }
}
