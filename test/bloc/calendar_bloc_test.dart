import 'package:bloc_test/bloc_test.dart';
import 'package:calendar_pager/bloc/calendar_bloc.dart';
import 'package:calendar_pager/bloc/calendar_event.dart';
import 'package:calendar_pager/bloc/calendar_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../factory/state_factory.dart';

void main() {
  late List<List<DateTime>> stubWeeks;

  setUp(() {
    stubWeeks = StateFactory.makeFakeCalendarWeeksStub();
  });

  group('CalendarBloc', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => CalendarBloc(),
      expect: () => [],
    );

    blocTest(
      'WHEN CalendarDateSelected is emitted with isInitial set to false THEN should emit CalendarState with new date and empty weeks',
      build: () => CalendarBloc(),
      act: (bloc) => bloc.add(
        CalendarDateSelected(date: DateTime(2022, 1, 1), isInitial: false),
      ),
      expect: () => [
        CalendarState(selectedDate: DateTime(2022, 1, 1), weeks: const []),
      ],
    );

    blocTest(
      'WHEN CalendarDateSelected is emitted with isInitial set to true THEN should emit CalendarState with new date and correct dates',
      build: () => CalendarBloc(),
      act: (bloc) => bloc.add(
        CalendarDateSelected(date: DateTime(2022, 1, 1), isInitial: true),
      ),
      expect: () => [
        CalendarState(selectedDate: DateTime(2022, 1, 1), weeks: stubWeeks),
      ],
    );

    blocTest(
      'WHEN CalendarFetchWeek is emitted with FetchWeekType.next THEN should emit CalendarState with correct news dates',
      build: () => CalendarBloc(),
      act: (bloc) => bloc
        ..add(
          CalendarDateSelected(date: DateTime(2022, 1, 1), isInitial: true),
        )
        ..add(CalendarFetchWeek(type: FetchWeekType.next)),
      skip: 1,
      expect: () => [
        CalendarState(selectedDate: DateTime(2022, 1, 1), weeks: [
          ...stubWeeks,
          [
            DateTime(2022, 1, 10),
            DateTime(2022, 1, 11),
            DateTime(2022, 1, 12),
            DateTime(2022, 1, 13),
            DateTime(2022, 1, 14),
            DateTime(2022, 1, 15),
            DateTime(2022, 1, 16)
          ]
        ]),
      ],
    );

    blocTest(
      'WHEN CalendarFetchWeek is emitted with FetchWeekType.previous THEN should emit CalendarState with correct news dates',
      build: () => CalendarBloc(),
      act: (bloc) => bloc
        ..add(
          CalendarDateSelected(date: DateTime(2022, 1, 1), isInitial: true),
        )
        ..add(CalendarFetchWeek(type: FetchWeekType.previous)),
      skip: 1,
      expect: () => [
        CalendarState(selectedDate: DateTime(2022, 1, 1), weeks: [
          [
            DateTime(2021, 12, 13),
            DateTime(2021, 12, 14),
            DateTime(2021, 12, 15),
            DateTime(2021, 12, 16),
            DateTime(2021, 12, 17),
            DateTime(2021, 12, 18),
            DateTime(2021, 12, 19)
          ],
          ...stubWeeks,
        ]),
      ],
    );
  });
}
