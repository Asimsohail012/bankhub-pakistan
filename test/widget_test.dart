// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bankhub_pakistan/main.dart';

void main() {
  testWidgets('BankHub Pakistan splash smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BankHubPakistan());
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('BankHub Pakistan'), findsOneWidget);
    expect(find.text("Pakistan's Smart Banking Platform"), findsOneWidget);
    expect(find.byIcon(Icons.account_balance_rounded), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);

    // Dispose animated/timed splash content so no pending timer blocks test completion.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
