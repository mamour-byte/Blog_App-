// lib/utils/validators.dart

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Email is required';
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Password is required';
  if (value.length < 6) return 'Password must be at least 6 characters';
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) return 'Name is required';
  return null;
}

String? validateConfirmPassword(String password, String? confirmPassword) {
  if (confirmPassword == null || confirmPassword.isEmpty) return 'Please confirm your password';
  if (password != confirmPassword) return 'Passwords do not match';
  return null;
}
