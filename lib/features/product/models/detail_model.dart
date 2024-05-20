import 'package:json_annotation/json_annotation.dart';
import 'package:login/common/utils/data_utils.dart';
import 'package:login/features/product/models/product_model.dart';
import 'package:login/features/store/models/store_model.dart';

part 'detail_model.g.dart';

@JsonSerializable()
class StoreDetailModel extends StoreModel {
  final String detail;

  final List<StoreProductModel> products;

  StoreDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory StoreDetailModel.fromJson(Map<String, dynamic> json) => _$StoreDetailModelFromJson(json);
}
