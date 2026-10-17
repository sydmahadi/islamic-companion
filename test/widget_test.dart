
import 'package:flutter_test/flutter_test.dart';
import 'package:islamic_companion/main.dart';

void main() {
  testWidgets('Islamic Companion app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const IslamicCompanionApp());

    expect(find.text('Islamic Companion'), findsWidgets);
  });
}
