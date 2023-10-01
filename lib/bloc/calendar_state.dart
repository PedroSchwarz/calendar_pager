import 'package:equatable/equatable.dart';

class CalendarState extends Equatable {
  final DateTime selectedDate;
  final List<List<DateTime>> weeks;

  const CalendarState({
    required this.selectedDate,
    required this.weeks,
  });

  CalendarState copyWith({
    DateTime? selectedDate,
    List<List<DateTime>>? weeks,
  }) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      weeks: weeks ?? this.weeks,
    );
  }

  @override
  List<Object?> get props => [selectedDate, weeks];
}
