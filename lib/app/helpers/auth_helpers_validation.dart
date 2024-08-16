class AuthHelpers {
  String? nameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!value.contains("@")) {
      return "Email must have @";
    }
    return null;
  }

  String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length <= 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  String? confirmPasswordValidation(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Password confirmation is required";
    } else if (confirmPassword.length < 8) {
      return "Password must be at least 8 characters long";
    } else if (confirmPassword != password) {
      return "Password confirmation does not match password";
    }
    return null;
  }
}
