import 'package:flutter/material.dart';
import 'package:staff_support_system_flutter/constants/colors.dart';

Widget loadingIndicator(){
  return  Center(child: Container( decoration: BoxDecoration(color: Colors.transparent), child: CircularProgressIndicator( color: Colors.grey,backgroundColor: Colors.transparent, valueColor: AlwaysStoppedAnimation(primayColor))),);
}