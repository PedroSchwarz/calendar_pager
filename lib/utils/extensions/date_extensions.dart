import 'package:calendar_pager/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  DateTime getDateOnly() => DateUtils.dateOnly(this);

  List<DateTime> getWeekFromStartDate() {
    return List.generate(
      7,
      (index) => add(Duration(days: index)).getDateOnly(),
    );
  }

  DateTime getStartOfWeekFromDate() => subtract(Duration(days: weekday - 1));

  DateTime getEndOfWeekFromDate() => add(Duration(days: 6 - weekday));

  List<DateTime> getPreviousWeek() {
    final previousDay = subtract(const Duration(days: 1));
    final startOfPreviousWeek = previousDay.getStartOfWeekFromDate();
    return startOfPreviousWeek.getWeekFromStartDate();
  }

  List<DateTime> getNextWeek() {
    final nextDay = add(const Duration(days: 1));
    return nextDay.getWeekFromStartDate();
  }

  String getMonthName() =>
      _getFormatterFor(mask: 'MMMM').format(this).toCapitalized();

  String getDayName() =>
      _getFormatterFor(mask: 'EEE').format(this).toCapitalized();

  String getCompleteDate() =>
      _getFormatterFor(mask: 'EEEE, MMM d, yyyy').format(this).toCapitalized();

  String getDateForTransactions() =>
      _getFormatterFor(mask: 'yyyy-MM-dd').format(this).toCapitalized();

  bool getIsCurrentDate() =>
      DateTime.now().getDateOnly().isAtSameMomentAs(this);

  DateFormat _getFormatterFor({required String mask}) => DateFormat(mask);
}
