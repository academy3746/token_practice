import 'package:flutter/material.dart';
import 'package:login/common/constant/colors.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/common/layout/default.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: 'Yamette!',
      centerTitle: true,
      bottomNavigationBar: _buildBottomWidget(),
      child: const Center(
        child: Text('Root Tab'),
      ),
    );
  }

  Widget _buildBottomWidget() {
    return BottomNavigationBar(
      backgroundColor: Colors.black87,
      selectedItemColor: primaryColor,
      unselectedItemColor: bodyTextColor,
      selectedFontSize: Sizes.size10,
      unselectedFontSize: Sizes.size10,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'HOME',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood_outlined),
          label: 'FOOD',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_outlined),
          label: 'ORDER',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_outlined),
          label: 'PROFILE',
        ),
      ],
    );
  }
}
