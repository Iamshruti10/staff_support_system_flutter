import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fontstyle.dart';

Widget commonTextFormField(
    {required String title,
    controller,
    obscureText = false,
    hintText,
    keyboardType,
    String? Function(String?)? validator,
    suffixIcon}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 18),
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: regular,
              color: textGrayColor,
              fontSize: 14),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          validator: validator,
          keyboardType: keyboardType,
          cursorColor: Colors.black,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: lightGreyColor,
              ),
            ),
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: regular,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
            isDense: true,
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: lightGreyColor,
              ),
            ),
             errorStyle: TextStyle(overflow: TextOverflow.ellipsis),
              errorBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  width: 1,
                  color: redColor,
                )),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  width: 1,
                  color: redColor,
                )),
            enabled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}
