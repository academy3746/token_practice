import 'package:login/common/constant/data.dart';

class StoreProductModel {
  final String id;

  final String name;

  final String detail;

  final String imgUrl;

  final int price;

  StoreProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'detail': detail,
      'imgUrl': imgUrl,
      'price': price,
    };
  }

  factory StoreProductModel.fromJson(Map<String, dynamic> map) {
    return StoreProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      detail: map['detail'] as String,
      imgUrl: 'http://$ip${map['imgUrl']}',
      price: map['price'] as int,
    );
  }
}
