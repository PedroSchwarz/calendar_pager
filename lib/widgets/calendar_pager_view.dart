import 'package:calendar_pager/extensions/date_extensions.dart';
import 'package:calendar_pager/state/calendar_state.dart';
import 'package:calendar_pager/widgets/calendar_header.dart';
import 'package:calendar_pager/widgets/calendar_slider.dart';
import 'package:calendar_pager/widgets/calendar_row.dart';
import 'package:calendar_pager/widgets/theme/calendar_pager_theme.dart';
import 'package:flutter/material.dart';

class CalendarPagerView extends StatefulWidget {
  final CalendarPagerTheme theme;
  final bool hasHeader;
  final void Function(DateTime)? onDateSelected;
  final VoidCallback? onPreviousWeekFetched;
  final VoidCallback? onNextWeekFetched;

  const CalendarPagerView({
    super.key,
    required this.theme,
    this.hasHeader = true,
    this.onDateSelected,
    this.onPreviousWeekFetched,
    this.onNextWeekFetched,
  });

  @override
  State<CalendarPagerView> createState() => _CalendarPagerViewState();
}

class _CalendarPagerViewState extends State<CalendarPagerView> {
  final PageController _pageController = PageController(initialPage: 1);
  late CalendarState state;

  @override
  void initState() {
    super.initState();
    final currentDate = DateTime.now().getDateOnly();
    final startOfWeek = currentDate.getStartOfWeekFromDate();
    final currentWeek = startOfWeek.getWeekFromStartDate();
    final previouWeek = currentWeek.first.getPreviousWeek();
    final nextWeek = currentWeek.last.getNextWeek();
    state = CalendarState(
      selectedDate: currentDate,
      weeks: [previouWeek, currentWeek, nextWeek],
    );
    widget.onDateSelected!(currentDate);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      state = state.copyWith(selectedDate: date);
    });
    widget.onDateSelected!(date);
  }

  void _onFetchPreviousWeek() {
    final previousWeek = state.weeks.first.first.getPreviousWeek();
    setState(() {
      state = state.copyWith(weeks: [previousWeek, ...state.weeks]);
    });
    if (widget.onPreviousWeekFetched != null) {
      widget.onPreviousWeekFetched!();
    }
  }

  void _onFetchNextWeek() {
    final nextWeek = state.weeks.last.last.getNextWeek();
    setState(() {
      state = state.copyWith(weeks: [...state.weeks, nextWeek]);
    });
    if (widget.onNextWeekFetched != null) {
      widget.onNextWeekFetched!();
    }
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
                theme: widget.theme.headerTheme,
              ),
            CalendarSlider(
              pageController: _pageController,
              date: state.selectedDate,
              rows: state.weeks
                  .map(
                    (week) => CalendarRow(
                      week: week,
                      selectedDate: state.selectedDate,
                      onDayPressed: _onDateSelected,
                      theme: widget.theme,
                    ),
                  )
                  .toList(),
              onGoToFirstWeek: _onFetchPreviousWeek,
              onGoToLastPage: _onFetchNextWeek,
            ),
          ],
        ),
      ],
    );
  }
}
