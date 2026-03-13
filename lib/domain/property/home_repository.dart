import 'package:dips/data/model/favourite_json.dart';
import 'package:dips/data/model/property_details_json.dart';
import 'package:dips/data/model/qr_property_model.dart';
import 'package:dips/domain/entity/property_model.dart';
import 'package:dips/domain/entity/property_type_model.dart';

abstract class HomeRepository {
  Future<List<dynamic>> getPropertyType();
  Future<List<PropertyModel>> getProperty();
  Future<List<PropertyModel>> getPropertyByValue(String value);
  Future<bool> addPropertyFavourite(String id);
  Future<PropertyDetailsJson> getPropertyDetails(String id);
  Future<List<PropertyModel>> getSimilerProperty(String id);
  Future<bool> makeOffer(Map<String, dynamic> data);
  Future<bool> makeMeeting(Map<String, dynamic> data);
  Future<bool> giveRating(int selectedRating, String agentId);
  Future<List<PropertyModel>> searchFilter(
    String serach,
    String propertyType,
    String minPrice,
    String maxPrice,
    String bed,
    String amenities,
  );

  Future<List<FavouriteJson>> getFavourite();

  Future<String> getQrCodeResponse(String id);

  Future<QrPropertyModel> getQrProperty(String id);
}
