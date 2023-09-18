import 'package:calendar_pager/extensions/date_extensions.dart';
import 'package:calendar_pager/state/calendar_state.dart';
import 'package:calendar_pager/widgets/calendar_header.dart';
import 'package:calendar_pager/widgets/calendar_pager.dart';
import 'package:calendar_pager/widgets/calendar_row.dart';
import 'package:flutter/material.dart';

class CalendarPageBody extends StatefulWidget {
  const CalendarPageBody({super.key});

  @override
  State<CalendarPageBody> createState() => _CalendarPageBodyState();
}

class _CalendarPageBodyState extends State<CalendarPageBody> {
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
      selectedDate: DateTime.now(),
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
            CalendarHeader(date: state.selectedDate),
            CalendarSlider(
              pageController: _pageController,
              date: state.selectedDate,
              rows: state.weeks
                  .map(
                    (week) => CalendarRow(
                      week: week,
                      selectedDate: state.selectedDate,
                      onDayPressed: (day) => {},
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
