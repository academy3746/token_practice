import 'package:json_annotation/json_annotation.dart';
import 'package:login/common/utils/data_utils.dart';

part 'product_model.g.dart';

@JsonSerializable()
class StoreProductModel {
  final String id;

  final String name;

  final String detail;

  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl;

  final int price;

  StoreProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  factory StoreProductModel.fromJson(Map<String, dynamic> json) =>
      _$StoreProductModelFromJson(json);
  
}
