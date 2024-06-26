import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/common/constant/colors.dart';
import 'package:login/common/constant/data.dart';
import 'package:login/common/constant/gaps.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/common/dio/repositories/dio_repo.dart';
import 'package:login/common/dio/repositories/secure_repo.dart';
import 'package:login/common/layout/default.dart';
import 'package:login/common/views/root_tab.dart';
import 'package:login/common/widgets/common_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String userName = '';

  String password = '';

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Container(
          margin: const EdgeInsets.all(Sizes.size20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _introduce(context),
              Gaps.v16,
              _buildFormField(),
              Gaps.v16,
              _accessField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _introduce(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '환영합니다!',
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size32,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gaps.v8,
        const Text(
          '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 민첩한 하루가 되길! :)',
          style: TextStyle(
            color: bodyTextColor,
            fontSize: Sizes.size16,
          ),
        ),
        Gaps.v8,
        Center(
          child: Image.asset(
            'assets/images/misc/logo.png',
            width: MediaQuery.of(context).size.width / 3 * 2,
          ),
        ),
        Gaps.v16,
      ],
    );
  }

  Widget _buildFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextField(
          hintText: '이메일을 입력해 주세요',
          onChanged: (value) {
            userName = value;
          },
        ),
        Gaps.v8,
        CommonTextField(
          hintText: '비밀번호를 입력해 주세요',
          obscureText: true,
          onChanged: (value) {
            password = value;
          },
        ),
      ],
    );
  }

  Widget _accessField() {
    final dio = ref.watch(dioProvider);

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              /// ID:Password
              final rawString = '$userName:$password';

              Codec<String, String> stringToBase64 = utf8.fuse(base64);

              String token = stringToBase64.encode(rawString);

              final res = await dio.post(
                'http://$ip/auth/login',
                options: Options(
                  headers: {
                    'Authorization': 'Basic $token',
                  },
                ),
              );

              final refreshTokenValue = res.data['refreshToken'];

              final accessTokenValue = res.data['accessToken'];

              final storage = ref.read(secureStorageProvider);

              await storage.write(
                key: refreshTokenKey,
                value: refreshTokenValue,
              );

              await storage.write(
                key: accessTokenKey,
                value: accessTokenValue,
              );

              if (!mounted) return;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RootTab(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            child: const Text(
              '로그인',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              '회원가입',
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DefaultScaffold(
        child: _buildBody(context),
      ),
    );
  }
}
