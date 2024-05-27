import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/common/constant/gaps.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/features/store/view_models/store_vm.dart';
import 'package:login/features/store/views/detail_screen.dart';
import 'package:login/features/store/widgets/store_card.dart';

class StoreScreen extends ConsumerWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cont = ref.watch(storeProvider);

    if (cont.isEmpty) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.size24,
        horizontal: Sizes.size20,
      ),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final model = cont[index];

          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return StoreDetailScreen(id: model.id);
                },
              ),
            ),
            child: StoreCard.fromModel(model: model),
          );
        },
        separatorBuilder: (context, index) => Gaps.v16,
        itemCount: cont.length,
      ),
    );
  }
}
