import 'package:calendar_pager/calendar_pager.dart';
import 'package:calendar_pager/utils/constants/widgets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/transaction_test_helper.dart';

void main() {
  testWidgets(
    'test not header',
    (widgetTester) async {
      await loadWidget(
        widgetTester,
        CalendarPagerView(
          hasHeader: false,
          theme: CalendarPagerTheme.from(
            background: Colors.black87,
            accent: Colors.deepPurple.shade500,
            onAccent: Colors.white,
            headerTitle: const TextStyle(fontSize: 24),
            itemBorder: Colors.deepPurple.shade700,
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      expect(
        find.byKey(const Key(WidgetsConstants.calendarHeaderKey)),
        findsNothing,
      );

      expect(
        find.byKey(const Key(WidgetsConstants.calendarSliderKey)),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'test has header',
    (widgetTester) async {
      await loadWidget(
        widgetTester,
        CalendarPagerView(
          theme: CalendarPagerTheme.from(
            background: Colors.black87,
            accent: Colors.deepPurple.shade500,
            onAccent: Colors.white,
            headerTitle: const TextStyle(fontSize: 24),
            itemBorder: Colors.deepPurple.shade700,
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      expect(
        find.byKey(const Key(WidgetsConstants.calendarHeaderKey)),
        findsOneWidget,
      );

      expect(
        find.byKey(const Key(WidgetsConstants.calendarSliderKey)),
        findsOneWidget,
      );
    },
  );
}
