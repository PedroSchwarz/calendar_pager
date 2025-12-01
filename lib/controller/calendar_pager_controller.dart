import 'package:flutter/material.dart';

/// Controller for programmatically controlling the [CalendarPagerView].
///
/// This controller allows parent widgets to jump to page 1 of the calendar.
class CalendarPagerController {
  /// Callback triggered when going to the initial date.
  /// The widget will register this callback.
  VoidCallback? _onGoToInitialDate;

  /// Registers the go to initial date callback.
  /// This is called internally by the widget.
  void registerGoToInitialDateCallback(VoidCallback callback) {
    _onGoToInitialDate = callback;
  }

  /// Goes to the initial date.
  ///
  /// Throws [StateError] if the controller is not attached to a widget.
  void goToInitialDate() {
    if (_onGoToInitialDate == null) {
      throw StateError(
        'CalendarPagerController is not attached to a CalendarPagerView. '
        'Make sure the controller is passed to the CalendarPagerView widget.',
      );
    }
    _onGoToInitialDate!();
  }
}
