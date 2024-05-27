import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/common/constant/gaps.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/features/store/repositories/store_repo.dart';
import 'package:login/features/store/views/detail_screen.dart';
import 'package:login/features/store/widgets/store_card.dart';

class StoreScreen extends ConsumerWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.size24,
        horizontal: Sizes.size20,
      ),
      child: FutureBuilder(
        future: ref.watch(storeRepositoryProvider).paginate(),
        builder: (context, snapshot) {
          final listModel = snapshot.data?.data ?? [];

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

          return ListView.separated(
            itemBuilder: (context, index) {
              var model = listModel[index];

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
            itemCount: listModel.length,
          );
        },
      ),
    );
  }
}
