class OfferModel {
  int? count;
  List<Results>? results;

  OfferModel({this.count, this.results});

  OfferModel.fromJson(Map<String, dynamic> json) {
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
  String? property;
  String? propertyTitle;
  String? buyerName;
  String? email;
  String? phone;
  String? offerAmount;
  String? message;
  String? status;
  bool? isLead;
  // List<Null>? counterOffers;
  String? createdAt;
  String? updatedAt;

  Results(
      {this.id,
      this.property,
      this.propertyTitle,
      this.buyerName,
      this.email,
      this.phone,
      this.offerAmount,
      this.message,
      this.status,
      this.isLead,
      // this.counterOffers,
      this.createdAt,
      this.updatedAt});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    property = json['property'];
    propertyTitle = json['property_title'];
    buyerName = json['buyer_name'];
    email = json['email'];
    phone = json['phone'];
    offerAmount = json['offer_amount'];
    message = json['message'];
    status = json['status'];
    isLead = json['is_lead'];
    // if (json['counter_offers'] != null) {
    //   counterOffers = <Null>[];
    //   json['counter_offers'].forEach((v) {
    //     counterOffers!.add(new Null.fromJson(v));
    //   });
    // }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property'] = this.property;
    data['property_title'] = this.propertyTitle;
    data['buyer_name'] = this.buyerName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['offer_amount'] = this.offerAmount;
    data['message'] = this.message;
    data['status'] = this.status;
    data['is_lead'] = this.isLead;
    // if (this.counterOffers != null) {
    //   data['counter_offers'] =
    //       this.counterOffers!.map((v) => v.toJson()).toList();
    // }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
