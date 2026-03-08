import 'dart:io';

import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/domain/entity/profile_model.dart';
import 'package:dips/domain/profile/profile_repository.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository _profileRepository;

  ProfileProvider(this._profileRepository);
  ProfileModel profileModel = ProfileModel();

  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();

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

  void clearImage() {
    _selectedImage = null;
    notifyListeners();
  }

  Future<void> getProfileData() async {
    isLoading = true;
    notifyListeners();
    final response = await _profileRepository.getProfile();
    profileModel = response;
    isLoading = false;
    notifyListeners();
  }

  Future<bool> updateProfile(
    Map<String, String> data,
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();

    final response = await _profileRepository.editProfile(
      data,
      selectedImage!,
      selectedImage != null ? true : false,
    );

    if (response) {
      AppSnackbar.show(
        context,
        title: "Update Profile",
        message: "Update Profile Successfully",
        type: SnackType.success,
      );
    }
    isLoading = false;
    return response;
  }

  Future<void> updatePassword(
    BuildContext context,
    Map<String, dynamic> data,
  ) async {
    final response = await _profileRepository.passwordChange(data);

    if (response["message"] == "Password updated successfully.") {
      AppSnackbar.show(
        context,
        title: "Change Password",
        message: response["message"],
        type: SnackType.success,
      );
    } else {
      AppSnackbar.show(
        context,
        title: "Change Password",
        message: response["message"],
      );
    }
  }
}
