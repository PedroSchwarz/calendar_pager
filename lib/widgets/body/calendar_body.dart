import 'package:calendar_pager/extensions/date_extensions.dart';
import 'package:calendar_pager/state/calendar_state.dart';
import 'package:calendar_pager/widgets/calendar_header.dart';
import 'package:calendar_pager/widgets/calendar_slider.dart';
import 'package:calendar_pager/widgets/calendar_row.dart';
import 'package:calendar_pager/widgets/style/calendar_pager_style.dart';
import 'package:flutter/material.dart';

class CalendarBody extends StatefulWidget {
  final CalendarPagerStyle style;
  final bool hasHeader;

  const CalendarBody({
    super.key,
    required this.style,
    this.hasHeader = true,
  });

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  final PageController _pageController = PageController(initialPage: 1);
  late CalendarState state;

  @override
  void initState() {
    super.initState();
    final startOfWeek = DateTime.now().getStartOfWeekFromDate();
    final currentWeek = startOfWeek.getWeekFromStartDate();
    final previouWeek = currentWeek.first.getPreviousWeek();
    final nextWeek = currentWeek.last.getNextWeek();
    state = CalendarState(
      selectedDate: DateTime.now().getDateOnly(),
      weeks: [previouWeek, currentWeek, nextWeek],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            if (widget.hasHeader)
              CalendarHeader(
                date: state.selectedDate,
                style: widget.style.headerStyle,
              ),
            CalendarSlider(
              pageController: _pageController,
              date: state.selectedDate,
              rows: state.weeks
                  .map(
                    (week) => CalendarRow(
                      week: week,
                      selectedDate: state.selectedDate,
                      onDayPressed: (day) => {},
                      style: widget.style.rowStyle,
                    ),
                  )
                  .toList(),
              onGoToFirstWeek: () {
                print('First');
              },
              onGoToLastPage: () {
                print('Last');
              },
            ),
          ],
        ),
      ],
    );
  }
}
