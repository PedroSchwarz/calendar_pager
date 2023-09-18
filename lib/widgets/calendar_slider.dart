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
      height: 106,
      child: PageView(
        controller: pageController,
        onPageChanged: (index) {
          if (index == 0) {
            onGoToFirstWeek();
            pageController.nextPage(
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear,
            );
          } else if (index == rows.length - 1) {
            onGoToLastPage();
          }
        },
        children: rows,
      ),
    );
  }
}
