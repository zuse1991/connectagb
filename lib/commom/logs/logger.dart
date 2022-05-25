import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter(), filter: MyLogFilter());

class MyLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return !kReleaseMode;
  }
}
