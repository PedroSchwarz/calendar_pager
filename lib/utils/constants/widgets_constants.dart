class WidgetsConstants {
  static const calendarHeaderKey = 'calendarHeader';
  static const calendarSliderKey = 'calendarSlider';
  static String calendarRowKey(int index) => 'calendarRow$index';
  static String calendarItemKey(int rowIndex, int index) =>
      'calendarItem$rowIndex-$index';
}

class CalendarPagerViewConstants {
  static const collapsedHeight = 103.0;
  static const expandedHeight = 206.0;
}
