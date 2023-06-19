import 'package:flutter/services.dart';

bool isvalidSSNNumber(String value) {
  bool isValid = false;
  String pattern = r'^(?:[1-9])?[0-9]{12}$';
  RegExp regExp = new RegExp(pattern);
  if (regExp.hasMatch(value)) {
    isValid = true;
  } else {
    isValid = false;
  }
  return isValid;
}

String validateEmail(String value) {
 late Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  // RegExp regex = RegExp(pattern);
  // if (value.isEmpty) {
  //   return 'Please enter email id';
  // } else {
  //   if (!regex.hasMatch(value)) {
  //     return 'Enter valid email id';
  //   } else {
      return "Success";
  //   }
  // }
}

String validatePassword(String value) {
  Pattern pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  // RegExp regex = RegExp(pattern);
  // print(value);
  // if (value.isEmpty) {
  //   return 'Please enter password';
  // } else {
  //   if (!regex.hasMatch(value)) {
  //     return 'Enter valid password';
  //   } else {
       return "Success";
  //   }
  // }
}

bool isvalidNumber(String value) {
  bool isValid = false;
  String pattern = r'^(?:[+])?[0-9]{9,12}$';
  RegExp regExp = new RegExp(pattern);
  if (regExp.hasMatch(value)) {
    isValid = true;
  } else {
    isValid = false;
  }
  return isValid;
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }
    return newValue;
  }
}
