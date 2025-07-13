import 'package:flutter/material.dart';


class Validate{
  static String? validatePassword(String? password) {
    var passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    if(password!=null && password.length>=8 && passwordRegExp.hasMatch(password)){
      return null;
    }else{
      return "";
    }
  }
  static String? validateNewPassword(String? newPassword,) {
    var passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    newPassword ??= "";
    if(newPassword.length>=8 && passwordRegExp.hasMatch(newPassword)){
      return null;
    }else{
      return "";
    }
  }
  static String? validateConfPassword({
    required String newPassword,
    required String confPassword
  }) {
    if(newPassword.characters==confPassword.characters){
      return null;
    }else{
      return "";
    }
  }
  static String? validateEmail(String? email) {
      if (email == null || email.isEmpty) return "";
      return null;
  }

  static String? validateNormalString(String? text) {
    if (text?.isEmpty ?? true) return "";
    return null;
  }

  static String? validateDropDown(dynamic value) {
    return value == null?"":null;
  }
}