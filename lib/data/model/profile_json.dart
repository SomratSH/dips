

import 'package:dips/domain/entity/profile_model.dart';

class ProfileJson {
  String? id;
  String? email;
  String? fullName;
  String? phone;
  String? role;
  String? profilePicture;
  bool? is2faEnabled;
  String? memberSince;
  String? lastActive;
  String? lastActiveHuman;
  String? accountStatus;
  int? totalPropertiesCount;
  int? totalViewsCount;
  // Null? agentProfile;

  ProfileJson({
    this.id,
    this.email,
    this.fullName,
    this.phone,
    this.role,
    this.profilePicture,
    this.is2faEnabled,
    this.memberSince,
    this.lastActive,
    this.lastActiveHuman,
    this.accountStatus,
    this.totalPropertiesCount,
    this.totalViewsCount,
    // this.agentProfile,
  });

  ProfileJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullName = json['full_name'];
    phone = json['phone'];
    role = json['role'];
    profilePicture = json['profile_picture'];
    is2faEnabled = json['is_2fa_enabled'];
    memberSince = json['member_since'];
    lastActive = json['last_active'];
    lastActiveHuman = json['last_active_human'];
    accountStatus = json['account_status'];
    totalPropertiesCount = json['total_properties_count'];
    totalViewsCount = json['total_views_count'];
    // agentProfile = json['agent_profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['profile_picture'] = this.profilePicture;
    data['is_2fa_enabled'] = this.is2faEnabled;
    data['member_since'] = this.memberSince;
    data['last_active'] = this.lastActive;
    data['last_active_human'] = this.lastActiveHuman;
    data['account_status'] = this.accountStatus;
    data['total_properties_count'] = this.totalPropertiesCount;
    data['total_views_count'] = this.totalViewsCount;
    // data['agent_profile'] = this.agentProfile;
    return data;
  }

  ProfileModel toDomain() => ProfileModel(
    id: id,
    email: email!,
    name: fullName!,
    memberSince: memberSince!,
    profilePicture: profilePicture ?? "",
    role: role!,
    saveProperties: totalPropertiesCount!,
    totalPropertiesCount: totalViewsCount!,
    phone: phone,
  );
}
