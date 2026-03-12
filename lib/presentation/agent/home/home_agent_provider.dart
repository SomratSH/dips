import 'dart:io';

import 'package:dips/data/agent_model/agent_dashboard_model.dart';
import 'package:dips/data/agent_model/agent_profile_model.dart';
import 'package:dips/data/agent_model/notification_model.dart';
import 'package:dips/data/agent_model/offfer_model.dart';
import 'package:dips/domain/agent_repository/agent_repository.dart';
import 'package:dips/domain/entity/property_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeAgentProvider extends ChangeNotifier {
  AgentRepository _agentRepository;
  HomeAgentProvider(this._agentRepository);

  AgentDashboardModel agentDashboardModel = AgentDashboardModel();

  bool isLoading = false;

  Future<void> getDashboard() async {
    isLoading = true;
    notifyListeners();
    final response = await _agentRepository.getDashboardAgent();
    agentDashboardModel = response;

    isLoading = false;
    notifyListeners();
  }

  List<PropertyModel> propertyList = [];
  Future<void> getPropertyList() async {
    isLoading = true;
    notifyListeners();
    final reponse = await _agentRepository.getPropertyAgent();
    if (reponse.isNotEmpty) {
      propertyList = reponse;
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
    }
  }

  AgentProfileModel agentProfileModel = AgentProfileModel();

  Future<void> getAgentProfile() async {
    isLoading = true;
    notifyListeners();
    final response = await _agentRepository.getAgentProfile();
    agentProfileModel = response;
    isLoading = false;
    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;
  File? get selectedImage => _selectedImage;
  File? _selectedLogo;
  File? get selectedLogo => _selectedLogo;
  Future<void> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _selectedImage = File(image.path);
      notifyListeners();
    }
  }

  Future<void> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      _selectedImage = File(image.path);
      notifyListeners();
    }
  }

  Future<void> pickFromGalleryv() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _selectedLogo = File(image.path);
      notifyListeners();
    }
  }

  Future<void> pickFromCamerav() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      _selectedLogo = File(image.path);
      notifyListeners();
    }
  }

  void clearImage() {
    _selectedImage = null;
    notifyListeners();
  }

  void clearLogo() {
    _selectedLogo = null;
    notifyListeners();
  }

  Future<bool> updateAgentProfile(Map<String, dynamic> data) async {
    final response = await _agentRepository.updateAgentProfile(
      data,
      _selectedLogo,
      _selectedImage,
    );

    return response;
  }

  List<dynamic> propertyType = [];

  Future<void> getPropertyType()async{
    final  response = await _agentRepository.getPropertyType();
    propertyType = response;
    notifyListeners(); 
  }



  Future<void> getPropertySearch(String type)async{
    isLoading = true;
    notifyListeners();
    final response = await _agentRepository.getPropertySearch(type);
    propertyList = response;
    isLoading = false;
    notifyListeners();
  }


  int _selectedTypeIndex = 0; // Default to first item


  int get selectedTypeIndex => _selectedTypeIndex;

  void setSelectedType(int index) {
    _selectedTypeIndex = index;
    notifyListeners(); // This triggers the UI to rebuild
    // You can also trigger your API filter here
    // fetchProperties(type: propertyType[index]); 
  }


  OfferModel offerModel = OfferModel();


  Future<void> fetchOfferData()async{
    isLoading = true ;
    notifyListeners();
    final response = await _agentRepository.getOffer();
    offerModel = response;
    isLoading = false;
    notifyListeners();
  }

  Future<bool> offerAccpet(String id, index)async{
    final response = await _agentRepository.offerAccept(id);
    if(response){
      offerModel.results![index].status = "accepted";
      notifyListeners();
    }
    return response;
  }

   Future<bool> offerRejected(String id, index)async{
    final response = await _agentRepository.offerAccept(id);
    if(response){
      offerModel.results![index].status = "rejected";
      notifyListeners();
    }
    return response;
  }
    Future<bool> markAsLead(String id, index)async{
    final response = await _agentRepository.offerAccept(id);
    if(response){
      offerModel.results![index].isLead =true;
      notifyListeners();
    }
    return response;
  }
  Results selectedOffer = Results();
  void selectedOfferV(int index) {
    selectedOffer =  offerModel.results![index];
    notifyListeners();
  }


  Future<bool> makeCounterOffer(String id, Map<String, dynamic> data )async{
      final response  = await _agentRepository.counterOffer(id, data);
      return response;
  }


  List<NotificaitonModel> notificationList = [];
  Future<void>getNotification()async {
    isLoading =true;
    notifyListeners();
    final response = await _agentRepository.getNotification();
    notificationList = response;
    isLoading = false;
    notifyListeners();
  }

  Future<bool> markAsRead(String id, index)async{

    final response = await _agentRepository.markAsRead(id);
    if(response){
      notificationList[index].isRead = true;
      notifyListeners();
    }
    return response;
  }

  List<Results> leadList = [];

   Future<void> fetchLeadsData()async{
    isLoading = true ;
    notifyListeners();
    final response = await _agentRepository.getOffer();
    response.results!.forEach((e) => e.isLead == true ? leadList.add(e) : null);
    isLoading = false;
    notifyListeners();
  }
}
