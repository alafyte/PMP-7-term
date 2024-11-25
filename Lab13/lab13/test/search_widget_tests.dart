import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:lab11_12/widgets/search_widget.dart';

void main() {
  testWidgets('Test Search Widget - Enter Text and Search', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: SearchWidget())));

    await tester.enterText(find.byType(TextField), 'Nike shoes');
    await tester.pump();

    expect(find.text('Nike shoes'), findsOneWidget);
  });
}
