import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/common/model/cursor_pagination_model.dart';
import 'package:login/features/store/repositories/store_repo.dart';

final storeProvider =
    StateNotifierProvider<StoreViewModel, CursorPaginationBase>(
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

  Future<void> paginate({
    /// 20개씩 Fetch
    int fetchCount = 20,

    /// 더 불러오기
    bool fetchMore = false,

    /// 강제 새로고침
    bool forcedReload = false,
  }) async {
    // TODO: 1. CursorPagination OnState
    // TODO: 2. CursorPagination IsLoading
    // TODO: 3. CursorPagination Error
    // TODO: 4. CursorPagination Reload
    // TODO: 5. CursorPagination More
  }
}
