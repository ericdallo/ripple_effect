import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:ripple_effect/ripple_effect.dart';

void main() {
  testWidgets('RipplePage wraps the child', (WidgetTester tester) async {
    final app = MaterialApp(
      home: RipplePage(
        pageKey: RipplePage.createGlobalKey(),
        child: Scaffold(
          body: Text('SOME TEXT'),
        ),
      ),
    );

    await tester.pumpWidget(app);

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('SOME TEXT'), findsOneWidget);
  });

  testWidgets('RippleEffect wraps the child', (WidgetTester tester) async {
    final pageKey = RipplePage.createGlobalKey();
    final effectKey = RippleEffect.createGlobalKey();

    final app = MaterialApp(
      home: RipplePage(
        pageKey: pageKey,
        child: Scaffold(
          body: RippleEffect(
            pageKey: pageKey,
            effectKey: effectKey,
            color: Colors.green,
            child: ElevatedButton(
              onPressed: expectAsync0(() {}, count: 0),
            ),
          ),
        ),
      ),
    );

    await tester.pumpWidget(app);

    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('RippleEffect should call callback after effect.',
      (WidgetTester tester) async {
    final pageKey = RipplePage.createGlobalKey();
    final effectKey = RippleEffect.createGlobalKey();

    final app = MaterialApp(
      home: RipplePage(
        pageKey: pageKey,
        child: Scaffold(
          body: RippleEffect(
            pageKey: pageKey,
            effectKey: effectKey,
            color: Colors.green,
            child: ElevatedButton(
              onPressed: expectAsync0(() {}, count: 1),
            ),
          ),
        ),
      ),
    );

    await tester.pumpWidget(app);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
  });
}
