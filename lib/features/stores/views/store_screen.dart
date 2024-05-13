import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login/common/constant/data.dart';
import 'package:login/common/constant/gaps.dart';
import 'package:login/common/constant/sizes.dart';
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
          final model = snapshot.data ?? [];

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
              var item = model[index];

              return StoreCard(
                image: Image.network(
                  'http://$ip${item['thumbUrl']}',
                  fit: BoxFit.cover,
                ),
                name: item['name'],
                tags: List<String>.from(item['tags']),
                ratingsCount: item['ratingsCount'],
                deliveryTime: item['deliveryTime'],
                deliveryFee: item['deliveryFee'],
                ratings: item['ratings'],
              );
            },
            separatorBuilder: (context, index) => Gaps.v16,
            itemCount: model.length,
          );
        },
      ),
    );
  }
}
