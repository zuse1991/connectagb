import 'package:conecta_gb/application.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAppIsRunning(WidgetTester tester) async {
  await tester.pumpWidget(const ConnectaGBApp());
}
