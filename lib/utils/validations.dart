class Validations {
  static String? validatePhoneNumber(String? number) {
    final RegExp regex = RegExp(r'^[0-9]+$');
    if (!regex.hasMatch(number!)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final RegExp regex =
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r'{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]'
            r'{0,253}[a-zA-Z0-9])?)*$');
    if (!regex.hasMatch(value!.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validateWebsiteDomain(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a website';
    }

    final RegExp regex = RegExp(
      r'^(http:\/\/|https:\/\/)?([a-z0-9][a-z0-9\-]*\.)+[a-z0-9][a-z0-9\-]*$',
      caseSensitive: false,
    );

    if (!regex.hasMatch(value.trim())) {
      return 'Enter a valid website';
    }

    return null;
  }

  static String? validateFirstName(String? name) {
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z]+$');
    if (name!.isEmpty) {
      return 'Please enter your first name';
    } else if (!nameRegExp.hasMatch(name)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  static String? validateLastName(String? name) {
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z]+$');
    if (name!.isEmpty) {
      return 'Please enter your last name';
    } else if (!nameRegExp.hasMatch(name)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'Please enter a password';
    } else if (password.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
  }
}
