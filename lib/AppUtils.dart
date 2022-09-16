class AppUtils {
  static validateEmail(String email) {
    if (RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
        .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  static validateProfile(String firstName) {
    if (RegExp(r'^[a-zA-Z]{1,256}$').hasMatch(firstName)) {
      return true;
    } else {
      return false;
    }
  }

  static validateProfilelastName(String lastName) {
    if (RegExp(r'^[a-zA-Z]{1,256}$').hasMatch(lastName)) {
      return true;
    } else {
      return false;
    }
  }

  static validateProfilemobileNumber(String mobileNumber) {
    if (RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(mobileNumber)) {
      return true;
    } else {
      return false;
    }
  }

  static validateProfilestate(String state) {
    if (RegExp('[a-zA-Z," ", "   "]').hasMatch(state)) {
      return true;
    } else {
      return false;
    }
  }

  static validateProfilecity(String city) {
    if (RegExp('[a-zA-Z," ", " "').hasMatch(city)) {
      return true;
    } else {
      return false;
    }
  }

  static validateProfilezipCode(String zipCode) {
    if (RegExp(r"[0-6]").hasMatch(zipCode)) {
      return true;
    } else {
      return false;
    }
  }

  static forgotPassword(String email) {
    if (RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
        .hasMatch(email.trim())) {
      return true;
    } else {
      return false;
    }
  }

  static password(String password) {
    if (RegExp('([a-zA-Z][0-9]+)@').hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  static otp(String otp) {
    if (RegExp(r"^\s*-?[0-9]{1,4}\s*$").hasMatch(otp)) {
      return true;
    } else {
      return false;
    }
  }

  static checkPassword(String value, _userName) {
    if (value == null || value.trim().isEmpty) {
      return "Please Re-Enter New Password";
    } else if (value != _userName) {
      return "Password must be same as above";
    }
    return null;
  }

  static feet(String feet) {
    if (RegExp(r"^\s*-?[0-9]{1,4}\s*$").hasMatch(feet)) {
      return true;
    } else {
      return false;
    }
  }
}
