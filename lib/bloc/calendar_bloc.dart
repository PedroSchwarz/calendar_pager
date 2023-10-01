import 'package:calendar_pager/bloc/calendar_event.dart';
import 'package:calendar_pager/bloc/calendar_state.dart';
import 'package:calendar_pager/utils/extensions/date_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc()
      : super(CalendarState(
          selectedDate: DateTime.now().getDateOnly(),
          weeks: const [],
        )) {
    on<CalendarDateSelected>(
      (event, emit) {
        if (event.isInitial) {
          final startOfWeek = event.date.getStartOfWeekFromDate();
          final currentWeek = startOfWeek.getWeekFromStartDate();
          final previouWeek = currentWeek.first.getPreviousWeek();
          final nextWeek = currentWeek.last.getNextWeek();
          emit(
            state.copyWith(
              selectedDate: event.date,
              weeks: [previouWeek, currentWeek, nextWeek],
            ),
          );
        } else {
          emit(state.copyWith(selectedDate: event.date));
        }
      },
    );
    on<CalendarFetchWeek>(
      (event, emit) {
        List<DateTime> newWeek;
        final isPrevious = event.type == FetchWeekType.previous;
        if (isPrevious) {
          newWeek = state.weeks.first.first.getPreviousWeek();
        } else {
          newWeek = state.weeks.last.last.getNextWeek();
        }
        emit(
          state.copyWith(
            weeks: isPrevious
                ? [newWeek, ...state.weeks]
                : [...state.weeks, newWeek],
          ),
        );
      },
    );
  }
}
