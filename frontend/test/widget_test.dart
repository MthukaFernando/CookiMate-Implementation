import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('App loads HomePage', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // App should build without crashing
    expect(find.byType(MyApp), findsOneWidget);
  });
}