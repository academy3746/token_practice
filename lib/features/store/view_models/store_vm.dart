import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/common/model/cursor_pagination_model.dart';
import 'package:login/common/model/pagination_params.dart';
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
    /// TODO: 3. CursorPagination Error
    /// TODO: 4. CursorPagination Reload

    if (state is CursorPaginationModel && !forcedReload) {
      final pState = state as CursorPaginationModel;

      /// 1. CursorPagination OnState
      if (!pState.meta.hasMore!) {
        return;
      }
    }

    final isLoading = state is CursorPaginationIsLoading;
    final isReload = state is CursorPaginationReload;
    final isMore = state is CursorPaginationMore;

    /// 2. CursorPagination IsLoading
    if (isMore && (isLoading || isReload || isMore)) {
      return;
    }

    var params = PaginationParameters(
      count: fetchCount,
    );

    /// 3. CursorPagination More
    if (fetchMore) {
      final pState = state as CursorPaginationModel;

      state = CursorPaginationMore(
        meta: pState.meta,
        data: pState.data,
      );

      params = params.copyWith(
        after: pState.data.last.id,
      );
    }

    final res = await repo.paginate(
      params: params,
    );

    if (state is CursorPaginationMore) {
      final pState = state as CursorPaginationMore;

      /// Accumulate Data
      state = res.copyWith(
        data: [
          ...pState.data,
          ...res.data,
        ],
      );
    }
  }
}
