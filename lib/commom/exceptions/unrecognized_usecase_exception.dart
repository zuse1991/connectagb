import 'package:conecta_gb/commom/exceptions/translatable_exception.dart';

class UnrecognizedUseCaseException implements TranslatableException {
  UnrecognizedUseCaseException({required this.exception});

  dynamic exception;

  @override
  String get translationPath => '';
}
