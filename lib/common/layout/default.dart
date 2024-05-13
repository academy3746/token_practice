import 'package:flutter/material.dart';
import 'package:login/common/constant/sizes.dart';

class DefaultScaffold extends StatelessWidget {
  const DefaultScaffold({
    super.key,
    required this.child,
    this.backgroundColor,
    this.title,
    this.centerTitle,
    this.bottomNavigationBar,
  });

  final Widget child;

  final Color? backgroundColor;

  final String? title;

  final bool? centerTitle;

  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: _buildAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? _buildAppBar() {
    if (title == null) {
      return null;
    }

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle ?? false,
      title: Text(
        title!,
        style: const TextStyle(
          fontSize: Sizes.size18,
          fontWeight: FontWeight.w700,
        ),
      ),
      foregroundColor: Colors.black,
    );
  }
}
