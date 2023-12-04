import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_support_system_flutter/HomePage/HomePage_Start.dart';
import 'package:staff_support_system_flutter/auth_screen/mobile_screen/otp_screen.dart';
import 'package:staff_support_system_flutter/common_widgets/common_button.dart';
import 'package:staff_support_system_flutter/common_widgets/utils.dart';

import '../../common_widgets/common_textformfield.dart';
import '../../constants/colors.dart';
import '../../constants/fontstyle.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

TextEditingController phoneController = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;

class _MobileScreenState extends State<MobileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => hideKeyboard(),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              'Verify Phone',
              style: TextStyle(
                  fontFamily: bold,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: textColor),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: bgGreyColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                height: 250,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                Icons.visibility_off_outlined,
                                size: 25,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              'Continue with Phone',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: regular,
                                  fontWeight: FontWeight.w500,
                                  color: textColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Image.asset(
                          'assets/images/phone.png',
                          width: 128,
                          height: 128,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 0,
                  color: textWhiteColor,
                  child: Container(
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Enter Your Phone Number',
                          style: TextStyle(
                              fontFamily: regular,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: textGrayColor),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: lightGreyColor),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: TextField(
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  10)
                                            ],
                                            controller: phoneController,
                                            keyboardType: TextInputType.phone,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Phone",
                                            ),
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: SizedBox(
                                            height: 50,
                                            width: 124,
                                            child: commonButton(
                                                onPressed: () async {
                                                  try {
                                                    await FirebaseAuth.instance
                                                        .verifyPhoneNumber(
                                                      phoneNumber:
                                                          '+91${phoneController.text.trim()}',
                                                      verificationCompleted:
                                                          (PhoneAuthCredential
                                                              credential) async {
                                                        await auth
                                                            .signInWithCredential(
                                                                credential);
                                                      },
                                                      verificationFailed:
                                                          (FirebaseAuthException
                                                              e) {
                                                        if (e.code ==
                                                            'invalid-phone-number') {
                                                          showMessage(
                                                              message:
                                                                  'The provided phone number is not valid.',
                                                              context: context,
                                                              bgcolor:
                                                                  redColor);
                                                        }
                                                      },
                                                      codeSent: (String
                                                              verificationId,
                                                          int? resendToken) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        OtpScreen(
                                                                          number:
                                                                              phoneController.text,
                                                                          verificationId:
                                                                              verificationId,
                                                                        )));
                                                        showSuccessMessage(
                                                            context: context,
                                                            message:
                                                                'Otp Send to ${phoneController.text}',
                                                            bgcolor:
                                                                greenColor);
                                                      },
                                                      codeAutoRetrievalTimeout:
                                                          (String
                                                              verificationId) {},
                                                    );
                                                  } catch (e) {
                                                    Navigator.pop(context);
                                                    showMessage(
                                                        bgcolor: redColor,
                                                        message: e.toString(),
                                                        context: context);
                                                  }
                                                },
                                                title: 'Continue')),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Center(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomePagestart()));
                                  showSuccessMessage(
                                      context: context,
                                      message:
                                      'Successfully account Is Created',
                                      bgcolor: greenColor);
                                },
                                child:const Text(
                                  'Skip',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                      color: lightGreyColor,
                                      fontFamily: medium),
                                ))),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
