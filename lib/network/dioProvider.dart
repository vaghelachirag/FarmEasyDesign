import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_config.dart';
import 'authRepositoryProvider.dart';


final authTokenProvider = StateProvider<String?>((ref) => null);


final dioProvider = Provider<Dio>((ref) {
 /* final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.instance.baseUrl,
      connectTimeout: const Duration(seconds: 4000),
      receiveTimeout: const Duration(seconds: 4000),
    ),
  );*/

  final dio = Dio(
    BaseOptions(
      baseUrl: "https://farmeasy-m6p9.onrender.com",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      // 👇 This allows Dio to return responses with status codes <500
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );


  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = ref.read(authTokenProvider);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
         // Handle token expiry: logout or refresh flow
          ref.read(authRepositoryProvider).logout();
        }
        return handler.next(e);
      },
    ),
  );


  return dio;
});


