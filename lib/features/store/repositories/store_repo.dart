import 'package:dio/dio.dart' hide Headers;
import 'package:login/features/product/models/detail_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'store_repo.g.dart';

@RestApi()
abstract class StoreRepository {
  factory StoreRepository(Dio dio, {String baseUrl}) = _StoreRepository;

  /*@GET('/')
  paginate();*/

  @GET('/{id}')
  @Headers({
    'accessToken': 'true'
  })
  Future<StoreDetailModel> getStoreDetail({
    @Path() required String id,
  });
}