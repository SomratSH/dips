import 'dart:io';

import 'package:dips/constant/app_urls.dart';
import 'package:dips/core/api_service/api_service.dart';
import 'package:dips/data/agent_model/agent_dashboard_model.dart';
import 'package:dips/data/agent_model/agent_profile_model.dart';
import 'package:dips/data/model/property_json.dart';
import 'package:dips/domain/agent_repository/agent_repository.dart';
import 'package:dips/domain/entity/property_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgentImp implements AgentRepository {
  final ApiService _apiService = ApiService();
  @override
  Future<AgentDashboardModel> getDashboardAgent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.getData(
      AppUrls.agentDashboard,
      authToken: preferences.getString("authToken"),
    );
    print(response);
    if (response.isNotEmpty) {
      print("object");
      return AgentDashboardModel.fromJson(response);
    } else {
      print("object not");
      return AgentDashboardModel();
    }
  }

  @override
  Future<List<PropertyModel>> getPropertyAgent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await _apiService.getData(
      AppUrls.getPropertyAgent,
      authToken: preferences.getString("authToken"),
    );

    if (response == null || response["results"] == null) {
      return [];
    }

    final List<dynamic> data = response["results"];

    return data.map((e) => Results.fromJson(e).toDomain()).toList();
  }

  @override
  Future<AgentProfileModel> getAgentProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await _apiService.getData(
      AppUrls.agentProfile,
      authToken: preferences.getString("authToken"),
    );

    if (response.isNotEmpty) {
      return AgentProfileModel.fromJson(response);
    } else {
      throw Exception("Profile data not found");
    }
  }

  @override
  Future<bool> updateAgentProfile(
    Map<String, dynamic> data,
    File ?logo,
    File ?image,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(data);
    final response = await _apiService.patchData(
      AppUrls.updateAgentProfile,
      data,
      image: image,
      imageParamNam: "profile_picture",
      logo: logo,
      logoParamName: "logo",
      authToken: preferences.getString("authToken"),
    );
    print(response);

    if (response["id"] != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> addProperty(Map<String, dynamic> data, File image, )async{
    final reponse = await _apiService.postDataRegular2(AppUrls.addProperty, data);

    if(reponse["id"] != null){
      return true;
    }else{
      return false;
    }
  }
}
