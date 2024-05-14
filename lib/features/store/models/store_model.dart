import 'package:login/common/constant/data.dart';

enum StorePriceRange {
  expensive,
  medium,
  cheap,
}

class StoreModel {
  final String id;

  final String name;

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'thumbUrl': thumbUrl,
      'tags': tags,
      'priceRange': priceRange,
      'ratings': ratings,
      'ratingsCount': ratingsCount,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
    };
  }

  factory StoreModel.fromJson(Map<String, dynamic> map) {
    return StoreModel(
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
