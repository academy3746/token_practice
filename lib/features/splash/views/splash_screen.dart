import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/common/constant/colors.dart';
import 'package:login/common/constant/data.dart';
import 'package:login/common/constant/gaps.dart';
import 'package:login/common/dio/repositories/secure_repo.dart';
import 'package:login/common/layout/default.dart';
import 'package:login/common/views/root_tab.dart';
import 'package:login/features/auth/views/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _checkTokens();
  }

  Future<void> _checkTokens() async {
    final storage = ref.read(secureStorageProvider);

    final refreshToken = await storage.read(key: refreshTokenKey);

    await storage.read(key: accessTokenKey);

    final dio = Dio();

    try {
      final res = await dio.post(
        'http://$ip/auth/token',
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
          },
        ),
      );

      await storage.write(
        key: accessTokenKey,
        value: res.data['accessToken'],
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RootTab()),
        );
      });
    } catch (e) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(
          context,
          LoginScreen.routeName,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      backgroundColor: primaryColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            Gaps.v16,
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
