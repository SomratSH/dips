import 'package:dips/data/model/property_details_json.dart';
import 'package:dips/domain/entity/property_model.dart';
import 'package:dips/domain/entity/property_type_model.dart';

abstract class HomeRepository {
  Future<List<PropertyTypeModel>> getPropertyType();
  Future<List<PropertyModel>> getProperty();
  Future<List<PropertyModel>> getPropertyByValue(String value);
  Future<bool> addPropertyFavourite(String id);
  Future<PropertyDetailsJson> getPropertyDetails(String id);
  Future<List<PropertyModel>> getSimilerProperty(String id);
}
