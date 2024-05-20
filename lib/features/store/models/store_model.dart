import 'package:json_annotation/json_annotation.dart';
import 'package:login/common/utils/data_utils.dart';

part 'store_model.g.dart';

enum StorePriceRange {
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class StoreModel {
  final String id;

  final String name;

  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;

  final List<String> tags;

  final StorePriceRange priceRange;

  final double ratings;

  final int ratingsCount;

  final int deliveryTime;

  final int deliveryFee;

  StoreModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);
}
