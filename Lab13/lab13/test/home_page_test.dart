import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab11_12/screens/details_page.dart';
import 'package:lab11_12/screens/home_page.dart';
import 'package:lab11_12/widgets/search_widget.dart';

void main() {
  testWidgets('HomePage has a search field, menu button, and displays items', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.byType(SearchWidget), findsOneWidget);

    expect(find.byIcon(Icons.menu), findsOneWidget);

    expect(find.byType(Image), findsWidgets);

    expect(find.text('Nike'), findsOneWidget);

    expect(find.text('Collection'), findsOneWidget);

    expect(find.text('On Trend'), findsOneWidget);

    expect(find.byType(Image), findsWidgets);
  });

  testWidgets('Test navigation when tapping the local_mall_outlined button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    final localMallButton = find.byIcon(Icons.local_mall_outlined);

    await tester.tap(localMallButton);
    await tester.pumpAndSettle();

    expect(find.byType(DetailsPage), findsOneWidget);
  });

  testWidgets('AppBar has a transparent background', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.backgroundColor, Colors.transparent);
  });
}
