import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:farmeasy/model/login/getLoginResponseModel.dart';
import 'package:farmeasy/network/api_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../base/services/preferences/preferences.dart';
import '../model/seeds/addSeedRequestJson/add_seed_request_json.dart';
import '../model/seeds/getSeedListRespnse/get_seed_list_response.dart';
import '../model/seeds/getSeedLotListResponse/get_seed_lot_response.dart';
import 'api_utils.dart';
import 'dioProvider.dart';


final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref);
});


class AuthRepository {
  final Ref ref;
  AuthRepository(this.ref);


  Future<bool> login(String email, String password) async {
    try {
      final apiProvider = ref.read(apiManagerProvider);
      final response = await apiProvider.callPost(
        apiUrl: ApiPath.loginUrl,
        body: {"email": email, "password": password},
        isAuthApi: true,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null) {

          final loginModel = GetLoginResponseModel.fromJson(response.data);

          final prefs = PreferenceService.instance;
          await prefs.setAccessToken(loginModel.data.accessToken);
          await prefs.setIsLogin(true);
          await prefs.setUserEmail(email);

          return true; // login success
        }
      }
      return false; // invalid creds or failed
    } on DioException catch (error) {
      if (error.response != null) {
        return false; // login success
      } else {
        return false; // login success
      }
      return false;
    } catch (e) {
      print("Eror$e");
      // debugPrint("Unexpected login error: $e");
      return false;
    }
  }


  // Fetch Seeds
  Future<List<GetSeedListResponse>> fetchSeeds(String? token) async {
    try {
      final apiProvider = ref.read(apiManagerProvider);

      final response = await apiProvider.callPost(
        apiUrl: ApiPath.getSeedsUrl,
        header:  {
         "Authorization": "Bearer $token",
        },
        isAuthApi: true,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData != null && responseData['data'] != null) {
          final List<dynamic> list = responseData['data'];
          return list
              .map((json) => GetSeedListResponse.fromJson(json))
              .toList();
        }
      }
      return []; // empty list if no data
    } on DioException catch (error) {
      debugPrint("fetchSeeds error: ${error.message}");
      return []; // return empty list instead of false
    }
  }

  // Fetch Seeds Lot
  Future<List<GetSeedLotData>> fetchSeedsLot(String? token) async {
    final apiProvider = ref.read(apiManagerProvider);
    try {
      final response = await apiProvider.callGet(path: ApiPath.getSeedLotUrl,
        header: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData != null && responseData['data'] != null) {
          final List<dynamic> list = responseData['data'];
          return list
              .map((json) => GetSeedLotData.fromJson(json))
              .toList();
        }
        else{
          return [];
        }
      }
      return []; // empty list if no data
    } on DioException catch (error) {
      debugPrint("fetchSeeds error: ${error.message}");
      return []; // return empty list instead of false
    }
  }

  // API for addSeeds
  Future<bool> addSeeds(AddSeedRequest request) async {
    final apiProvider = ref.read(apiManagerProvider);
    try {
      final response = await apiProvider.callPost(
        apiUrl: ApiPath.addSeedsUrl,
        body: jsonEncode(request.toJson()),
        isAuthApi: false,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } on DioException catch (error) {
      debugPrint("addSeeds error: ${error.message}");
      return false;
    }
  }

  void logout() {
    ref.read(authTokenProvider.notifier).state = null;
  }
}