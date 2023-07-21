class Validator {
  static String? validateGeneralField(String value) {
    if (value.isEmpty) {
      return "Required Field";
    }

    return null;
  }

  static String? validateMale(String value) {
    if (value.isEmpty) {
      return "Required Field";
    }
    int? intValue = int.tryParse(value);

    if (intValue != null) {
      if (intValue < 0) {
        return "Invalid Male Count.";
      }
    } else {
      return "Invalid Male Count.";
    }
    return null;
  }

    static String? validateFemale(String value) {
    if (value.isEmpty) {
      return "Required Field";
    }
    int? intValue = int.tryParse(value);

    if (intValue != null) {
      if (intValue < 0) {
        return "Invalid Female Count.";
      }
    } else {
      return "Invalid Female Count.";
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
