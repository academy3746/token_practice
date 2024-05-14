import 'package:flutter/material.dart';
import 'package:login/common/constant/colors.dart';
import 'package:login/common/constant/gaps.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/features/stores/models/store_model.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({
    super.key,
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    this.isDetail = false,
    this.detail,
  });

  /// 스토어 이미지
  final Widget image;

  /// 스토어 이름
  final String name;

  /// Hash Tags
  final List<String> tags;

  /// 리뷰 개수
  final int ratingsCount;

  /// 배송 시간
  final int deliveryTime;

  /// 배송비
  final int deliveryFee;

  /// 평점
  final double ratings;

  /// 페이지 상세 여부
  final bool isDetail;

  /// 상세 내용
  final String? detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 스토어 이미지
        if (isDetail) image,

        if (!isDetail)
          ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.size12),
            child: image,
          ),
        Gaps.v16,

        /// 스토어 정보
        _storeInfo(),
      ],
    );
  }

  /// 스토어 정보
  Widget _storeInfo() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isDetail ? Sizes.size20 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: Sizes.size20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gaps.v8,
          Text(
            tags.join(' · '),
            style: const TextStyle(
              color: bodyTextColor,
              fontSize: Sizes.size14,
            ),
          ),
          Gaps.v8,
          Row(
            children: [
              /// 평점
              _iconText(
                icon: Icons.star,
                label: ratings.toString(),
              ),
              _dotSeparator(),

              /// 리뷰 개수
              _iconText(
                icon: Icons.receipt,
                label: ratingsCount.toString(),
              ),
              _dotSeparator(),

              /// 배송 시간
              _iconText(
                icon: Icons.timelapse_outlined,
                label: '$deliveryTime 분',
              ),
              _dotSeparator(),

              /// 배송비
              _iconText(
                icon: Icons.monetization_on,
                label: deliveryFee == 0 ? '무료' : deliveryFee.toString(),
              ),
            ],
          ),

          /// 상세 내용
          if (detail != null && isDetail)
            Container(
              margin: const EdgeInsets.only(
                top: Sizes.size16,
              ),
              child: Text(detail!),
            ),
        ],
      ),
    );
  }

  /// 아이콘 및 정보
  Widget _iconText({
    required IconData icon,
    required String label,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: Sizes.size14,
        ),
        Gaps.h8,
        Text(
          label,
          style: const TextStyle(
            fontSize: Sizes.size12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// 구두점 구분
  Widget _dotSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.size4,
      ),
      child: Text(
        '·',
        style: TextStyle(
          fontSize: Sizes.size12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  factory StoreCard.fromModel({
    required StoreModel model,
    bool isDetail = false,
    String? detail,
  }) {
    return StoreCard(
      image: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: model.tags,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      ratings: model.ratings,
      isDetail: isDetail,
      detail: detail,
    );
  }
}
