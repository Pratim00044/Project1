import 'package:flutter_test/flutter_test.dart';
import 'package:club_project/main.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    await tester.pumpWidget(const StatixaApp());

    expect(find.byType(StatixaApp), findsOneWidget);
  });
}
