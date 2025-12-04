import 'dart:io';

import 'package:calendar_pager/bloc/calendar_bloc.dart';
import 'package:calendar_pager/bloc/calendar_event.dart';
import 'package:calendar_pager/bloc/calendar_state.dart';
import 'package:calendar_pager/controller/calendar_pager_controller.dart';
import 'package:calendar_pager/utils/constants/widgets_constants.dart';
import 'package:calendar_pager/utils/extensions/date_extensions.dart';
import 'package:calendar_pager/widgets/theme/calendar_pager_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calendar_slider.dart';
part 'calendar_row.dart';
part 'calendar_item.dart';
part 'calendar_header.dart';

class CalendarPagerView extends StatelessWidget {
  final CalendarPagerTheme theme;
  final bool hasHeader;
  final bool isSnapping;
  final DateTime? initialDate;
  final CalendarPagerController? controller;
  final void Function(DateTime)? onDateSelected;
  final VoidCallback? onPreviousWeekFetched;
  final VoidCallback? onNextWeekFetched;
  final void Function(
    int index,
    int initialPage,
    DateTime firstDate,
    DateTime lastDate,
  )?
  onWeekChanged;

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
  /// [controller] Controller for programmatically controlling the [CalendarPagerView].
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
  ///
  /// [onWeekChanged] Listener function that's triggered when the week is changed.
  /// * Optional.
  /// * Default value is [null].
  const CalendarPagerView({
    super.key,
    required this.theme,
    this.hasHeader = true,
    this.isSnapping = true,
    this.initialDate,
    this.controller,
    this.onDateSelected,
    this.onPreviousWeekFetched,
    this.onNextWeekFetched,
    this.onWeekChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalendarBloc(),
      child: _CalendarPagerViewBody(
        theme: theme,
        hasHeader: hasHeader,
        controller: controller,
        initialDate: initialDate,
        isSnapping: isSnapping,
        onDateSelected: onDateSelected,
        onNextWeekFetched: onNextWeekFetched,
        onPreviousWeekFetched: onPreviousWeekFetched,
        onWeekChanged: onWeekChanged,
      ),
    );
  }
}

class _CalendarPagerViewBody extends StatefulWidget {
  final CalendarPagerTheme theme;
  final CalendarPagerController? controller;
  final bool hasHeader;
  final bool isSnapping;
  final DateTime? initialDate;
  final void Function(DateTime)? onDateSelected;
  final VoidCallback? onPreviousWeekFetched;
  final VoidCallback? onNextWeekFetched;
  final void Function(
    int index,
    int initialPage,
    DateTime firstDate,
    DateTime lastDate,
  )?
  onWeekChanged;

  const _CalendarPagerViewBody({
    required this.theme,
    required this.controller,
    required this.hasHeader,
    required this.isSnapping,
    required this.initialDate,
    required this.onDateSelected,
    required this.onPreviousWeekFetched,
    required this.onNextWeekFetched,
    required this.onWeekChanged,
  });

  @override
  State<_CalendarPagerViewBody> createState() => _CalendarPagerViewBodyState();
}

class _CalendarPagerViewBodyState extends State<_CalendarPagerViewBody> {
  late CalendarBloc _bloc;
  final PageController _pageController = PageController();
  int _initialPage = 1;

  @override
  void initState() {
    super.initState();
    final currentDate = (widget.initialDate ?? DateTime.now()).getDateOnly();
    _bloc = BlocProvider.of(context);
    _bloc.add(CalendarDateSelected(date: currentDate, isInitial: true));
    widget.onDateSelected?.call(currentDate);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(_initialPage);
    });

    final controller = widget.controller;
    if (controller != null) {
      controller.registerGoToInitialDateCallback(() {
        _bloc.add(CalendarDateSelected(date: currentDate));
        _pageController.animateToPage(
          _initialPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      });
    }
  }

  void _onDateSelected(DateTime date) {
    _bloc.add(CalendarDateSelected(date: date));
    widget.onDateSelected?.call(date);
  }

  void _onFetchPreviousWeek() {
    _initialPage++;
    _bloc.add(CalendarFetchWeek(type: FetchWeekType.previous));
    widget.onPreviousWeekFetched?.call();
  }

  void _onFetchNextWeek() {
    _bloc.add(CalendarFetchWeek(type: FetchWeekType.next));
    widget.onNextWeekFetched?.call();
  }

  void _onWeekChanged({
    required int index,
    required int initialPage,
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    widget.onWeekChanged?.call(index, initialPage, firstDate, lastDate);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, CalendarState state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.hasHeader)
              _CalendarHeader(
                key: const Key(WidgetsConstants.calendarHeaderKey),
                date: state.selectedDate,
                theme: widget.theme.headerTheme,
              ),
            Row(
              children: [
                if (Platform.isMacOS)
                  GestureDetector(
                    onTap: () async {
                      await _pageController.previousPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.linear,
                      );
                      final index = _pageController.page?.toInt() ?? 0;
                      _onWeekChanged(
                        index: index,
                        initialPage: _initialPage,
                        firstDate: state.weeks[index].first,
                        lastDate: state.weeks[index].last,
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.theme.itemTheme.borderColor,
                          width: 3,
                        ),
                        shape: BoxShape.circle,
                        color: widget.theme.background,
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        color: widget.theme.itemTheme.dateText.color,
                      ),
                    ),
                  ),
                Expanded(
                  child: _CalendarSlider(
                    key: const Key(WidgetsConstants.calendarSliderKey),
                    pageController: _pageController,
                    isSnapping: widget.isSnapping,
                    date: state.selectedDate,
                    rows: state.weeks.indexed
                        .map(
                          (content) => _CalendarRow(
                            key: Key(
                              WidgetsConstants.calendarRowKey(content.$1),
                            ),
                            week: content.$2,
                            background: widget.theme.background,
                            itemBuilder: (itemIndex, day) {
                              final isSelectedDate = state.selectedDate
                                  .isAtSameMomentAs(day);

                              return _CalendarItem(
                                key: Key(
                                  WidgetsConstants.calendarItemKey(
                                    content.$1,
                                    itemIndex,
                                  ),
                                ),
                                isSelectedDate: isSelectedDate,
                                date: day,
                                onPressed: isSelectedDate
                                    ? null
                                    : () => _onDateSelected(day),
                                theme: widget.theme.itemTheme,
                              );
                            },
                          ),
                        )
                        .toList(),
                    onGoToFirstWeek: _onFetchPreviousWeek,
                    onGoToLastPage: _onFetchNextWeek,
                    onPageChanged: (index) => _onWeekChanged(
                      index: index,
                      initialPage: _initialPage,
                      firstDate: state.weeks[index].first,
                      lastDate: state.weeks[index].last,
                    ),
                  ),
                ),
                if (Platform.isMacOS)
                  GestureDetector(
                    onTap: () async {
                      await _pageController.nextPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.linear,
                      );
                      final index = _pageController.page?.toInt() ?? 0;
                      _onWeekChanged(
                        index: index,
                        initialPage: _initialPage,
                        firstDate: state.weeks[index].first,
                        lastDate: state.weeks[index].last,
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.theme.itemTheme.borderColor,
                          width: 3,
                        ),
                        shape: BoxShape.circle,
                        color: widget.theme.background,
                      ),
                      child: Icon(
                        Icons.chevron_right,
                        color: widget.theme.itemTheme.dateText.color,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
