import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/common/constant/data.dart';
import 'package:login/common/dio/repositories/dio_repo.dart';
import 'package:login/common/model/cursor_pagination_model.dart';
import 'package:login/common/model/pagination_params.dart';
import 'package:login/features/product/models/detail_model.dart';
import 'package:login/features/store/models/store_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'store_repo.g.dart';

final storeRepositoryProvider = Provider<StoreRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    final repo = StoreRepository(
      dio,
      baseUrl: 'http://$ip/restaurant',
    );

    return repo;
  },
);

@RestApi()
abstract class StoreRepository {
  factory StoreRepository(Dio dio, {String baseUrl}) = _StoreRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPaginationModel<StoreModel>> paginate({
    @Queries() PaginationParameters? params = const PaginationParameters(),
  });

  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<StoreDetailModel> getStoreDetail({
    @Path() required String id,
  });
}
