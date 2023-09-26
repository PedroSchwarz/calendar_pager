import 'package:intl/intl.dart';

extension StringExtensions on String {
  String toCapitalized() => toBeginningOfSentenceCase(this) ?? this;
}
