import 'package:flutter_test/flutter_test.dart';
import 'package:new_shopx/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ArchiveApp());
    expect(find.text('THE ARCHIVE'), findsOneWidget);
  });
}
