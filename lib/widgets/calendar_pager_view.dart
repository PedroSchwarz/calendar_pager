import 'package:calendar_pager/state/calendar_state.dart';
import 'package:calendar_pager/utils/extensions/date_extensions.dart';
import 'package:calendar_pager/widgets/theme/calendar_pager_theme.dart';
import 'package:flutter/material.dart';

part 'calendar_slider.dart';
part 'calendar_row.dart';
part 'calendar_item.dart';
part 'calendar_header.dart';
part '../utils/constants/widgets_constants.dart';

class CalendarPagerView extends StatefulWidget {
  final CalendarPagerTheme theme;
  final bool hasHeader;
  final bool isSnapping;
  final DateTime? initialDate;
  final void Function(DateTime)? onDateSelected;
  final VoidCallback? onPreviousWeekFetched;
  final VoidCallback? onNextWeekFetched;

  /// Calendar Pager Widget.
  ///
  /// [theme] Widget's theming object.
  ///
  /// [hasHeader] Boolean used to show/hide the date header.
  /// * Header involves Month - Year and complete date as subtitle.
  /// * Optional.
  /// * Default value is [true]
  ///
  /// [isSnapping] Boolean used to determine the physics of the underlying [PageView].
  /// * Optional.
  /// * Default value is [true].
  ///
  /// [initialDate] Initial optional value that determines the initial selected date.
  /// * Optional.
  /// * Default value is [null].
  ///
  /// [onDateSelected] Callback function that passes the selected date.
  /// * Optional.
  /// * Default value is [null].
  ///
  /// [onPreviousWeekFetched] Listener function that's triggered when the previous week is fetched.
  /// * Optional.
  /// * Default value is [null].
  ///
  /// [onNextWeekFetched] Listener function that's triggered when the next week is fetched.
  /// * Optional.
  /// * Default value is [null].
  const CalendarPagerView({
    super.key,
    required this.theme,
    this.hasHeader = true,
    this.isSnapping = true,
    this.initialDate,
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
    DateTime currentDate = (widget.initialDate ?? DateTime.now()).getDateOnly();
    final startOfWeek = currentDate.getStartOfWeekFromDate();
    final currentWeek = startOfWeek.getWeekFromStartDate();
    final previouWeek = currentWeek.first.getPreviousWeek();
    final nextWeek = currentWeek.last.getNextWeek();
    state = CalendarState(
      selectedDate: currentDate,
      weeks: [previouWeek, currentWeek, nextWeek],
    );
    widget.onDateSelected?.call(currentDate);
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
    widget.onDateSelected?.call(date);
  }

  void _onFetchPreviousWeek() {
    final previousWeek = state.weeks.first.first.getPreviousWeek();
    setState(() {
      state = state.copyWith(weeks: [previousWeek, ...state.weeks]);
    });
    widget.onPreviousWeekFetched?.call();
  }

  void _onFetchNextWeek() {
    final nextWeek = state.weeks.last.last.getNextWeek();
    setState(() {
      state = state.copyWith(weeks: [...state.weeks, nextWeek]);
    });
    widget.onNextWeekFetched?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.hasHeader)
          _CalendarHeader(
            key: const Key(_WidgetsConstants.calendarHeaderKey),
            date: state.selectedDate,
            theme: widget.theme.headerTheme,
          ),
        _CalendarSlider(
          key: const Key(_WidgetsConstants.calendarSliderKey),
          pageController: _pageController,
          isSnapping: widget.isSnapping,
          date: state.selectedDate,
          rows: state.weeks.indexed
              .map(
                (content) => _CalendarRow(
                  key: Key(_WidgetsConstants.calendarRowKey(content.$1)),
                  week: content.$2,
                  background: widget.theme.background,
                  itemBuilder: (itemIndex, day) {
                    final isSelectedDate =
                        state.selectedDate.isAtSameMomentAs(day);

                    return _CalendarItem(
                      key: Key(_WidgetsConstants.calendarItemKey(
                        content.$1,
                        itemIndex,
                      )),
                      isSelectedDate: isSelectedDate,
                      date: day,
                      onPressed:
                          isSelectedDate ? null : () => _onDateSelected(day),
                      theme: widget.theme.itemTheme,
                    );
                  },
                ),
              )
              .toList(),
          onGoToFirstWeek: _onFetchPreviousWeek,
          onGoToLastPage: _onFetchNextWeek,
        ),
      ],
    );
  }
}
