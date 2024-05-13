import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login/common/constant/data.dart';
import 'package:login/common/constant/gaps.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/features/stores/models/store_model.dart';
import 'package:login/features/stores/widgets/store_card.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  Future<List> _paginatedStore() async {
    final dio = Dio();

    final accessToken = await storage.read(key: accessTokenKey);

    final res = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    return res.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.size24,
        horizontal: Sizes.size20,
      ),
      child: FutureBuilder(
        future: _paginatedStore(),
        builder: (context, snapshot) {
          final listModel = snapshot.data ?? [];

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(fontSize: Sizes.size14),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              var item = listModel[index];

              var model = StoreModel(
                id: item['id'],
                name: item['name'],
                thumbUrl: 'http://$ip${item['thumbUrl']}',
                tags: List<String>.from(item['tags']),
                priceRange: StorePriceRange.values.firstWhere(
                  (data) => data.name == item['priceRange'],
                ),
                ratings: item['ratings'],
                ratingsCount: item['ratingsCount'],
                deliveryTime: item['deliveryTime'],
                deliveryFee: item['deliveryFee'],
              );

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
              );
            },
            separatorBuilder: (context, index) => Gaps.v16,
            itemCount: listModel.length,
          );
        },
      ),
    );
  }
}
