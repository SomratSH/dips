class AgentDashboardModel {
  int? totalPropertyListing;
  int? totalPropertyViews;
  int? totalOffersReceived;
  int? totalQrScanned;
  List<RecentActivity>? recentActivity;

  AgentDashboardModel(
      {this.totalPropertyListing,
      this.totalPropertyViews,
      this.totalOffersReceived,
      this.totalQrScanned,
      this.recentActivity});

  AgentDashboardModel.fromJson(Map<String, dynamic> json) {
    totalPropertyListing = json['total_property_listing'];
    totalPropertyViews = json['total_property_views'];
    totalOffersReceived = json['total_offers_received'];
    totalQrScanned = json['total_qr_scanned'];
    if (json['recent_activity'] != null) {
      recentActivity = <RecentActivity>[];
      json['recent_activity'].forEach((v) {
        recentActivity!.add(new RecentActivity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_property_listing'] = this.totalPropertyListing;
    data['total_property_views'] = this.totalPropertyViews;
    data['total_offers_received'] = this.totalOffersReceived;
    data['total_qr_scanned'] = this.totalQrScanned;
    if (this.recentActivity != null) {
      data['recent_activity'] =
          this.recentActivity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentActivity {
  String? propertyName;
  String? activity;
  String? type;
  String? time;

  RecentActivity({this.propertyName, this.activity, this.type, this.time});

  RecentActivity.fromJson(Map<String, dynamic> json) {
    propertyName = json['property_name'];
    activity = json['activity'];
    type = json['type'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property_name'] = this.propertyName;
    data['activity'] = this.activity;
    data['type'] = this.type;
    data['time'] = this.time;
    return data;
  }
}
