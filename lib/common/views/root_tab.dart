import 'package:flutter/material.dart';
import 'package:login/common/layout/default.dart';

class RootTab extends StatelessWidget {
  const RootTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultScaffold(
      child: Center(
        child: Text('Root Tab'),
      ),
    );
  }
}
