abstract class Validators {
  static String? required(String? value) =>
      (value == null || value.trim().isEmpty) ? 'This field is required' : null;

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    final isValid = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(value.trim());
    return isValid ? null : 'Enter a valid email address';
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    return value.length < 6 ? 'Password must be at least 6 characters' : null;
  }
}
