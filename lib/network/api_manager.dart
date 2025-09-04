import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/services/preferences/preferences.dart';
import 'package:farmeasy/base/utils/global_context.dart';
import 'package:farmeasy/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'api_utils.dart';
import 'app_config.dart';

final _baseDioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: "https://farmeasy-m6p9.onrender.com",
      receiveTimeout: Duration(seconds: 90),
      connectTimeout: Duration(seconds: 60),
      validateStatus: (status) => (status ?? 500) < 500,
    ),
  );
});

final apiManagerProvider = Provider<ApiManager>((ref) {
  return ApiManager._(
    ref: ref,
    dio: ref.watch(_baseDioProvider),
    preferences: PreferenceService.instance,
  );
});

class ApiManager {
  ApiManager._({required this.ref, required Dio dio, required this.preferences})
      : _dio = dio;

  final Ref ref;
  final PreferenceService preferences;
  static bool isRefreshingToken = false;
  final Dio _dio;
  final List<CancelToken> _activeTokens = [];

  Future<Response> callPatch({
    required String apiUrl,
    dynamic body,
    Map<String, String>? header,
    Map<String, String>? params,
  }) async {
    try {
      final mergedHeaders = await _getMergedHeaders(header, false);
      _logRequest('PATCH', _dio.options.baseUrl + apiUrl, body, mergedHeaders);

      final response = await _dio.patch(
        apiUrl,
        data: body,
        options: Options(headers: mergedHeaders),
        queryParameters: params,
      );

      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 401) {
        await _handleSessionExpired(
          message: 'Your session has expired. Please log in again.',
        );
        return response;
      } else if (response.statusCode == 403) {
        await _handleSessionExpired(
          message: 'Your session has expired. Please log in again.',
        );
        return response;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> callPost({
    required String apiUrl,
    dynamic body,
    Map<String, String>? header,
    Map<String, String>? params,
    bool isAuthApi = false,
    bool? isTruDrive,
    CancelToken? cancelToken,
  }) async {
    final token = cancelToken ?? CancelToken();
    _activeTokens.add(token);
    try {
      final mergedHeaders = await _getMergedHeaders(header, isAuthApi);
      _logRequest('POST', _dio.options.baseUrl + apiUrl, body, mergedHeaders);

      final response = await _dio.post(
        apiUrl,
        data: body,
        options: Options(headers: mergedHeaders),
        queryParameters: params,
      );

      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 401) {
        await _handleSessionExpired(
          message: 'Your session has expired. Please log in again.',
        );
        return response;
      } else if (response.statusCode == 403) {
        PreferenceService preference = PreferenceService.instance;
        if (await preference.isLogin == "true") {
          await _handleSessionExpired(message: 'Unauthorized account');
          return response;
        } else {
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    } finally {
      _activeTokens.remove(token);
    }
  }

  Future<Response> callPut({
    required String apiUrl,
    dynamic body,
    Map<String, String>? header,
    Map<String, String>? params,
  }) async {
    try {
      final mergedHeaders = await _getMergedHeaders(header, false);
      _logRequest('PUT', apiUrl, body, mergedHeaders);

      final response = await _dio.put(
        apiUrl,
        data: body, // Dio handles null data automatically
        options: Options(headers: mergedHeaders),
        queryParameters: params,
      );

      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 403) {
        await _handleSessionExpired(message: 'Unauthorized account');
        return response;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> callGet({
    required String path,
    Map<String, String>? header,
    Map<String, dynamic>? params,
    bool? isTruDrive,
    CancelToken? cancelToken,
  }) async {
    final token = cancelToken ?? CancelToken();
    _activeTokens.add(token);

    try {
      final mergedHeaders = await _getMergedHeaders(header, false);
      _logRequest('GET', _dio.options.baseUrl + path, params, mergedHeaders);

      final response = await _dio.get(
        path,
        options: Options(headers: mergedHeaders),
        queryParameters: params,
        cancelToken: token,
      );

      _logResponse(response);
      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401 && !isRefreshingToken) {
        await _handleSessionExpired(message: 'Unauthorized account');
        return response;
      } else if (response.statusCode == 403) {
        await _handleSessionExpired(
          message: 'Your session has expired. Please log in again.',
        );
        return response;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        log("Request to $path cancelled: ${e.message}");
      }
      rethrow;
    } finally {
      _activeTokens.remove(token);
    }
  }

  Future<Response> callDelete({
    required String path,
    Map<String, String>? header,
    Map<String, dynamic>? params,
    bool? isTruDrive,
  }) async {
    try {
      final mergedHeaders = await _getMergedHeaders(header, false);
      _logRequest('DELETE', _dio.options.baseUrl + path, null, mergedHeaders);

      final response = await _dio.delete(
        path,
        options: Options(headers: mergedHeaders),
        queryParameters: params,
      );

      _logResponse(response);

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 403) {
        await _handleSessionExpired(
          message: 'Your session has expired. Please log in again.',
        );
        return response;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> callMultipart({
    required String apiUrl,
    Map<String, String>? header,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    required List<dynamic> files,
    String? attachmentKey,
    bool? isTruDrive,
  }) async {
    try {
      final mergedHeaders = await _getMergedHeaders(header, false);
      FormData formData = FormData();
      _logRequest(
        'MULTIPART',
        _dio.options.baseUrl + apiUrl,
        body,
        mergedHeaders,
      );

      // Add body fields to FormData
      if (body != null) {
        body.forEach((key, value) {
          formData.fields.add(MapEntry(key, value));
        });
      }

      // Add files to FormData
      for (var file in files) {
        formData.files.add(
          MapEntry(
            attachmentKey ?? "Attachments",
            await MultipartFile.fromFile(file.path),
          ),
        );
      }

      final response = await _dio.post(
        apiUrl,
        data: formData,
        queryParameters: params,
        options: Options(headers: mergedHeaders),
      );

      _logResponse(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 403) {
        await _handleSessionExpired(
          message: 'Your session has expired. Please log in again.',
        );
        return response;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  void cancelAllRequests({String reason = "Cancelled by logout"}) {
    for (final token in _activeTokens) {
      if (!token.isCancelled) {
        token.cancel(reason);
      }
    }
    _activeTokens.clear();
  }

  Future<void> _handleSessionExpired({required String message}) async {
    PreferenceService preferenceService = PreferenceService.instance;
    if (await preferenceService.isLogin == true) {
      await preferenceService.setIsLogin(false);
      if (NavigationService.currentContext.mounted) {
        cancelAllRequests();
        // Provider.of<ProfileProvider>(
        //   NavigationService.currentContext,
        //   listen: false,
        // )..handleLogoutUser();
        // clearLogoutDataGlobal(NavigationService.currentContext);
        await preferenceService.clearPreferences();
        await NavigationService.currentContext.navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (r) => false,
        );
      }
    }
  }

  Future<Map<String, String>> _getMergedHeaders(
      Map<String, String>? header,
      bool isAuthApi,
      ) async {
    var commonHeaders = {};
    if (isAuthApi) {
      commonHeaders = {ApiKeys.contentType: ApiUtils.applicationJson};
    } else {
      PreferenceService preference = PreferenceService.instance;
      if (await preference.isLogin == true) {
        String? token = await preference.accessToken;
        commonHeaders = {
          ApiKeys.contentType: ApiUtils.applicationJson,
          ApiKeys.authorization: 'Bearer $token',
        };
      }
    }
    return {...commonHeaders, ...header ?? {}};
  }

  void _logRequest(
      String method,
      String url,
      dynamic body,
      Map<String, dynamic> headers,
      ) {
    log("$method URL :: $url");
    log("body :: $body");
    log("header :: $headers");
    log(
      "ActiveTokens :: ${_activeTokens.map((e) => print('${e.isCancelled}${e.cancelError}'))}",
    );
  }

  static void _logResponse(Response response) {
    log("response.statusCode :: ${response.statusCode}");
    // if (response.statusCode != 200 && response.statusCode != 201) {
    log("response.data :: ${response.data}");
    // }
  }

/*
    // Create a separate dio instance for refresh token to avoid infinite loops
  static final Dio _dioRefresh = Dio(BaseOptions(
    baseUrl: 'https://${ApiPath.baseUrl}',
    validateStatus: (status) {
      return status! < 500;
    },
  ));

  static void initialize() {
    // Add interceptor to handle token refresh
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 401 && !isRefreshingToken) {
            // If the token is expired, try to refresh it
            final success = await _handleRefreshToken();
            if (success) {
              // Retry the failed request with new token
              return handler.resolve(await _retryRequest(error.requestOptions));
            } else {
              // If refresh fails, proceed with error
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  // Retry the failed request with new token
  static Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    PreferenceService preference = PreferenceService.instance;
    final newToken = await preference.accessToken;

    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        ApiKeys.authorization: "${ApiUtils.bearer}$newToken",
      },
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  // Handle refresh token
  static Future<bool> _handleRefreshToken() async {
    isRefreshingToken = true;
    try {
      PreferenceService preferenceService = PreferenceService.instance;
      final refreshToken = await preferenceService.refreshToken;

      final response = await _dioRefresh.post(
        "ApiPath.refreshTokenURL",
        data: {"refreshToken": refreshToken},
        options: Options(
          headers: {ApiKeys.contentType: ApiUtils.applicationJson},
        ),
      );

      if (response.statusCode == 200) {
        // Assuming your refresh token response has this structure
        // Modify according to your actual response structure
        final newAccessToken = response.data['data']['accessToken'];
        await preferenceService.setAccessToken(newAccessToken);
        isRefreshingToken = false;
        return true;
      } else {
        isRefreshingToken = false;
        await _handleSessionExpired(
          message: NavigationService.currentContext.l10n.yourSessionHasExpiredPleaseLogInAgain,
        );
        return false;
      }
    } catch (e) {
      isRefreshingToken = false;
      log('Refresh token error: $e');
      await _handleSessionExpired(
        message: NavigationService.currentContext.l10n.yourSessionHasExpiredPleaseLogInAgain,
      );
      return false;
    }
  }
  */
}
