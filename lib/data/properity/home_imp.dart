import 'dart:convert';

import 'package:dips/constant/app_urls.dart';
import 'package:dips/core/api_service/api_service.dart';
import 'package:dips/data/model/property_details_json.dart';
import 'package:dips/data/model/property_json.dart';
import 'package:dips/data/model/property_type_json.dart';
import 'package:dips/domain/entity/property_model.dart';
import 'package:dips/domain/entity/property_type_model.dart';
import 'package:dips/domain/property/home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeImp implements HomeRepository {
  final ApiService _apiService = ApiService();

  @override
  Future<List<PropertyTypeModel>> getPropertyType() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await _apiService.getList(
      AppUrls.getPropertyType,
      authToken: preferences.getString("authToken"),
    );

    List<dynamic> data = response;

    return data
        .map(
          (e) =>
              PropertyTypeJson.fromJson(e as Map<String, dynamic>).toDomain(),
        )
        .toList();
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
}
