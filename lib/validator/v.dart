class V {
  static String? isEmailValid({required String? value}) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter email";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Please enter valid email";
    } else {
      return null;
    }
  }

  static String? isNameValid({required String? value}) {
    if (value == null || value.trim().toString().isEmpty) {
      return "Please enter name";
    } else if (!RegExp(r'^[a-z A-Z,.\-]+$').hasMatch(value)) {
      return "Please enter valid name";
    } else if (value.trim().length > 20) {
      return "Name length less than twenty";
    } else {
      return null;
    }
  }

  static String? isNumberValid({required String? value}) {
    if (value == null || value.trim().toString().isEmpty) {
      return "Please enter number";
    } else if (value.trim().length < 10 || value.trim().length > 12) {
      return "Please enter valid number";
    } else {
      return null;
    }
  }

  static String? isPasswordValid(
      {required String? value, String? password = "Not"}) {
    if (value == null || value.trim().toString().isEmpty) {
      return "Please enter password";
    } else if (value.trim().length < 6) {
      return "Password length greater than six";
    } else if (value.trim().length > 12) {
      return "Password length less than twelve";
    } else if (!RegExp("^(?=.*[a-z])").hasMatch(value)) {
      return "Password contain at least one lowercase";
    } else if (!RegExp("^(?=.*[A-Z])").hasMatch(value)) {
      return "Password contain at least one uppercase";
    } else if (!RegExp("^(?=.*[@#\$%^&+=]).*\$").hasMatch(value)) {
      return "Password contain at least one special character";
    } else if (!RegExp("^(?=.*[0-9])").hasMatch(value)) {
      return "Password contain at least one numeric character";
    } else if ((password?.trim().toString() != "Not")) {
      if (password?.trim().toString() == value.trim().toString()) {
        return null;
      } else {
        return "Please enter correct password";
      }
    } else {
      return null;
    }
  }

  static String? isValid({required String? value, required String title, Function? isValid}) {
    if (value == null || value.trim().toString().isEmpty) {
      isValid?.call(true);
      return title;
    } else {
      isValid?.call(false);
      return null;
    }
  }
}
