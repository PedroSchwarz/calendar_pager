import 'package:calendar_pager/utils/extensions/date_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DateTime initialDate;

  setUp(() {
    initialDate = DateTime(2023, 1, 1);
  });

  test(
      'WHEN getWeekFromStartDate is called for a given date THEN it should return the correct list of dates',
      () {
    final week = initialDate.getWeekFromStartDate();
    expect(
      week,
      [
        DateTime(2023, 1, 1),
        DateTime(2023, 1, 2),
        DateTime(2023, 1, 3),
        DateTime(2023, 1, 4),
        DateTime(2023, 1, 5),
        DateTime(2023, 1, 6),
        DateTime(2023, 1, 7)
      ],
    );
  });

  test(
      'WHEN getStartOfWeekFromDate is called for a given date THEN it should return the correct date',
      () {
    final startDate = initialDate.getStartOfWeekFromDate();
    expect(startDate, DateTime(2022, 12, 26));
  });

  test(
      'WHEN getEndOfWeekFromDate is called for a given date THEN it should return the correct date',
      () {
    final endDate = initialDate.getEndOfWeekFromDate();
    expect(endDate, DateTime(2022, 12, 31));
  });

  test(
      'WHEN getPreviousWeek is called for a start of the week date THEN it should return the correct list of dates',
      () {
    final startOfWeek = initialDate.getStartOfWeekFromDate();
    final previousWeek = startOfWeek.getPreviousWeek();
    expect(previousWeek, [
      DateTime(2022, 12, 19),
      DateTime(2022, 12, 20),
      DateTime(2022, 12, 21),
      DateTime(2022, 12, 22),
      DateTime(2022, 12, 23),
      DateTime(2022, 12, 24),
      DateTime(2022, 12, 25)
    ]);
  });

  test(
      'WHEN getNextWeek is called for a end of the week date THEN it should return the correct list of dates',
      () {
    final endOfWeek = initialDate.getEndOfWeekFromDate();
    final nextWeek = endOfWeek.getNextWeek();
    expect(nextWeek, [
      DateTime(2023, 1, 1),
      DateTime(2023, 1, 2),
      DateTime(2023, 1, 3),
      DateTime(2023, 1, 4),
      DateTime(2023, 1, 5),
      DateTime(2023, 1, 6),
      DateTime(2023, 1, 7)
    ]);
  });
}
