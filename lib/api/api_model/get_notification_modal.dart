class GetNotificationModal {
  String? message;
  List<UserNotification>? userNotification;

  GetNotificationModal({this.message, this.userNotification});

  GetNotificationModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['user_notificatio'] != null) {
      userNotification = <UserNotification>[];
      json['user_notificatio'].forEach((v) {
        userNotification!.add(UserNotification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (userNotification != null) {
      data['user_notificatio'] =
          userNotification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserNotification {
  String? notificationTitle;
  String? notificationDescription;
  String? notificationDate;
  String? notificationJson;

  UserNotification(
      {this.notificationTitle,
        this.notificationDescription,
        this.notificationDate,
        this.notificationJson});

  UserNotification.fromJson(Map<String, dynamic> json) {
    notificationTitle = json['notification_title'];
    notificationDescription = json['notification_description'];
    notificationDate = json['notification_date'];
    notificationJson = json['notification_json'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notification_title'] = notificationTitle;
    data['notification_description'] = notificationDescription;
    data['notification_date'] = notificationDate;
    data['notification_json'] = notificationJson;
    return data;
  }
}
