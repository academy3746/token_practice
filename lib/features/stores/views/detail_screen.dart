import 'package:flutter/material.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/common/layout/default.dart';
import 'package:login/features/stores/widgets/store_card.dart';

class StoreDetailScreen extends StatefulWidget {
  const StoreDetailScreen({super.key});

  static const String routeName = '/detail';

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: '불타는 떡볶이',
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StoreCard(
              image: Image.asset('assets/images/food/pizza_ddeok_bok_gi.jpg'),
              name: '피자타임',
              tags: const ['불고기', '페페로니', '할라피뇨'],
              ratingsCount: 100,
              deliveryTime: 20,
              deliveryFee: 2500,
              ratings: 4.5,
              isDetail: true,
              detail: '할라피뇨 불고기 피자 존맛탱...',
            ),
          ],
        ),
      ),
    );
  }
}
