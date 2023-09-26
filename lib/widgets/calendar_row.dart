part of 'calendar_pager_view.dart';

class _CalendarRow extends StatelessWidget {
  final List<DateTime> week;
  final Color background;
  final Widget Function(int, DateTime) itemBuilder;

  const _CalendarRow({
    super.key,
    required this.week,
    required this.background,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: week.indexed
            .map(
              (item) => itemBuilder(
                item.$1,
                item.$2,
              ),
            )
            .toList(),
      ),
    );
  }
}
