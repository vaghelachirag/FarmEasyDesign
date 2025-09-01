import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../base/services/preferences/preferences.dart';
import '../base/utils/constants.dart';
import '../base/utils/global_context.dart';
import 'api_utils.dart';
import 'app_config.dart';

class ApiManager {
  static bool isRefreshingToken = false;
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.instance.baseUrl,
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );
  static final Dio _dioTruDrive = Dio(
    BaseOptions(
      baseUrl: AppConfig.instance.truDriveBaseUrl,
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );
  static final List<CancelToken> _activeTokens = [];

  static Future<Response> callPatch({
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

  static Future<Response> callPost({
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
      _logRequest(
        'POST',
        (isTruDrive == true
                ? _dioTruDrive.options.baseUrl
                : _dio.options.baseUrl) +
            apiUrl,
        body,
        mergedHeaders,
      );

      final response = await (isTruDrive == true ? _dioTruDrive : _dio).post(
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

  static Future<Response> callPut({
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

  static Future<Response> callGet({
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
      _logRequest(
        'GET',
        (isTruDrive == true
                ? _dioTruDrive.options.baseUrl
                : _dio.options.baseUrl) +
            path,
        params,
        mergedHeaders,
      );

      final response = await (isTruDrive == true ? _dioTruDrive : _dio).get(
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

  static Future<Response> callDelete({
    required String path,
    Map<String, String>? header,
    Map<String, dynamic>? params,
    bool? isTruDrive,
  }) async {
    try {
      final mergedHeaders = await _getMergedHeaders(header, false);
      _logRequest(
        'DELETE',
        (isTruDrive == true
                ? _dioTruDrive.options.baseUrl
                : _dio.options.baseUrl) +
            path,
        null,
        mergedHeaders,
      );

      final response = await (isTruDrive == true ? _dioTruDrive : _dio).delete(
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

  static Future<Response> callMultipart({
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
        (isTruDrive == true
                ? _dioTruDrive.options.baseUrl
                : _dio.options.baseUrl) +
            apiUrl,
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

      final response = await (isTruDrive == true ? _dioTruDrive : _dio).post(
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

  static void cancelAllRequests({String reason = "Cancelled by logout"}) {
    for (final token in _activeTokens) {
      if (!token.isCancelled) {
        token.cancel(reason);
      }
    }
    _activeTokens.clear();
  }

  static Future<void> _handleSessionExpired({required String message}) async {
    try {
      final preferenceService = PreferenceService.instance;
      // Mark as logged out and clear stored credentials
      await preferenceService.setIsLogin(false);
      await preferenceService.clearPreferences();

      // Cancel any inflight network requests
      ApiManager.cancelAllRequests();

      // Notify user if possible
      try {
        final context = NavigationService.currentContext;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } catch (_) {}

      // Navigate to login, clearing back stack
      try {
        final nav = NavigationService.currentState;
        nav.pushNamedAndRemoveUntil(loginScreen, (route) => false);
      } catch (_) {}
    } catch (e) {
      log('Session expired handling error: $e');
    }
  }

  static Future<Map<String, String>> _getMergedHeaders(
    Map<String, String>? header,
    bool isAuthApi,
  ) async {
    var commonHeaders = {};
    if (isAuthApi) {
      commonHeaders = {ApiKeys.contentType: ApiUtils.applicationJson};
    } else {
      PreferenceService preference = PreferenceService.instance;
      if (await preference.isLogin == "true") {
        String? token = await preference.accessToken;
        String? appVersion = await preference.appVersion;
        commonHeaders = {
          ApiKeys.contentType: ApiUtils.applicationJson,
          ApiKeys.authorization: 'Bearer $token',
          ApiKeys.appVersion: appVersion,
        };
      }
    }
    return {...commonHeaders, ...header ?? {}};
  }

  static void _logRequest(
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

}
