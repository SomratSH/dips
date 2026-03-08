import 'package:dips/domain/entity/property_type_model.dart';

class PropertyTypeJson {
  int? id;
  String? type;

  PropertyTypeJson({this.id, this.type});

  PropertyTypeJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }

  PropertyTypeModel toDomain() => PropertyTypeModel(id!, type);
}
