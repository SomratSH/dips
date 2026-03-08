

import 'package:dips/constant/app_urls.dart';
import 'package:dips/core/api_service/api_service.dart';
import 'package:dips/domain/authentication/auth_repository.dart';

class AuthImp implements AuthRepository {
  final ApiService _apiService = ApiService();

  @override
  Future<Map<String, dynamic>> signUp(Map<String, dynamic> body) async {
    final response = await _apiService.postData(AppUrls.signUp, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> signUpAgent(Map<String, dynamic> body) async {
    final response = await _apiService.postData(AppUrls.signUpAgent, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> login(Map<String, String> map) async {
    final response = await _apiService.postDataRegular(AppUrls.login, map);
    return response;
  }

  @override
  Future<Map<String, dynamic>> loginAgent(Map<String, String> map) async {
    final response = await _apiService.postDataRegular(AppUrls.loginAgent, map);
    return response;
  }

  @override
  Future<Map<String, dynamic>> forgotPassword(Map<String, String> map) async {
    final response = await _apiService.postDataRegular(
      AppUrls.forgotPassword,
      map,
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> forgotPasswordAgent(
    Map<String, String> map,
  ) async {
    final response = await _apiService.postDataRegular(
      AppUrls.forgotPasswordAgent,
      map,
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> verifyOtp(Map<String, String> map) async {
    final response = await _apiService.postDataRegular(
      AppUrls.verfiyOtpUser,
      map,
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> verifyOtpAgent(Map<String, String> map) async {
    final response = await _apiService.postDataRegular(
      AppUrls.verfiyOtpAgent,
      map,
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> setNewPassword(Map<String, String> map) async {
    final response = await _apiService.postDataRegular(
      AppUrls.createPassword,
      map,
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> setNewPasswordAgent(
    Map<String, String> map,
  ) async {
    final response = await _apiService.postDataRegular(
      AppUrls.createPaswordAgent,
      map,
    );
    return response;
  }
}
