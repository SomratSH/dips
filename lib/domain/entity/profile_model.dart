class ProfileModel {
  String? id;
  String? name;
  String? email;
  String? memberSince;
  String? profilePicture;
  String? role;
  String ?phone;
  int? saveProperties;
  int? totalPropertiesCount;
  ProfileModel({
    this.id,
    this.email,
    this.name,
    this.memberSince,
    this.profilePicture,
    this.role,
    this.saveProperties,
    this.totalPropertiesCount,
    this.phone,
  });
}
