import 'package:flutter/material.dart';
import 'package:login/common/constant/colors.dart';
import 'package:login/features/splash/views/splash_screen.dart';
import 'package:login/features/store/views/detail_screen.dart';

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
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        StoreDetailScreen.routeName: (context) => const StoreDetailScreen(),
      },
    );
  }
}