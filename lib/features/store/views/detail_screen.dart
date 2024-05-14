import 'package:flutter/material.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/common/layout/default.dart';
import 'package:login/features/product/widgets/product_card.dart';
import 'package:login/features/store/widgets/store_card.dart';

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
      title: '피자타임',
      centerTitle: true,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        child: CustomScrollView(
          slivers: [
            _buildTop(),
            _buildLabel(),
            _buildProduct(),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(
          top: Sizes.size24,
          left: Sizes.size20,
          right: Sizes.size20,
        ),
        child: const Text(
          '메뉴',
          style: TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SliverToBoxAdapter(
      child: StoreCard(
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
    );
  }

  Widget _buildProduct() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size20,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Container(
            margin: const EdgeInsets.only(
              top: Sizes.size16,
            ),
            child: const ProductCard(),
          ),
          childCount: 10,
        ),
      ),
    );
  }
}
