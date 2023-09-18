import 'package:flutter/material.dart';

class CalendarSlider extends StatelessWidget {
  final PageController pageController;
  final DateTime date;
  final List<Widget> rows;
  final VoidCallback onGoToFirstWeek;
  final VoidCallback onGoToLastPage;

  const CalendarSlider({
    super.key,
    required this.pageController,
    required this.date,
    required this.rows,
    required this.onGoToFirstWeek,
    required this.onGoToLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: PageView(
        controller: pageController,
        onPageChanged: (index) {
          if (index == 0) {
            // bloc.add(CalendarFetchWeek(type: FetchWeekType.previous));
            onGoToFirstWeek();
            pageController.nextPage(
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear,
            );
          } else if (index == rows.length - 1) {
            onGoToLastPage();
            // bloc.add(CalendarFetchWeek(type: FetchWeekType.next));
          }
        },
        children: rows,
      ),
    );
  }
}
