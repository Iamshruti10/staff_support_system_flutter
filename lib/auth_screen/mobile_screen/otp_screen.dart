import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:staff_support_system_flutter/HomePage/HomePage_Start.dart';
import 'package:staff_support_system_flutter/common_widgets/common_button.dart';
import 'package:staff_support_system_flutter/common_widgets/utils.dart';
import 'package:staff_support_system_flutter/constants/colors.dart';
import 'package:staff_support_system_flutter/constants/fontstyle.dart';

class OtpScreen extends StatefulWidget {
  String number;
  String verificationId;
  OtpScreen({super.key, required this.number, required this.verificationId});

  // code

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _OtpScreenState extends State<OtpScreen> {
  var code = '';
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20, color: textColor, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: lightGreyColor),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: primayColor),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(

                    icon: const Icon(
                      Icons.close,
                      size: 28,
                      color: textColor,
                    ), onPressed: () {
                      Navigator.pop(context);
                  },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  const Text(
                    'Verify Phone',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: medium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 180),
            Text(
              'Code is sent to ${widget.number}',
              style: TextStyle(
                  fontFamily: regular,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: textGrayColor),
            ),
            const SizedBox(height: 25),
            Center(
              child: Pinput(
                mainAxisAlignment: MainAxisAlignment.center,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                validator: (s) {
                  return s == '${code}' ? null : 'Pin is incorrect';
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
              ),
            ),
            const SizedBox(height: 91),
            SizedBox(
                height: 50,
                child: commonButton(
                    title: 'Verify and Create Account',
                    onPressed: () async {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: code);
                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePagestart()));
                      showSuccessMessage(
                          message: 'Account Successfully Created',
                          context: context,
                          bgcolor: greenColor);
                    }))
          ],
        ),
      ),
    );
  }
}
