import 'package:conecta_gb/commom/exceptions/translatable_exception.dart';

class InvalidSignInDataException implements TranslatableException {
  @override
  String get translationPath => 'sign-in.errors.invalid-sign-in-data-exception';
}
