import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:staff_support_system_flutter/common_widgets/utils.dart';
import 'package:staff_support_system_flutter/constants/colors.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> login({email, password, context}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle case where the email doesn't exist
        showMessage(
          context: context,
          message: 'Email does not exist.',
          bgcolor: redColor,
        );
      } else if (e.code == 'wrong-password') {
        // Handle case where the password is incorrect
        showMessage(
          context: context,
          message: 'Incorrect password.',
          bgcolor: redColor,
        );
      } else {
        // Handle other FirebaseAuthException cases
        // showMessage(
        //   context: context,
        //   message: 'Login failed. ${e.message}',
        //   bgcolor: redColor,
        // );
      }
      // Login unsuccessful
      return false;
    }

  }

  Future<bool> signUp({email, password, context}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pop(context);
      return userCredential != null;
    } on FirebaseAuthException catch (error) {
      showMessage(
        bgcolor: redColor,
        message: getMessageFromErrorCode(error.code.toString()),
        context: context,
      );
      return false;
    }
  }

   signOut()async{
    await firebaseAuthHelper.signOut();
  }

Future<UserCredential> signInWithGoogle() async{
   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

   // Obtain the auth details from the request
   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

   // Create a new credential
   final credential = GoogleAuthProvider.credential(
     accessToken: googleAuth?.accessToken,
     idToken: googleAuth?.idToken,

   );

   // Once signed in, return the UserCredential
   return await FirebaseAuth.instance.signInWithCredential(credential) ;



 }

  String getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return 'Email already used . Go to login page.';
      case "account-exitsts-with-different-credential":
        return 'Email already used . Go to login page.';
      case "email-already-in-use":
        return 'Email already used . Go to login page.';
      case "ERROR_WRONG_PASSWORD":
      case 'wrong-password':
        return 'Wrong Password';
      case "ERROR_USER_NOT_FOUND":
        return "No user found with this email";
      case "user-not-found":
        return "No user found with this email";
      case "ERROR_USER_DISABLED":
        return "User disabled";
      case "user-disabled":
        return "User disabled";
      case "ERROR_TOO_MANY_REQUESTS":
        return "Too many requests to log into this account";
      case "operation-not-allowed":
        return 'Too many requests to log into this account';
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "Too many requests to log into this account";
      case "ERROR_INVALID_EMAIL":
        return "Email address is invalid";
      case "invalid-email":
        return "E-mail address is invalid";
      default:
        return "Login failed. Please try again";
    }
  }
}
