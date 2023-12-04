import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staff_support_system_flutter/constants/colors.dart';
import 'package:staff_support_system_flutter/constants/fontstyle.dart';

// hide keyboard
void hideKeyboard() {
  return FocusManager.instance.primaryFocus?.unfocus();
}

// snakbar
void showMessage({message, context, bgcolor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(
          message.toString(),
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: medium,
              color: textWhiteColor),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
        backgroundColor: bgcolor,
        duration: const Duration(seconds: 2)),
  );

}
void showSuccessMessage({message, context, bgcolor}){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(
          message.toString(),
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: medium,
              color: textWhiteColor),
        ),
        behavior: SnackBarBehavior.floating,

        backgroundColor: bgcolor,
        duration: const Duration(seconds: 2)),
  );


}