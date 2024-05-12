import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login/common/constant/colors.dart';
import 'package:login/common/constant/gaps.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/common/layout/default.dart';
import 'package:login/common/widgets/common_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = '/';

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
          onChanged: (value) {},
        ),
        Gaps.v8,
        CommonTextField(
          hintText: '비밀번호를 입력해 주세요',
          obscureText: true,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _accessField() {
    final dio = Dio();

    const androidIp = '10.0.2.2:3000';

    const iosIp = '127.0.0.1:3000';

    final ip = Platform.isAndroid ? androidIp : iosIp;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              /// ID:Password
              const rawString = 'test@codefactory.ai:testtest';

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

              print(res.data);
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
            onPressed: () async {
              const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTcxNTUyMTcyOCwiZXhwIjoxNzE1NjA4MTI4fQ.5cWC1z_XdHZ_-AFEwIBXJPGkxAlzO5-Yx38PyKOHCVI';

              final res = await dio.post(
                'http://$ip/auth/token',
                options: Options(
                  headers: {
                    'Authorization': 'Bearer $token',
                  },
                ),
              );

              print(res.data);
            },
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
