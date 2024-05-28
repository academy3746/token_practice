import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/common/model/cursor_pagination_model.dart';
import 'package:login/features/store/repositories/store_repo.dart';

final storeProvider = StateNotifierProvider<StoreViewModel, CursorPaginationBase>(
  (ref) {
    final repo = ref.watch(storeRepositoryProvider);

    final notifier = StoreViewModel(repo: repo);

    return notifier;
  },
);

class StoreViewModel extends StateNotifier<CursorPaginationBase> {
  final StoreRepository repo;

  StoreViewModel({
    required this.repo,
  }) : super(CursorPaginationIsLoading()) {
    paginate();
  }

  Future<void> paginate() async {
    final res = await repo.paginate();

    state = res;
  }
}
