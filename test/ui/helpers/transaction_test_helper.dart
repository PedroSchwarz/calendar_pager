import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SetupWidgetTester extends StatelessWidget {
  final Widget child;
  const SetupWidgetTester({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: MediaQuery(
          data: const MediaQueryData(),
          child: child,
        ),
      ),
    );
  }
}

Future<void> loadWidget(WidgetTester tester, Widget child) async {
  var widget = SetupWidgetTester(child: child);
  await tester.pumpWidget(widget);
}
