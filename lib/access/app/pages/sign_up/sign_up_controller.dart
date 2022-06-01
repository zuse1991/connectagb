import 'package:conecta_gb/commom/mixins/email_validator_mixin.dart';
import 'package:conecta_gb/commom/mixins/name_validator_mixin.dart';
import 'package:conecta_gb/commom/mixins/password_validator_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SignUpViewController extends Controller
    with PasswordValidatorMixin, EmailValidatorMixin, NameValidatorMixin {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initListeners() {}

  String? validateEmail(String? data) {
    if (data != null && isValidEmail(data)) {
      return null;
    }

    return FlutterI18n.translate(
      getContext(),
      'sign-up.errors.invalid-email',
    );
  }

  String? validatePassword(String? data) {
    if (data != null && isValidPassword(data)) {
      return null;
    }

    return FlutterI18n.translate(
      getContext(),
      'sign-up.errors.invalid-password',
    );
  }

  String? validateName(String? data) {
    if (data != null && isValidName(data)) {
      return null;
    }

    return FlutterI18n.translate(
      getContext(),
      'sign-up.errors.invalid-name',
    );
  }

  void sendUser() {
    if (formKey.currentState?.validate() == true) {
      final dialog = AlertDialog(
        title: const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        content: Text(
          FlutterI18n.translate(
            getContext(),
            'sign-up.success-send.message',
          ),
        ),
        actions: [
          TextButton(
            onPressed: _dialogDismiss,
            child: Text(
              FlutterI18n.translate(
                getContext(),
                'sign-up.success-send.ok-button',
              ),
            ),
          )
        ],
      );

      showDialog(
        context: getContext(),
        barrierDismissible: false,
        builder: (context) => dialog,
      );
    }
  }

  void _dialogDismiss() {
    Navigator.of(getContext()).pop();
    Navigator.of(getContext()).pop();
  }
}
