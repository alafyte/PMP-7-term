import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab11_12/screens/details_page.dart';

void main() {
  testWidgets('DetailsPage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DetailsPage()));

    expect(find.byType(AppBar), findsOneWidget);

    expect(find.text('Nike GTX'), findsOneWidget);

    expect(find.byType(Image), findsNWidgets(6));

    expect(find.text('SALE'), findsOneWidget);

    expect(find.text('+ Add To Cart'), findsOneWidget);
  });

  testWidgets('Displays product name and description', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DetailsPage()));

    expect(find.text('Nike GTX'), findsOneWidget);

    expect(find.text(
      'The Nike GTX Shoe borrows design lines from the heritage runners like the Nike React Technology.',
    ), findsOneWidget);
  });

  testWidgets('Can select a size', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DetailsPage()));

    expect(find.text('5'), findsOneWidget);
    expect(find.text('5.5'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
    expect(find.text('6.5'), findsOneWidget);
    expect(find.text('7'), findsOneWidget);

    final sizeOption = find.text('6.5');
    await tester.tap(sizeOption);
    await tester.pump();

    final selectedSizeContainer = tester.widget(find.text('6.5').last) as Text;

    expect(
      (selectedSizeContainer.style?.color ?? Colors.transparent),
      equals(const Color.fromARGB(192, 248, 182, 40)),
    );
  });


}
