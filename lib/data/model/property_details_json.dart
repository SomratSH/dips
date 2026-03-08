class PropertyDetailsJson {
  String? id;
  List<String>? images;
  Null? video;
  Agent? agent;
  String? agentId;
  bool? isNew;
  bool? isFavourited;
  String? title;
  String? description;
  String? propertyType;
  String? price;
  String? address;
  String? postcode;
  Null? lat;
  Null? lon;
  String? status;
  bool? isFeatured;
  bool? isApproved;
  int? beds;
  int? baths;
  int? sizeSqft;
  int? parkingSlots;
  bool? hasPool;
  bool? hasGarage;
  bool? hasGarden;
  bool? hasFireplace;
  bool? isSmartHome;
  bool? hasGym;
  bool? isPetFriendly;
  int? viewsCount;
  int? qrScannedCount;
  String? createdAt;
  String? updatedAt;

  PropertyDetailsJson(
      {this.id,
      this.images,
      this.video,
      this.agent,
      this.agentId,
      this.isNew,
      this.isFavourited,
      this.title,
      this.description,
      this.propertyType,
      this.price,
      this.address,
      this.postcode,
      this.lat,
      this.lon,
      this.status,
      this.isFeatured,
      this.isApproved,
      this.beds,
      this.baths,
      this.sizeSqft,
      this.parkingSlots,
      this.hasPool,
      this.hasGarage,
      this.hasGarden,
      this.hasFireplace,
      this.isSmartHome,
      this.hasGym,
      this.isPetFriendly,
      this.viewsCount,
      this.qrScannedCount,
      this.createdAt,
      this.updatedAt});

  PropertyDetailsJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['images'] != null) {
      images = <String>[];
      json['images'].forEach((v) {
        images!.add(v);
      });
    }
    video = json['video'];
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    agentId = json['agent_id'];
    isNew = json['is_new'];
    isFavourited = json['is_favourited'];
    title = json['title'];
    description = json['description'];
    propertyType = json['property_type'];
    price = json['price'];
    address = json['address'];
    postcode = json['postcode'];
    lat = json['lat'];
    lon = json['lon'];
    status = json['status'];
    isFeatured = json['is_featured'];
    isApproved = json['is_approved'];
    beds = json['beds'];
    baths = json['baths'];
    sizeSqft = json['size_sqft'];
    parkingSlots = json['parking_slots'];
    hasPool = json['has_pool'];
    hasGarage = json['has_garage'];
    hasGarden = json['has_garden'];
    hasFireplace = json['has_fireplace'];
    isSmartHome = json['is_smart_home'];
    hasGym = json['has_gym'];
    isPetFriendly = json['is_pet_friendly'];
    viewsCount = json['views_count'];
    qrScannedCount = json['qr_scanned_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v).toList();
    }
    data['video'] = this.video;
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    data['agent_id'] = this.agentId;
    data['is_new'] = this.isNew;
    data['is_favourited'] = this.isFavourited;
    data['title'] = this.title;
    data['description'] = this.description;
    data['property_type'] = this.propertyType;
    data['price'] = this.price;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['status'] = this.status;
    data['is_featured'] = this.isFeatured;
    data['is_approved'] = this.isApproved;
    data['beds'] = this.beds;
    data['baths'] = this.baths;
    data['size_sqft'] = this.sizeSqft;
    data['parking_slots'] = this.parkingSlots;
    data['has_pool'] = this.hasPool;
    data['has_garage'] = this.hasGarage;
    data['has_garden'] = this.hasGarden;
    data['has_fireplace'] = this.hasFireplace;
    data['is_smart_home'] = this.isSmartHome;
    data['has_gym'] = this.hasGym;
    data['is_pet_friendly'] = this.isPetFriendly;
    data['views_count'] = this.viewsCount;
    data['qr_scanned_count'] = this.qrScannedCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Agent {
  String? id;
  String? fullName;
  String? email;
  String? phone;
  AgentProfile? agentProfile;

  Agent({this.id, this.fullName, this.email, this.phone, this.agentProfile});

  Agent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    agentProfile = json['agent_profile'] != null
        ? new AgentProfile.fromJson(json['agent_profile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    if (this.agentProfile != null) {
      data['agent_profile'] = this.agentProfile!.toJson();
    }
    return data;
  }
}

class AgentProfile {
  String? brandName;
  Null? logo;
  String? brandColor;
  String? website;
  Null? agentPhoto;
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
