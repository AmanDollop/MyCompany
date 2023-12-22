class UserDataModal {
  String? message;
  UserData? data;

  UserDataModal({this.message, this.data});

  UserDataModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  String? userId;
  String? userEmail;
  String? companyId;
  String? token;

  UserData({this.userId, this.userEmail, this.companyId, this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userEmail = json['user_email'];
    companyId = json['company_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_email'] = userEmail;
    data['company_id'] = companyId;
    data['token'] = token;
    return data;
  }
}
