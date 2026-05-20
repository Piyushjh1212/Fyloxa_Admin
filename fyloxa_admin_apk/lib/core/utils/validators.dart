class Validators {
  static String? validateEmail(String? value) {
    if (value == null || !value.contains('@')) return 'Invalid Email';
    return null;
  }
  // Phone, Name, etc validation...
}