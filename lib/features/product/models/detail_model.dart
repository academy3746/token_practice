import 'package:login/common/constant/data.dart';
import 'package:login/features/product/models/product_model.dart';
import 'package:login/features/store/models/store_model.dart';

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

  @override
  Map<String, dynamic> toMap() {
    return {
      'detail': detail,
      'products': products,
    };
  }

  factory StoreDetailModel.fromJson(Map<String, dynamic> map) {
    return StoreDetailModel(
      detail: map['detail'] as String,
      products: map['products'].map<StoreProductModel>(
        (data) => StoreProductModel.fromJson(data),
      ).toList(),
      id: map['id'] as String,
      name: map['name'] as String,
      thumbUrl: 'http://$ip${map['thumbUrl']}',
      tags: List<String>.from(map['tags']),
      priceRange: StorePriceRange.values.firstWhere(
        (data) => data.name == map['priceRange'],
      ),
      ratings: map['ratings'] as double,
      ratingsCount: map['ratingsCount'] as int,
      deliveryTime: map['deliveryTime'] as int,
      deliveryFee: map['deliveryFee'] as int,
    );
  }
}
