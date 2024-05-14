import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login/common/constant/data.dart';
import 'package:login/common/constant/gaps.dart';
import 'package:login/common/constant/sizes.dart';
import 'package:login/features/store/models/store_model.dart';
import 'package:login/features/store/views/detail_screen.dart';
import 'package:login/features/store/widgets/store_card.dart';

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

              var model = StoreModel.fromJson(item);

              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return StoreDetailScreen(rid: model.id);
                    },
                  ),
                ),
                child: StoreCard.fromModel(model: model),
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
