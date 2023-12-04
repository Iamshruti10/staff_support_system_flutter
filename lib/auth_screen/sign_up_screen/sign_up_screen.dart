import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staff_support_system_flutter/HomePage/HomePage.dart';
import 'package:staff_support_system_flutter/auth_screen/login_screen/login_screen.dart';
import 'package:staff_support_system_flutter/auth_screen/mobile_screen/mobile_screen.dart';
import 'package:staff_support_system_flutter/common_widgets/commonloadingIndicator.dart';
import 'package:staff_support_system_flutter/common_widgets/utils.dart';
import 'package:staff_support_system_flutter/firebase_auth/firebaseauthhelper.dart';

import '../../HomePage/HomePage_Start.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/common_textformfield.dart';
import '../../constants/colors.dart';
import '../../constants/fontstyle.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

// validate email and pass
bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegex.hasMatch(email);
}

bool isValidPass(dynamic pass) {
  final passRegx = RegExp(
      r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+])[a-zA-Z0-9!@#$%^&*()_+]+$');
  return passRegx.hasMatch(pass);
}

// controllers
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();

//check box
var isCheckd = false;

// loading
var isLoading = false;

// show passs
var isShow = false;

//key for form
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _SignUpScreenState extends State<SignUpScreen> {
  // sign up validation
  bool signupValidation(
    String email,
    String password,
  ) {
    if (email.isEmpty && password.isEmpty) {
      showMessage(
          context: context, message: 'All fields are empty', bgcolor: redColor);
      return false;
    } else if (email.isEmpty) {
      showMessage(
          message: 'Email is Empty', context: context, bgcolor: redColor);
      return false;
    } else if (password.isEmpty) {
      showMessage(
          message: 'Password is Empty', bgcolor: redColor, context: context);
      return false;
    } else {
      return true;
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () => hideKeyboard(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgGreyColor,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: bgGreyColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              height: 180,
              child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 32,
                          fontFamily: bold,
                          fontWeight: FontWeight.w700),
                    ),
                  )),
            ),
            Expanded(
              child: Card(
                elevation: 0,
                color: textWhiteColor,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        commonTextFormField(
                            controller: emailController,
                            title: 'Your Email',
                            hintText: 'Enter Your Email',
                            obscureText: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email address';
                              } else if (!isValidEmail(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            suffixIcon: const Icon(Icons.email)),
                        const SizedBox(
                          height: 20,
                        ),
                        commonTextFormField(
                            controller: passwordController,
                            title: 'Password',
                            hintText: 'Enter Your Password',
                            obscureText: !isShow,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6 ||
                                  value.length > 10) {
                                return 'Password must be 6 to 10 characters long';
                              } else if (!isValidPass(value)) {
                                return 'Password must contain at least one digit, one special character, and letters';
                              }
                            },
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  isShow = !isShow;
                                },
                                child: Icon(isShow
                                    ? Icons.visibility_off
                                    : Icons.visibility))),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: isCheckd,
                              onChanged: (newVaalue) {
                                setState(() {
                                  isCheckd = newVaalue!;
                                });
                              },
                              activeColor: primayColor,
                              checkColor: textWhiteColor,
                            ),
                            Flexible(
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'By creating an account you have to agree with our them & condication.',
                                      style: TextStyle(
                                          fontFamily: regular,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: lightGreyColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 327,
                          height: 50,
                          child: isLoading
                              ? loadingIndicator()
                              : commonButton(
                                  title: 'Create account',
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      if (emailController.text.isEmpty &&
                                          passwordController.text.isEmpty) {
                                        showMessage(
                                          context: context,
                                          message: 'Both fields are empty',
                                          bgcolor: redColor,
                                        );
                                      } else if (emailController.text.isEmpty) {
                                        showMessage(
                                          context: context,
                                          message: 'Please Enter Email',
                                          bgcolor: redColor,
                                        );
                                      } else if (passwordController
                                          .text.isEmpty) {
                                        showMessage(
                                          context: context,
                                          message: 'Please Enter Password',
                                          bgcolor: redColor,
                                        );
                                      } else {
                                        // Validate email and password
                                        bool isValidated = signupValidation(
                                          emailController.text,
                                          passwordController.text,
                                        );

                                        if (isValidated) {
                                          // Attempt to sign up
                                          bool isSignedUp =
                                              await FirebaseAuthHelper
                                                  .firebaseAuthHelper
                                                  .signUp(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            context: context,
                                          );

                                          if (isSignedUp) {
                                            // Successful signup
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MobileScreen(),
                                              ),
                                            );
                                            showSuccessMessage(
                                              context: context,
                                              bgcolor: greenColor,
                                              message: 'Email Verified',
                                            );
                                          }

                                        }
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } catch (e) {
                                      // Handle any unexpected errors
                                      print('Signup Error: $e');
                                      Navigator.pop(context);
                                      showMessage(
                                        context: context,
                                        message: e.toString(),
                                        bgcolor: redColor,
                                      );
                                    }
                                  }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Already have an account? ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: regular,
                                      fontWeight: FontWeight.w400,
                                      color: lightGreyColor),
                                ),
                                TextSpan(
                                  text: 'Log In',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                      fontFamily: regular,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: primayColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
/*
*   onPressed: () async {
                              if (emailController.text.isEmpty &&
                                  passwordController.text.isEmpty) {
                                showMessage(
                                    context: context,
                                    message: 'Both fields are Empty',
                                    bgcolor: redColor);
                              } else if (emailController.text.isEmpty) {
                                showMessage(
                                    context: context,
                                    message: 'Email Fields Is Empty',
                                    bgcolor: redColor);
                              } else if (passwordController.text.isEmpty) {
                                showMessage(
                                    context: context,
                                    message: 'Password Fields Is Empty',
                                    bgcolor: redColor);
                              } else if (_formKey.currentState!.validate()) {
                                try{
                                  bool isSignUp = await FirebaseAuthHelper
                                      .firebaseAuthHelper
                                      .signUp(
                                      context: context,
                                      email: emailController.text,
                                      password: passwordController.text);
                                  if (isSignUp) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const MobileScreen()));
                                    showMessage(
                                        context: context,
                                        message: 'Email & Password is verify',
                                        bgcolor: primayColor);
                                  }
                                }catch (e) {
                                  // Handle any exceptions that might occur during the login process
                                  print('Login Error: $e');
                                  showMessage(
                                    context: context,
                                    message: 'An error occurred during login.',
                                    bgcolor: redColor,
                                  );
                                }

                              }

                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const MobileScreen())
                              // );
                            }
* */
