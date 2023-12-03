
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fontstyle.dart';

Widget commonButton({title, onPressed}){
  return  ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: primayColor,
      ),
      child:  Text(
        title,
        style:const TextStyle(
            color: textWhiteColor,
            fontWeight: FontWeight.w500,
            fontFamily: regular,
            fontSize: 16),
      ));
}