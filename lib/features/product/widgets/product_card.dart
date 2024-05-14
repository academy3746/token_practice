import 'package:flutter/material.dart';
import 'package:login/common/constant/colors.dart';
import 'package:login/common/constant/gaps.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/features/product/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
  });

  final Widget image;

  final String name;

  final String detail;

  final int price;

  factory ProductCard.fromModel(StoreProductModel model) {
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        width: Sizes.size100,
        height: Sizes.size100,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.size8),
            child: image,
          ),
          Gaps.h16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: bodyTextColor,
                    fontSize: Sizes.size14,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '₩$price',
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: Sizes.size12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
