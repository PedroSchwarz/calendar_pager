import 'package:flutter/material.dart';

class CalendarPagerStyle {
  final CalendarHeaderStyle headerStyle;
  final CalendarRowStyle rowStyle;

  CalendarPagerStyle({
    required this.headerStyle,
    required this.rowStyle,
  });
}

class CalendarHeaderStyle {
  final Color headerBackground;
  final TextStyle primaryText;
  final TextStyle secondaryText;
  final TextStyle completeDateText;
  final bool hasCompleteDate;
  final CrossAxisAlignment alignment;

  CalendarHeaderStyle({
    required this.headerBackground,
    required this.primaryText,
    required this.secondaryText,
    required this.completeDateText,
    this.hasCompleteDate = true,
    this.alignment = CrossAxisAlignment.start,
  });
}

class CalendarRowStyle {
  final Color rowBackground;

  CalendarRowStyle({required this.rowBackground});
}
