class CalendarState {
  final DateTime selectedDate;
  final List<List<DateTime>> weeks;

  CalendarState({required this.selectedDate, required this.weeks});

  CalendarState copyWith({
    DateTime? selectedDate,
    List<List<DateTime>>? weeks,
  }) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      weeks: weeks ?? this.weeks,
    );
  }
}
