import 'package:flutter/material.dart';
import 'package:login/common/constant/colors.dart';
import 'package:login/common/constant/sizes.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    this.hintText,
    this.errorText,
    this.obscureText,
    this.autofocus,
    required this.onChanged,
  });

  final String? hintText;

  final String? errorText;

  final bool? obscureText;

  final bool? autofocus;

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.size2),
      borderSide: const BorderSide(
        color: inputBorderColor,
      ),
    );

    return TextFormField(
      cursorColor: primaryColor,
      obscureText: obscureText ?? false,
      autofocus: autofocus ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(Sizes.size20),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: bodyTextColor,
          fontSize: Sizes.size14,
        ),
        fillColor: inputBgColor,
        filled: true,
        border: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: primaryColor,
          ),
        ),
        errorText: errorText,
      ),
    );
  }
}
