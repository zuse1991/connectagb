import 'package:flutter_test/flutter_test.dart';

Future<void> timePasses(WidgetTester tester) async {
  await tester.pumpAndSettle(const Duration(seconds: 5));
}
