class NotificaitonModel {
  String? id;
  String? title;
  String? body;
  String? notificationType;
  bool? isRead;
  String? createdAt;

  NotificaitonModel(
      {this.id,
      this.title,
      this.body,
      this.notificationType,
      this.isRead,
      this.createdAt});

  NotificaitonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    notificationType = json['notification_type'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['notification_type'] = this.notificationType;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    return data;
  }
}
