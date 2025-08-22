import 'package:dio/dio.dart';
import 'package:farmeasy/network/api_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base/services/preferences/preferences.dart';
import '../base/utils/global_context.dart';
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
      final response = await ApiManager.callPost(
        apiUrl: ApiPath.loginUrl,
        body: {"email": email, "password": password},
        isAuthApi: true,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null) {

          final prefs = PreferenceService.instance;
          await prefs.setAccessToken(response.data["access_token"]);
          await prefs.setIsLogin(true);
          await prefs.setUserEmail(email);

          return true; // login success
        }
      }
      return false; // invalid creds or failed
    } on DioException catch (error) {
      if (error.response != null) {
        return false; // login success
        // final responseModel =
        // CommonResponseModel.fromJson(error.response!.data);
        // debugPrint("Login failed: ${responseModel.message}");
      } else {
        return false; // login success
      //  debugPrint("Login error: ${error.message}");
      }
      return false;
    } catch (e) {
      print("Eror$e");
     // debugPrint("Unexpected login error: $e");
      return false;
    }
  }

    void logout() {
    ref.read(authTokenProvider.notifier).state = null;
  }
}