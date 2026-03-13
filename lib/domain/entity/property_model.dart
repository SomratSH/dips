class PropertyModel {
  String id;
  String name;
  String rating;
  String location;
  String lat;
  String long;
  bool isFeature;
  bool isNew;
  int bed;
  int baths;
  double price;
  double size;
  String image;
  bool isFav;
  String qrCode;

  PropertyModel(
    this.id,
    this.name,
    this.rating,
    this.location,
    this.lat,
    this.long,
    this.price,
    this.isFeature,
    this.isNew,
    this.bed,
    this.baths,
    this.size,
    this.image,
    this.isFav,
    this.qrCode,
  );
}
