class Validators {

  static String? name(String? value) {

    if (value == null || value.isEmpty) {
      return "Name is required";
    }

    if (value.length < 3) {
      return "Name must be at least 3 characters";
    }

    return null;
  }

  static String? email(String? value) {

    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    if (!value.contains("@")) {
      return "Enter valid email";
    }

    return null;
  }

  static String? password(String? value) {

    if (value == null || value.isEmpty) {
      return "Password required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
   

    return null;
  }

  static String? confirmPassword(String? value, String password) {

  if (value == null || value.isEmpty) {
    return "Confirm password is required";
  }

  if (value != password) {
    return "Passwords do not match";
  }

  return null;
}


  static String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Code is required';
    }
    if (value.length != 6) {
      return 'Code must be 6 digits';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Code must contain only digits';
    }
    return null;
  }

}
