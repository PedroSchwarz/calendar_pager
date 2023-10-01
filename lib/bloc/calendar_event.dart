sealed class CalendarEvent {}

class CalendarFetchWeek extends CalendarEvent {
  final FetchWeekType type;

  CalendarFetchWeek({required this.type});
}

class CalendarDateSelected extends CalendarEvent {
  final DateTime date;
  final bool isInitial;

  CalendarDateSelected({
    required this.date,
    this.isInitial = false,
  });
}

enum FetchWeekType { previous, next }
