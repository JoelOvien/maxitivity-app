// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:ambeego_test/features/timer/presentation/screens/timer.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Timer button widget test',
    (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionButtonWidget(
              action: () {
                debugPrint('Timer button tapped');
              },
              icon: Icons.play_arrow,
            ),
          ),
        ),
      );

      // Find the button widget
      final buttonFinder = find.byIcon(Icons.play_arrow);

      // Verify that the button is rendered
      expect(buttonFinder, findsOneWidget);

      // Tap the button
      await tester.tap(buttonFinder);

      // Trigger a frame
      await tester.pump();
    },
  );
}
