import 'dart:io';

import 'package:dips/constant/app_urls.dart';
import 'package:dips/core/api_service/api_service.dart';
import 'package:dips/data/agent_model/agent_dashboard_model.dart';
import 'package:dips/data/agent_model/agent_profile_model.dart';
import 'package:dips/data/agent_model/notification_model.dart';
import 'package:dips/data/model/property_json.dart';
import 'package:dips/domain/agent_repository/agent_repository.dart';
import 'package:dips/domain/entity/property_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../agent_model/offfer_model.dart' as offer;

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
    File? logo,
    File? image,
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
  Future<bool> addProperty(Map<String, dynamic> data, File image) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final reponse = await _apiService.postDataRegular2(
      AppUrls.addProperty,
      data,
      authToken: preferences.getString("authToken"),
    );

    if (reponse["id"] != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<dynamic>> getPropertyType() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final reponse = await _apiService.getList(
      AppUrls.getPropertyTypeAgent,
      authToken: preferences.getString("authToken"),
    );
    return reponse;
  }

  @override
  Future<List<PropertyModel>> getPropertySearch(String type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await _apiService.getData(
      "${AppUrls.agentPropertySearch}?property_type=$type",
      authToken: preferences.getString("authToken"),
    );

    if (response == null || response["results"] == null) {
      return [];
    }

    final List<dynamic> data = response["results"];

    return data.map((e) => Results.fromJson(e).toDomain()).toList();
  }

  @override
  Future<offer.OfferModel> getOffer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.getData(
      AppUrls.getOffer,
      authToken: preferences.getString("authToken"),
    );
    return offer.OfferModel.fromJson(response);
  }

  @override
  Future<bool> offerAccept(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.postDataWithoutBody(
      "${AppUrls.offerAccept}$id/accept/",
      authToken: preferences.getString("authToken"),
    );

    if (response["message"] == "Offer accepted.") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> offerRejected(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.postDataWithoutBody(
      "${AppUrls.offerAccept}$id/reject/",
      authToken: preferences.getString("authToken"),
    );

    if (response["message"] == "Offer rejected.") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> markLead(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.postDataWithoutBody(
      "${AppUrls.markLead}$id/lead/",
      authToken: preferences.getString("authToken"),
    );

    if (response["message"] == "Added to leads.") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> counterOffer(String id, Map<String, dynamic> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.postData(
      "${AppUrls.counterOffer}$id/counter/",
      data,
      authToken: preferences.getString("authToken"),
    );
    if (response["id"] != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<NotificaitonModel>> getNotification() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final repsonse = await _apiService.getList(
      AppUrls.getnotificaiton,
      authToken: preferences.getString("authToken"),
    );

    return repsonse.map((e) => NotificaitonModel.fromJson(e)).toList();
  }

  @override
  Future<bool> markAsRead(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await _apiService.postApiWithoutBody(
      "${AppUrls.markAsRead}$id/read/",
      preferences.getString("authToken").toString(),
    );

    if (response["message"] == "Marked as read.") {
      return true;
    } else {
      return false;
    }
  }

    @override
  Future<List<PropertyModel>> getMyPropertyAgent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await _apiService.getData(
      AppUrls.getMyPropertyAgent,
      authToken: preferences.getString("authToken"),
    );

    if (response == null || response["results"] == null) {
      return [];
    }

    final List<dynamic> data = response["results"];

    return data.map((e) => Results.fromJson(e).toDomain()).toList();
  }

  @override
  Future<String> createBoard()async{
     SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.postDataWithoutBody(AppUrls.createBoard, authToken: preferences.getString("authToken"));

    if(response["id"] != null){
      return response["id"];
    }else{
      return "";
    }
  }
@override
Future<String> assignBoard(String id, String propertyId )async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final response = await _apiService.patchData("${AppUrls.assignBoard}$id/reassign/", {
  "property_id": propertyId
  },
  
  authToken: preferences.getString("authToken")
  );
  if(response["id"] != null && response["qr_code_image"] != null){
    final data = response["qr_code_image"];
    return data;
  }else{
    return "";
  }
}

}
