import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/data/model/property_details_json.dart';
import 'package:dips/domain/entity/property_model.dart';
import 'package:dips/domain/entity/property_type_model.dart';
import 'package:dips/domain/property/home_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class HomeProvider extends ChangeNotifier {
  HomeRepository _homeRepository;

  HomeProvider(this._homeRepository);

  List<PropertyModel> propertyList = [];
  bool isLoading = false;

  List<PropertyTypeModel> propertyTypeModel = [];

  Future<void> getPropertyList() async {
    isLoading = true;
    notifyListeners();
    final reponse = await _homeRepository.getProperty();

    if (reponse.isNotEmpty) {
      propertyList = reponse;
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getPropertyListByValue(String value) async {
    isLoading = true;
    notifyListeners();

    final reponse = await _homeRepository.getPropertyByValue(value);

    if (reponse.isNotEmpty) {
      propertyList.clear();
      propertyList = reponse;
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getPropertyType() async {
    isLoading = true;
    notifyListeners();
    final reponse = await _homeRepository.getPropertyType();
    if (reponse.isNotEmpty) {
      propertyTypeModel = reponse;
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addFav(String id) async {
    final response = await _homeRepository.addPropertyFavourite(id);
    return response;
  }

  PropertyDetailsJson propertyDetailsJson = PropertyDetailsJson();

  Future<bool> getPropertyDetails(BuildContext context, String id) async {
    // isLoading = true;
    // notifyListeners();
    final reponse = await _homeRepository.getPropertyDetails(id);

    if (reponse != PropertyDetailsJson()) {
      propertyDetailsJson = reponse;
      // isLoading = false;
      notifyListeners();
      return true;
    } else {
      AppSnackbar.show(
        context,
        title: "Property Details",
        message: "Something wroing try again",
        type: SnackType.error,
      );
      return false;
    }
  }

  List<PropertyModel> similerPropertyList = [];
  Future<void> getSimilerProperty(String id) async {
    final response = await _homeRepository.getSimilerProperty(id);
    if (response.isNotEmpty) {
      similerPropertyList = response;
      notifyListeners();
    } else {
      similerPropertyList = [];
      notifyListeners();
    }
  }
}
