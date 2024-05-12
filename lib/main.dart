import 'package:flutter/material.dart';
import 'package:login/common/constant/colors.dart';

import 'features/auth/views/login_screen.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        fontFamily: 'NotoSans',
        primaryColor: primaryColor,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}