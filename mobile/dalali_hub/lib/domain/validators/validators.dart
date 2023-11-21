String? validateEmail(String? email) {
  if (email == null) {
    return 'Email is required';
  }
  // regex for email validation
  const String emailRegex = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
  final RegExp emailRegExp = RegExp(emailRegex);
  if (email.isEmpty) {
    return 'Email is required';
  } else if (!emailRegExp.hasMatch(email)) {
    return 'Invalid email';
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null) {
    return 'Password is required';
  }
  const String passwordRegex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  final RegExp passwordRegExp = RegExp(passwordRegex);
  if (password.isEmpty) {
    return 'Password is required';
  } else if (!passwordRegExp.hasMatch(password)) {
    return 'Password must contain at least 8 characters, 1 uppercase, 1 lowercase, 1 number and 1 special character';
  }
  return null;
}

String? validatePhoneNumber(String? phoneNumber) {
  if (phoneNumber == null) {
    return 'Phone number is required';
  }
  const String phoneNumberRegex = r'^\+\d{12}$';
  final RegExp phoneNumberRegExp = RegExp(phoneNumberRegex);
  if (phoneNumber.isEmpty) {
    return 'Phone number is required';
  } else if (!phoneNumberRegExp.hasMatch(phoneNumber)) {
    return 'Invalid phone number';
  }
  return null;
}

String? validateName(String? name) {
  if (name == null) {
    return 'Name is required';
  }
  const String nameRegex = r'^[a-zA-Z]+$';
  final RegExp nameRegExp = RegExp(nameRegex);
  if (name.isEmpty) {
    return 'Name is required';
  } else if (!nameRegExp.hasMatch(name)) {
    return 'Invalid name';
  }
  return null;
}

String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return 'Confirm password is required';
  } else if (password == null || password != confirmPassword) {
    return 'Password does not match';
  }
  return null;
}

String? validateEnum(String? value, List<String> enumValues) {
  var uniqueValues = Set.of(enumValues);
  if (value == null) {
    return 'Value is required';
  } else if (!uniqueValues.contains(value)) {
    return 'Invalid value';
  }
  return null;
}
