import 'package:flutter/material.dart';
import 'package:login/common/constant/colors.dart';
import 'package:login/common/constant/gaps.dart';
import 'package:login/common/constant/sizes.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.size8),
            child: Image.asset(
              'assets/images/food/pizza_ddeok_bok_gi.jpg',
              width: Sizes.size100,
              height: Sizes.size100,
              fit: BoxFit.cover,
            ),
          ),
          Gaps.h16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '치즈콤비네이션',
                  style: TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  '정통 이탈리안 피자와, K푸드의 결합! 지금 바로 만나보세요! 원하는 대로 토핑을 선택하고, 다채로운 향미를 즐겨보세요! 양도 만족! 맛은 더 만족! 가격은 사장님이 미쳤어요!',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: bodyTextColor,
                    fontSize: Sizes.size14,
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '15,300원',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: Sizes.size12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
