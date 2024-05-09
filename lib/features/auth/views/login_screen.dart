import 'package:flutter/material.dart';
import 'package:login/common/constant/gaps.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/common/widgets/common_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = '/';

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.size16,
        horizontal: Sizes.size20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonTextField(
            hintText: '이메일을 입력해 주세요',
            autofocus: true,
            onChanged: (value) {},
          ),
          Gaps.v8,
          CommonTextField(
            hintText: '비밀번호를 입력해 주세요',
            obscureText: true,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _buildBody(context),
      ),
    );
  }
}
