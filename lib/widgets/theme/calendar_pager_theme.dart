import 'package:flutter/material.dart';

class CalendarPagerTheme {
  final Color background;
  final CalendarHeaderTheme headerTheme;
  final CalendarItemTheme itemTheme;

  CalendarPagerTheme({
    required this.background,
    required this.headerTheme,
    required this.itemTheme,
  });

  factory CalendarPagerTheme.from({
    required Color background,
    required Color accent,
    required Color onAccent,
    required TextStyle headerTitle,
    TextStyle headerSubtitle = const TextStyle(fontSize: 16),
    TextStyle dateText = const TextStyle(fontSize: 16),
    required Color itemBorder,
  }) {
    return CalendarPagerTheme(
      background: background,
      headerTheme: CalendarHeaderTheme(
        headerBackground: background,
        primaryText: headerTitle.copyWith(fontWeight: FontWeight.bold),
        secondaryText: headerTitle.copyWith(fontWeight: FontWeight.normal),
        completeDateText: headerSubtitle,
        alignment: CrossAxisAlignment.start,
        hasCompleteDate: true,
      ),
      itemTheme: CalendarItemTheme(
        dayNameText: dateText,
        selectedDayNameText: dateText.copyWith(fontWeight: FontWeight.bold),
        borderColor: itemBorder,
        selectedBorderColor: itemBorder,
        itemBackground: background,
        selectedItemBackground: accent,
        dateText: dateText,
        selectedDateText: dateText.copyWith(
          fontWeight: FontWeight.bold,
          color: onAccent,
        ),
        currentDateIndicatorColor: accent,
      ),
    );
  }
}

class CalendarHeaderTheme {
  final Color headerBackground;
  final TextStyle primaryText;
  final TextStyle secondaryText;
  final TextStyle completeDateText;
  final bool hasCompleteDate;
  final CrossAxisAlignment alignment;

  CalendarHeaderTheme({
    required this.headerBackground,
    required this.primaryText,
    required this.secondaryText,
    required this.completeDateText,
    this.hasCompleteDate = true,
    this.alignment = CrossAxisAlignment.start,
  });
}

class CalendarItemTheme {
  final TextStyle dayNameText;
  final TextStyle selectedDayNameText;
  final Color borderColor;
  final Color selectedBorderColor;
  final BoxShape itemShape;
  final Color itemBackground;
  final Color selectedItemBackground;
  final bool hasShadow;
  final TextStyle dateText;
  final TextStyle selectedDateText;
  final Color currentDateIndicatorColor;

  CalendarItemTheme({
    required this.dayNameText,
    required this.selectedDayNameText,
    required this.borderColor,
    required this.selectedBorderColor,
    this.itemShape = BoxShape.circle,
    required this.itemBackground,
    required this.selectedItemBackground,
    this.hasShadow = true,
    required this.dateText,
    required this.selectedDateText,
    required this.currentDateIndicatorColor,
  });
}
