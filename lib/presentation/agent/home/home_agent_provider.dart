import 'dart:io';

import 'package:dips/data/agent_model/agent_dashboard_model.dart';
import 'package:dips/data/agent_model/agent_profile_model.dart';
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
}
