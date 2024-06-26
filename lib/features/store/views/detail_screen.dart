import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/common/layout/default.dart';
import 'package:login/features/product/models/detail_model.dart';
import 'package:login/features/product/models/product_model.dart';
import 'package:login/features/product/widgets/product_card.dart';
import 'package:login/features/store/repositories/store_repo.dart';
import 'package:login/features/store/widgets/store_card.dart';

class StoreDetailScreen extends ConsumerWidget {
  const StoreDetailScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultScaffold(
      title: '피자타임',
      centerTitle: true,
      child: FutureBuilder(
        future: ref.watch(storeRepositoryProvider).getStoreDetail(id: id),
        builder: (context, snapshot) {
          final model = snapshot.data;

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

          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: Sizes.size16,
            ),
            child: CustomScrollView(
              slivers: [
                _buildTop(model!),
                _buildLabel(),
                _buildProduct(model.products),
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

  Widget _buildProduct(List<StoreProductModel> products) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size20,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            var model = products[index];

            return Container(
              margin: const EdgeInsets.only(
                top: Sizes.size16,
              ),
              child: ProductCard.fromModel(model),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
