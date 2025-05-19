import 'package:flutter/material.dart';

class CalendarPagerTheme {
  final Color background;
  final CalendarHeaderTheme headerTheme;
  final CalendarItemTheme itemTheme;

  /// Calendar Pager Widget Theme.
  ///
  /// [background] Calendar Pager Slider bakcground color.
  ///
  /// [headerTheme] Calendar Pager Header Theme.
  ///
  /// [itemTheme] Calendar Pager Date Items Theme.
  CalendarPagerTheme({
    required this.background,
    required this.headerTheme,
    required this.itemTheme,
  });

  /// CalendarPagerTheme factory using common colors and TextStyles.
  ///
  /// [background] Background color of both Header and Slider.
  ///
  /// [accent] Accent color used for the current date indicator and selected date background.
  ///
  /// [onAccent] Color of the content stacked over the accent color content.
  ///
  /// [headerTitle] Header Title [TextStyle].
  ///
  /// [headerSubtitle] Header Subtitle [TextStyle].
  /// * Optional.
  /// * Default value is a [TextStyle] with fontSize of 16.
  ///
  ///  [dateText] Date Text [TextStyle].
  /// * Optional.
  /// * Default value is a [TextStyle] with fontSize of 16.
  /// * The value applies for days's names and for the date item text.
  /// * The value applies for the selected state of the day's name but with fontWeight as bold.
  /// * The value applies for the selected state of the date's item but with fontWeight as bold and color as onAccent.
  ///
  /// [itemBorder] Item border color for the dates.
  factory CalendarPagerTheme.from({
    required Color background,
    required Color accent,
    required Color onAccent,
    required TextStyle headerTitle,
    TextStyle headerSubtitle = const TextStyle(fontSize: 16),
    TextStyle dateText = const TextStyle(fontSize: 16),
    required Color itemBorder,
    bool hasShadow = true,
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
        hasShadow: hasShadow,
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

  /// Calendar Pager Widget Header Theme.
  ///
  /// [headerBackground] Background color.
  ///
  /// [primaryText] Header's month info [TextStyle].
  ///
  /// [secondaryText] Header's year info [TextStyle].
  ///
  /// [hasCompleteDate] Boolean that shows/hides the complete date info.
  /// * Optional.
  /// * Default value is [true].
  ///
  /// [alignment] Used to align content [CrossAxisAlignment].
  /// * Optional.
  /// * Default value is [CrossAxisAlignment.start].
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

  /// Calendar Pager Widget Date Item Theme.
  ///
  /// [dayNameText] Day's name [TextStyle].
  ///
  /// [selectedDayNameText] Day's name [TextStyle] when day is selected.
  ///
  /// [borderColor] Color of the border of the item containing the date.
  ///
  /// [selectedBorderColor] Color of the border of the item containing the date when it's selected.
  ///
  /// [itemShape] Used to determine the shape of the box where the date is contained [BoxShape].
  /// * Optional.
  /// * Default value is [BoxShape.circle].
  ///
  /// [itemBackground] Color used as background for the date item container.
  ///
  /// [selectedItemBackground] Color used as background for the date item container when the date is selected.
  ///
  /// [hasShadow] Boolean that shows/hides the shadow of the date's container.
  /// * Optional.
  /// * Default value is [true].
  ///
  /// [dateText] Date's text [TextStyle].
  ///
  /// [selectedDateText] Date's text [TextStyle] when date is selected.
  ///
  /// [currentDateIndicatorColor] Color of the current date's indicator thats placed below the date container.
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
