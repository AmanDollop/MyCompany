class GetEmployeeDetailsModal {
  String? message;
  List<GetEmployeeDetails>? getEmployeeDetails;

  GetEmployeeDetailsModal({this.message, this.getEmployeeDetails});

  GetEmployeeDetailsModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['getEmployeeDetails'] != null) {
      getEmployeeDetails = <GetEmployeeDetails>[];
      json['getEmployeeDetails'].forEach((v) {
        getEmployeeDetails!.add(GetEmployeeDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (getEmployeeDetails != null) {
      data['getEmployeeDetails'] =
          getEmployeeDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetEmployeeDetails {
  String? profileMenuName;
  String? menuClick;
  String? profileMenuPhoto;
  String? accessType;
  String? isChangeable;

  GetEmployeeDetails(
      {this.profileMenuName,
        this.menuClick,
        this.profileMenuPhoto,
        this.accessType,
        this.isChangeable});

  GetEmployeeDetails.fromJson(Map<String, dynamic> json) {
    profileMenuName = json['profile_menu_name'];
    menuClick = json['menu_click'];
    profileMenuPhoto = json['profile_menu_photo'];
    accessType = json['access_type'];
    isChangeable = json['is_changeable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_menu_name'] = profileMenuName;
    data['menu_click'] = menuClick;
    data['profile_menu_photo'] = profileMenuPhoto;
    data['access_type'] = accessType;
    data['is_changeable'] = isChangeable;
    return data;
  }
}
