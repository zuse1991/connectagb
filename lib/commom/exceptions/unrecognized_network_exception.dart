import 'package:conecta_gb/commom/exceptions/translatable_exception.dart';
import 'package:dio/dio.dart';

class UnrecognizedNetworkException implements TranslatableException {
  UnrecognizedNetworkException({required this.response});

  @override
  String get translationPath => '';
  Response? response;
}
