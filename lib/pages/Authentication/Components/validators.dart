class Validator {

  static String? validateUsername(String username){

    if(username.isEmpty){
      return "Required Field";
    }

    return null;

  }

  static String? validatePassword(String password){

    if(password.isEmpty){
      return "Required Field";
    }

    if(password.length < 8){
      return "Password cannot be less than 8 characters";
    }

    return null;

  }
  
}