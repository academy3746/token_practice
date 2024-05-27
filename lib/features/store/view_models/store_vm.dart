import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/common/model/cursor_pagination_model.dart';
import 'package:login/features/store/models/store_model.dart';
import 'package:login/features/store/repositories/store_repo.dart';

final storeProvider = StateNotifierProvider<StoreViewModel, List<StoreModel>>(
  (ref) {
    final repo = ref.watch(storeRepositoryProvider);

    final notifier = StoreViewModel(repo: repo);

    return notifier;
  },
);

class StoreViewModel extends StateNotifier<CursorPaginationModel> {
  final StoreRepository repo;

  StoreViewModel({required this.repo}) : super([]) {
    paginate();
  }

  Future<void> paginate() async {
    final res = await repo.paginate();

    state = res.data;
  }
}
