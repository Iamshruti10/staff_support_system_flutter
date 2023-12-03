import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staff_support_system_flutter/HomePage/HomePage.dart';
import 'package:staff_support_system_flutter/auth_screen/sign_up_screen/sign_up_screen.dart';
import 'package:staff_support_system_flutter/common_widgets/utils.dart';
import 'package:staff_support_system_flutter/constants/colors.dart';

import '../../HomePage/HomePage_Start.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/common_textformfield.dart';
import '../../constants/fontstyle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      commonTextFormField(
                          title: 'Your Email',
                          hintText: 'Enter Your Email',
                          obscureText: false,
                          suffixIcon: const Icon(Icons.email)),
                      const SizedBox(
                        height: 20,
                      ),
                      commonTextFormField(
                          title: 'Password',
                          hintText: 'Enter Your Password',
                          obscureText: true,
                          suffixIcon: const Icon(Icons.visibility)),
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
                        child: commonButton(title: 'Log In',onPressed: (){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePagestart()));
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
                                  builder: (context) => const SignUpScreen()));
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
                                    color: ligthGreyColor),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              width: 100,
                              child: Divider(
                                color: ligthGreyColor,
                              )),
                          Text(
                            'Or login with',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: regular,
                                color: ligthGreyColor,
                                fontSize: 12),
                          ),
                          SizedBox(
                              width: 100,
                              child: Divider(
                                color: ligthGreyColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/Icons/google_logo.png',
                              width: 35,
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
            )
          ],
        ),
      ),
    ));
  }
}
