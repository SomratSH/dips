import 'dart:io';

import 'package:dips/domain/entity/profile_model.dart';


abstract class ProfileRepository {
  Future<ProfileModel> getProfile();
  Future<bool> editProfile(
    Map<String, String> map,
    File? image,
    bool isChangePhoto,
  );

  Future<Map<String, dynamic>> passwordChange(Map<String, dynamic> map);
}
