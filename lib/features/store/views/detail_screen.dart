import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login/common/constant/data.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/common/layout/default.dart';
import 'package:login/features/product/models/detail_model.dart';
import 'package:login/features/product/widgets/product_card.dart';
import 'package:login/features/store/widgets/store_card.dart';

class StoreDetailScreen extends StatelessWidget {
  const StoreDetailScreen({
    super.key,
    required this.rid,
  });

  final String rid;

  Future<Map<String, dynamic>> _getStoreDetail() async {
    final dio = Dio();

    final accessToken = await storage.read(key: accessTokenKey);

    final res = await dio.get(
      'http://$ip/restaurant/$rid',
      options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
      }),
    );

    return res.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: '피자타임',
      centerTitle: true,
      child: FutureBuilder(
        future: _getStoreDetail(),
        builder: (context, snapshot) {
          final listModel = snapshot.data;

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(fontSize: Sizes.size14),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          final model = StoreDetailModel.fromMap(listModel!);

          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: Sizes.size16,
            ),
            child: CustomScrollView(
              slivers: [
                _buildTop(model),
                _buildLabel(),
                _buildProduct(),
              ],
            ),
          );
        },
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

  Widget _buildTop(StoreDetailModel model) {
    return SliverToBoxAdapter(
      child: StoreCard.fromModel(
        model: model,
        isDetail: true,
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
