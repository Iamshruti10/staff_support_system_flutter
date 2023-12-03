import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staff_support_system_flutter/HomePage/HomePage.dart';
import 'package:staff_support_system_flutter/auth_screen/login_screen/login_screen.dart';

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

var isCheckd = false;

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 327,
                      height: 50,
                      child: commonButton(title: 'Create account', onPressed: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePagestart()));
                      }),
                    ),
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
                                      color: ligthGreyColor),
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
                                  color: ligthGreyColor),
                            ),
                            TextSpan(
                              text: 'Log In',

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
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
