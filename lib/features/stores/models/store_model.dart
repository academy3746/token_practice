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

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id'] as String,
      name: map['name'] as String,
      thumbUrl: map['thumbUrl'] as String,
      tags: map['tags'] as List<String>,
      priceRange: map['priceRange'] as StorePriceRange,
      ratings: map['ratings'] as double,
      ratingsCount: map['ratingsCount'] as int,
      deliveryTime: map['deliveryTime'] as int,
      deliveryFee: map['deliveryFee'] as int,
    );
  }

  StoreModel copyWith({
    String? id,
    String? name,
    String? thumbUrl,
    List<String>? tags,
    StorePriceRange? priceRange,
    double? ratings,
    int? ratingsCount,
    int? deliveryTime,
    int? deliveryFee,
  }) {
    return StoreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbUrl: thumbUrl ?? this.thumbUrl,
      tags: tags ?? this.tags,
      priceRange: priceRange ?? this.priceRange,
      ratings: ratings ?? this.ratings,
      ratingsCount: ratingsCount ?? this.ratingsCount,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
    );
  }
}
