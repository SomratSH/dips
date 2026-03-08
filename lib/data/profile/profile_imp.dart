import 'dart:convert';
import 'dart:io';
import 'package:dips/constant/app_urls.dart';
import 'package:dips/core/api_service/api_service.dart';
import 'package:dips/data/model/profile_json.dart';
import 'package:dips/domain/entity/profile_model.dart';
import 'package:dips/domain/profile/profile_repository.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImp implements ProfileRepository {
  final ApiService _apiService = ApiService();
  @override
  Future<ProfileModel> getProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await _apiService.getData(
      AppUrls.profile,
      authToken: preferences.getString("authToken"),
    );

    if (response.isNotEmpty) {
      return ProfileJson.fromJson(response).toDomain();
    } else {
      throw Exception("Profile data not found");
    }
  }

  @override
  Future<bool> editProfile(
    Map<String, String> map,
    File? image,
    bool isChangePhoto,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = isChangePhoto
        ? await _apiService.patchData(
            AppUrls.editProfile,
            map,
            image: image,
            imageParamNam: "profile_picture",
            authToken: preferences.getString("authToken"),
          )
        : await _apiService.postDataRegular(
            AppUrls.editProfile,
            map,
            authToken: preferences.getString("auhtToken"),
          );

    if (response["id"] != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> passwordChange(Map<String, dynamic> map) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.postData(
      AppUrls.chnagePassword,
      map,
      authToken: preferences.getString("authToken"),
    );
    return response;
  }
}
