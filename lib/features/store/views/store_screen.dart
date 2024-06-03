import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/common/constant/gaps.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/common/model/cursor_pagination_model.dart';
import 'package:login/features/store/view_models/store_vm.dart';
import 'package:login/features/store/views/detail_screen.dart';
import 'package:login/features/store/widgets/store_card.dart';

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({super.key});

  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen> {
  final scrollCont = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollCont.addListener(_pagination);
  }

  void _pagination() {
    if (scrollCont.offset > scrollCont.position.maxScrollExtent - 300) {
      ref.read(storeProvider.notifier).paginate(
        fetchMore: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(storeProvider);

    if (state is CursorPaginationIsLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    if (state is CursorPaginationError) {
      return Center(
        child: Text(
          state.message,
          style: const TextStyle(
            fontSize: Sizes.size14,
          ),
        ),
      );
    }

    final list = state as CursorPaginationModel;

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.size24,
        horizontal: Sizes.size20,
      ),
      child: ListView.separated(
        controller: scrollCont,
        itemBuilder: (context, index) {
          final model = list.data[index];

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
        itemCount: list.data.length,
      ),
    );
  }
}
