import 'package:conecta_gb/access/app/pages/sign_in/sign_in_presenter.dart';
import 'package:conecta_gb/access/data/repositories/auth_repository.dart';
import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:conecta_gb/commom/exceptions/translatable_exception.dart';
import 'package:conecta_gb/commom/mixins/email_validator_mixin.dart';
import 'package:conecta_gb/commom/mixins/password_validator_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SignInViewController extends Controller
    with EmailValidatorMixin, PasswordValidatorMixin {
  SignInViewController()
      : _presenter = SignInViewPresenter(authRepository: AuthRepository()),
        emailTextEditingController = TextEditingController(),
        passwordTextEditingController = TextEditingController(),
        formKey = GlobalKey<FormState>();

  final TextEditingController emailTextEditingController;
  final TextEditingController passwordTextEditingController;
  final GlobalKey<FormState> formKey;
  bool isLoading = false;

  final SignInViewPresenter _presenter;

  @override
  void initListeners() {
    _presenter.onAuthComplete = onAuthComplete;
    _presenter.onAuthData = onAuthData;
    _presenter.onAuthException = onAuthException;
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void newAccountButtonTap() {
    Navigator.of(getContext()).pushNamed('/sign-up');
  }

  void signInButtonTap() {
    if (formKey.currentState?.validate() == true) {
      _showLoading();

      _presenter.authenticate(
        emailTextEditingController.text,
        passwordTextEditingController.text,
      );
    }
  }

  void onAuthComplete() {
    _hideLoading();
  }

  void onAuthData(User user) {
    _hideLoading();
    Navigator.of(getContext()).pushReplacementNamed(
      '/feed',
      arguments: user,
    );
  }

  void onAuthException(exception) {
    _hideLoading();

    String translationPath = 'errors.unexpected-error';

    if (exception is TranslatableException) {
      translationPath = exception.translationPath;
    }

    final dialog = AlertDialog(
      title: Text(
        FlutterI18n.translate(
          getContext(),
          '$translationPath.title',
        ),
      ),
      content: Text(
        FlutterI18n.translate(
          getContext(),
          '$translationPath.message',
        ),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(getContext()).pop,
          child: Text(
            FlutterI18n.translate(
              getContext(),
              'buttons.ok',
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

  String? validateEmail(String? value) {
    if (value == null || isValidEmail(value)) {
      return null;
    }

    return FlutterI18n.translate(
      getContext(),
      'sign-in.errors.invalid_email',
    );
  }

  String? validatePassword(String? value) {
    if (value == null || isValidPassword(value)) {
      return null;
    }

    return FlutterI18n.translate(
      getContext(),
      'sign-in.errors.invalid_password',
    );
  }

  void _showLoading() {
    if (!isLoading) {
      isLoading = true;
      refreshUI();
    }
  }

  void _hideLoading() {
    if (isLoading) {
      isLoading = false;
      refreshUI();
    }
  }
}
