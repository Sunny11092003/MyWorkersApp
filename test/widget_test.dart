// Basic smoke test for MyWorkersApp.
//
// Verifies that the app launches successfully and the home screen renders
// without throwing any errors.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_workers_app/my_workers_app.dart';

void main() {
  testWidgets('App launches and renders home screen', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyWorkersApp());

    // The home screen should be present without crashing.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
