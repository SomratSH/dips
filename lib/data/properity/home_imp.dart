import 'dart:convert';

import 'package:dips/constant/app_urls.dart';
import 'package:dips/core/api_service/api_service.dart';
import 'package:dips/data/model/favourite_json.dart';
import 'package:dips/data/model/property_details_json.dart';
import 'package:dips/data/model/property_json.dart';
import 'package:dips/data/model/property_type_json.dart';
import 'package:dips/data/model/qr_property_model.dart';
import 'package:dips/domain/entity/property_model.dart';
import 'package:dips/domain/entity/property_type_model.dart';
import 'package:dips/domain/property/home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeImp implements HomeRepository {
  final ApiService _apiService = ApiService();

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
  Future<List<PropertyModel>> getProperty() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await _apiService.getData(
      AppUrls.getProperty,
      authToken: preferences.getString("authToken"),
    );

    if (response == null || response["results"] == null) {
      return [];
    }

    final List<dynamic> data = response["results"];

    return data.map((e) => Results.fromJson(e).toDomain()).toList();
  }

  @override
  Future<List<PropertyModel>> getPropertyByValue(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await _apiService.getData(
      "${AppUrls.getProperty}?property_type=$value",
      authToken: preferences.getString("authToken"),
    );

    if (response == null || response["results"] == null) {
      return [];
    }

    final List<dynamic> data = response["results"];

    return data.map((e) => Results.fromJson(e).toDomain()).toList();
  }

  @override
  Future<bool> addPropertyFavourite(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await _apiService.postData(
      "${AppUrls.addPropertyFav}$id/favourite/",
      {},
      authToken: preferences.getString("authToken"),
    );

    if (response["favourited"] == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<PropertyDetailsJson> getPropertyDetails(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await _apiService.getData(
      "${AppUrls.propertyDetails}$id/",

      authToken: preferences.getString("authToken"),
    );

    if (response.isNotEmpty) {
      return PropertyDetailsJson.fromJson(response);
    } else {
      return PropertyDetailsJson();
    }
  }

  @override
  Future<List<PropertyModel>> getSimilerProperty(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.getList(
      "${AppUrls.getSimilerProperty}$id/similar/",
      authToken: preferences.getString("authToken"),
    );
    final List<dynamic> data = response;
    return data.map((e) => Results.fromJson(e).toDomain()).toList();
  }

  @override
  Future<bool> makeOffer(Map<String, dynamic> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.postData(
      AppUrls.makeOffer,
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
  Future<bool> makeMeeting(Map<String, dynamic> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.postData(
      AppUrls.bookingMeeting,
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
  Future<bool> giveRating(int selectedRating, String agentId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final respnse = await _apiService.postData(
      authToken: preferences.getString("authToken"),
      "${AppUrls.giveRating}$agentId/rate/",
      {"rating": selectedRating, "comment": "Very helpful!"},
    );

    if (respnse["id"] != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<PropertyModel>> searchFilter(
    String? search,
    String? propertyType,
    String? minPrice,
    String? maxPrice,
    String? bed,
    String? amenities,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // 1. Create a Map of all possible parameters
    final Map<String, String> queryParameters = {
      if (search != null && search.isNotEmpty) 'text_search': search,
      if (propertyType != null && propertyType.isNotEmpty)
        'property_type': propertyType.toLowerCase(),
      if (minPrice != null && minPrice.isNotEmpty) 'min_price': minPrice,
      if (maxPrice != null && maxPrice.isNotEmpty) 'max_price': maxPrice,
      if (bed != null && bed.isNotEmpty) 'beds': bed,
      if (amenities != null && amenities.isNotEmpty) 'amenities': amenities,
    };

    // 2. Convert the Map into a query string (e.g., param1=value1&param2=value2)
    String queryString = Uri(queryParameters: queryParameters).query;

    // 3. Construct the full URL
    final String fullUrl = queryString.isNotEmpty
        ? "${AppUrls.searchFilter}?$queryString"
        : AppUrls.searchFilter;

    final response = await _apiService.getData(
      fullUrl,
      authToken: preferences.getString("authToken"),
    );

    if (response == null || response["results"] == null) {
      return [];
    }

    final List<dynamic> data = response["results"];
    return data.map((e) => Results.fromJson(e).toDomain()).toList();
  }

  @override
  Future<List<FavouriteJson>> getFavourite() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.getList(
      AppUrls.favourite,
      authToken: preferences.getString("authToken"),
    );
    final List<dynamic> data = response;
    return data.map((e) => FavouriteJson.fromJson(e)).toList();
  }

  @override
  Future<String> getQrCodeResponse(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.getDatav(
      id,
      authToken: preferences.getString("authToken"),
    );
    print(response);
    if (response["redirect_url"] != null && response["property_id"] != null) {
      return response["redirect_url"];
    } else {
      return "";
    }
  }

  @override
  Future<QrPropertyModel> getQrProperty(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.getDatav(
      id,
      authToken: preferences.getString("authToken"),
    );
    return QrPropertyModel.fromJson(response);
  }
}
