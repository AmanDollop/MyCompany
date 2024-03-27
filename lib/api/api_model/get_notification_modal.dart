class GetNotificationModal {
  String? message;
  List<Notification>? notification;

  GetNotificationModal({this.message, this.notification});

  GetNotificationModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['notification'] != null) {
      notification = <Notification>[];
      json['notification'].forEach((v) {
        notification!.add(Notification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (notification != null) {
      data['notification'] = notification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notification {
  String? userNotificationId;
  String? notificationTitle;
  String? notificationDescription;
  String? clickAction;
  String? notificationImage;
  String? notificationDate;
  String? isRead;
  NotificationJson? notificationJson;

  Notification(
      {this.userNotificationId,
        this.notificationTitle,
        this.notificationDescription,
        this.clickAction,
        this.notificationImage,
        this.notificationDate,
        this.isRead,
        this.notificationJson});

  Notification.fromJson(Map<String, dynamic> json) {
    userNotificationId = json['user_notification_id'];
    notificationTitle = json['notification_title'];
    notificationDescription = json['notification_description'];
    clickAction = json['click_action'];
    notificationImage = json['notification_image'];
    notificationDate = json['notification_date'];
    isRead = json['is_read'];
    notificationJson = json['notification_json'] != null
        ? NotificationJson.fromJson(json['notification_json'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_notification_id'] = userNotificationId;
    data['notification_title'] = notificationTitle;
    data['notification_description'] = notificationDescription;
    data['click_action'] = clickAction;
    data['notification_image'] = notificationImage;
    data['notification_date'] = notificationDate;
    data['is_read'] = isRead;
    if (notificationJson != null) {
      data['notification_json'] = notificationJson!.toJson();
    }
    return data;
  }
}

class NotificationJson {
  String? taskCategoryId;
  String? taskCategoryName;

  NotificationJson({this.taskCategoryId, this.taskCategoryName});

  NotificationJson.fromJson(Map<String, dynamic> json) {
    taskCategoryId = json['task_category_id'];
    taskCategoryName = json['task_category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_category_id'] = taskCategoryId;
    data['task_category_name'] = taskCategoryName;
    return data;
  }
}
