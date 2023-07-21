class Validator {
  static String? validateGeneralField(String value) {
    if (value.isEmpty) {
      return "Required Field";
    }

    return null;
  }

  static String? validateAge(String value) {
    if (value.isEmpty) {
      return "Required Field";
    }
    int? intValue = int.tryParse(value);

    if (intValue != null) {
      if (intValue < 0) {
        return "Invalid Age.";
      } else if (intValue > 120) {
        return "Age cannot be greater than 120.";
      }
    } else {
      return "Invalid Age.";
    }
    return null;
  }

  static String? validateDropdownField(String value) {
    if (value.isEmpty || value == '-') {
      return "Required Field";
    }

    return null;
  }

  static String? validateAddress(String value) {
    if (value.isEmpty) {
      return "Required Field";
    }

    if(value.length > 40){
      return "Max characters for address is 40.";
    }

    return null;
  }
}
