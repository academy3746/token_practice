import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/common/dio/dio.dart';
import 'package:login/common/dio/repositories/secure_repo.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CommonInterceptor(storage: storage),
  );

  return dio;
});