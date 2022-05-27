mixin PasswordValidatorMixin {
  bool isValidPassword(String password) {
    return password.length >= 6;
  }
}
