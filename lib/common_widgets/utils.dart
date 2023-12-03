

import 'package:flutter/cupertino.dart';

void hideKeyboard(){
  return FocusManager.instance.primaryFocus?.unfocus();
}