import 'package:flutter/material.dart';
import 'package:staff_support_system_flutter/HomePage/HomePage_Start.dart';
import 'package:staff_support_system_flutter/auth_screen/login_screen/login_screen.dart';
import 'package:staff_support_system_flutter/auth_screen/sign_up_screen/sign_up_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}





