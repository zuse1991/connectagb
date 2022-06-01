import 'dart:ui';

import 'package:conecta_gb/access/app/pages/sign_in/sign_in_view.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../main.dart';

Future<void> theSignInScreenIsOpen(WidgetTester tester) async {
  tester.binding.window.physicalSizeTestValue = const Size(1080, 2160);

  await tester.pumpWidget(runTestApp(home: SignInView()));
  await tester.pumpAndSettle();
}
