import 'package:dips/domain/entity/property_model.dart';
import 'package:dips/domain/entity/property_type_model.dart';

class PropertiesJson {
  int? count;
  List<Results>? results;

  PropertiesJson({this.count, this.results});

  PropertiesJson.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? id;
  String? title;
  String? propertyType;
  String? price;
  String? address;
  String? postcode;
  String? status;
  bool? isFeatured;
  bool? isNew;
  int? beds;
  int? baths;
  int? sizeSqft;
  double? lat;
  double? lon;
  String? coverImage;
  int? viewsCount;
  bool? isFavourited;
  String? createdAt;
  String? agentId;

  Results({
    this.id,
    this.title,
    this.propertyType,
    this.price,
    this.address,
    this.postcode,
    this.status,
    this.isFeatured,
    this.isNew,
    this.beds,
    this.baths,
    this.sizeSqft,
    this.lat,
    this.lon,
    this.coverImage,
    this.viewsCount,
    this.isFavourited,
    this.createdAt,
    this.agentId,
  });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    propertyType = json['property_type'];
    price = json['price'];
    address = json['address'];
    postcode = json['postcode'];
    status = json['status'];
    isFeatured = json['is_featured'];
    isNew = json['is_new'];
    beds = json['beds'];
    baths = json['baths'];
    sizeSqft = json['size_sqft'];
    lat = json['lat'];
    lon = json['lon'];
    coverImage = json['cover_image'];
    viewsCount = json['views_count'];
    isFavourited = json['is_favourited'];
    createdAt = json['created_at'];
    agentId = json['agent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['property_type'] = this.propertyType;
    data['price'] = this.price;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['status'] = this.status;
    data['is_featured'] = this.isFeatured;
    data['is_new'] = this.isNew;
    data['beds'] = this.beds;
    data['baths'] = this.baths;
    data['size_sqft'] = this.sizeSqft;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['cover_image'] = this.coverImage;
    data['views_count'] = this.viewsCount;
    data['is_favourited'] = this.isFavourited;
    data['created_at'] = this.createdAt;
    data['agent_id'] = this.agentId;
    return data;
  }

  PropertyModel toDomain() => PropertyModel(
    id!,
    title!,
    "2.5",
    address!,
    lat ?? 0.0,
    lon ?? 0.0,
    double.parse(price.toString()),
    isFeatured!,
    isNew!,
    beds!,
    baths!,
    sizeSqft!.toDouble(),
    coverImage ?? "",
    isFavourited!,
  );
}
