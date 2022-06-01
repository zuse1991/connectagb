mixin NameValidatorMixin {
  bool isValidName(String name) {
    return name.trim().contains(' ');
  }
}
