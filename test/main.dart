import 'package:flutter/material.dart';

import 'application.dart';

Widget runTestApp({Widget? home}) {
  WidgetsFlutterBinding.ensureInitialized();

  return ConectaGBTestApp(
    home: home,
  );
}
