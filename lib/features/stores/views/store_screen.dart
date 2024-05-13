import 'package:flutter/material.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/features/stores/widgets/store_card.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.size24,
        horizontal: Sizes.size20,
      ),
      child: StoreCard(
        image: Image.asset(
          'assets/images/food/ddeok_bok_gi.jpg',
          fit: BoxFit.cover,
        ),
        name: '불타는 떡볶이',
        tags: const ['떡볶이', '치즈', '매운맛'],
        reviewCount: 100,
        deliveryTime: 15,
        deliveryCost: 2000,
        rating: 4.5,
      ),
    );
  }
}
