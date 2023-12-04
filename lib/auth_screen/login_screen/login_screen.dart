import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staff_support_system_flutter/HomePage/HomePage.dart';
import 'package:staff_support_system_flutter/auth_screen/sign_up_screen/sign_up_screen.dart';
import 'package:staff_support_system_flutter/common_widgets/utils.dart';
import 'package:staff_support_system_flutter/constants/colors.dart';
import 'package:staff_support_system_flutter/firebase_auth/firebaseauthhelper.dart';

import '../../HomePage/HomePage_Start.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/common_textformfield.dart';
import '../../common_widgets/commonloadingIndicator.dart';
import '../../constants/fontstyle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
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

//controller
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

//show pass
var isShow = false;
// loading
var isLoading = false;

//all loading
var isallLoading = false;
//key for form
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  @override
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
                            'Log In',
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
                          canPop: false,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              commonTextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your email address';
                                    } else if (!isValidEmail(value)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  title: 'Your Email',
                                  hintText: 'Enter Your Email',
                                  obscureText: false,
                                  suffixIcon: const Icon(Icons.email)),
                              const SizedBox(
                                height: 20,
                              ),
                              commonTextFormField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
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
                                        setState(() {
                                          isShow = !isShow;
                                        });
                                      },
                                      child: Icon(isShow
                                          ? Icons.visibility_off
                                          : Icons.visibility))),
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        color: textColor,
                                        fontSize: 14,
                                        fontFamily: regular,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
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
                                          title: 'Log In',
                                          onPressed: () async {
                                            if (emailController.text.isEmpty) {
                                              showMessage(
                                                context: context,
                                                message: 'Please Enter Email',
                                                bgcolor: redColor,
                                              );
                                            } else if (passwordController
                                                .text.isEmpty) {
                                              showMessage(
                                                context: context,
                                                message:
                                                    'Please Enter Password',
                                                bgcolor: redColor,
                                              );
                                            } else {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              try {
                                                // Call your login method from FirebaseAuthHelper
                                                bool login =
                                                    await FirebaseAuthHelper
                                                        .firebaseAuthHelper
                                                        .login(
                                                  context: context,
                                                  password:
                                                      passwordController.text,
                                                  email: emailController.text,
                                                );

                                                if (login) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomePagestart(),
                                                    ),
                                                  );
                                                  showSuccessMessage(
                                                    bgcolor: greenColor,
                                                    context: context,
                                                    message:
                                                        'Login Successfully',
                                                  );
                                                } else {
                                                  showMessage(
                                                    context: context,
                                                    message:
                                                        'Login Failed. Check your credentials. Email does not exist or password is wrong',
                                                    bgcolor: redColor,
                                                  );
                                                }
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              } catch (e) {
                                                // Handle any exceptions that might occur during the login process
                                                print('Login Error: $e');
                                                showMessage(
                                                  context: context,
                                                  message:
                                                      'An error occurred during login.',
                                                  bgcolor: redColor,
                                                );
                                              }
                                            }
                                          },
                                        )),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()));
                                },
                                child: RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Don't have an account? ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: regular,
                                            fontWeight: FontWeight.w400,
                                            color: lightGreyColor),
                                      ),
                                      TextSpan(
                                        text: 'Sign Up',
                                        style: TextStyle(
                                            fontFamily: regular,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: primayColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                      width: 100,
                                      child: Divider(
                                        color: lightGreyColor,
                                      )),
                                  Text(
                                    'Or login with',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: regular,
                                        color: lightGreyColor,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                      width: 100,
                                      child: Divider(
                                        color: lightGreyColor,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await FirebaseAuthHelper
                                            .firebaseAuthHelper
                                            .signInWithGoogle();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePagestart(),
                                          ),
                                        );
                                        showSuccessMessage(
                                          bgcolor: greenColor,
                                          context: context,
                                          message: 'Login Successfully',
                                        );
                                        setState(() {
                                          isLoading = false;
                                        });
                                      },
                                      child: Image.asset(
                                        'assets/Icons/google_logo.png',
                                        width: 35,
                                      ),
                                    ),
                                    Icon(
                                      Icons.facebook,
                                      size: 45,
                                      color: Colors.blue,
                                    ),
                                  ],
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
