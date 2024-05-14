import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login/common/constant/data.dart';

class CarrierHasArrived extends Interceptor {
  final FlutterSecureStorage storage;

  CarrierHasArrived({required this.storage});

  /// 1) REQUEST
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers['accessToken'] == 'true') {
      /// Implicit Headers 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: accessTokenKey);

      /// 유효한 토큰 값으로 대체
      options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      /// Implicit Headers 삭제
      options.headers.remove('refreshToken');

      final token = await storage.read(key: refreshTokenKey);

      /// 유효한 토큰 값으로 대체
      options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  /// 2) RESPONSE
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  /// 3) ERROR
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    /// [401] accessToken Expiration
    /// 1. 토큰 재발급 요청 [auth → token]
    /// 2. 새로운 토큰 재요청 [refreshToken → accessToken]
    final refreshToken = await storage.read(key: refreshTokenKey);

    if (refreshToken == null) {
      /// 1. refreshToken Expiration
      /// 2. onGenerate Error
      /// 3. Exit Process
      return handler.reject(err);
    }

    /// [Bool] 토큰 만료 Status Code
    final isStatus401 = err.response?.statusCode == 401;

    /// [Bool] 올바른 경로로 토큰이 요청 되었는지 여부 체크
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        /// Request (Refresh) New Token
        final res = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {
              'Authorization': 'Bearer $refreshToken',
            },
          ),
        );

        /// Actual Token Value
        final accessToken = res.data['accessToken'];

        final options = err.requestOptions;

        /// Receive New accessToken
        options.headers.addAll({
          'Authorization': 'Bearer $accessToken',
        });

        /// Overwrite accessToken Value
        await storage.write(
          key: accessTokenKey,
          value: accessToken,
        );

        /// New Request
        final response = await dio.fetch(options);

        /// [200] Exit Process without Error
        return handler.resolve(response);
      } on DioException catch (e) {
        /// 1. Could not refresh token
        /// 2. Throw Dio Error
        return handler.reject(e);
      }
    }

    return handler.reject(err);
  }
}
