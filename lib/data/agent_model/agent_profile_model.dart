class AgentProfileModel {
  String? id;
  String? email;
  String? fullName;
  String? phone;
  String? role;
  String? profilePicture;
  bool? is2faEnabled;
  String? memberSince;
  Null? lastActive;
  String? lastActiveHuman;
  String? accountStatus;
  int? totalPropertiesCount;
  int? totalViewsCount;
  AgentProfile? agentProfile;

  AgentProfileModel(
      {this.id,
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
      this.agentProfile});

  AgentProfileModel.fromJson(Map<String, dynamic> json) {
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
    agentProfile = json['agent_profile'] != null
        ? new AgentProfile.fromJson(json['agent_profile'])
        : null;
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
    if (this.agentProfile != null) {
      data['agent_profile'] = this.agentProfile!.toJson();
    }
    return data;
  }
}

class AgentProfile {
  String? brandName;
  String? logo;
  String? brandColor;
  String? website;
  String? agentPhoto;
  bool? isVerified;
  String? rating;
  int? ratingCount;

  AgentProfile(
      {this.brandName,
      this.logo,
      this.brandColor,
      this.website,
      this.agentPhoto,
      this.isVerified,
      this.rating,
      this.ratingCount});

  AgentProfile.fromJson(Map<String, dynamic> json) {
    brandName = json['brand_name'];
    logo = json['logo'];
    brandColor = json['brand_color'];
    website = json['website'];
    agentPhoto = json['agent_photo'];
    isVerified = json['is_verified'];
    rating = json['rating'];
    ratingCount = json['rating_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_name'] = this.brandName;
    data['logo'] = this.logo;
    data['brand_color'] = this.brandColor;
    data['website'] = this.website;
    data['agent_photo'] = this.agentPhoto;
    data['is_verified'] = this.isVerified;
    data['rating'] = this.rating;
    data['rating_count'] = this.ratingCount;
    return data;
  }
}
