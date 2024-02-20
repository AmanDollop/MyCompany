class GetReportingPersonModal {
  String? message;
  List<MyReportingTeam>? myReportingTeam;

  GetReportingPersonModal({this.message, this.myReportingTeam});

  GetReportingPersonModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['my_reporting_team'] != null) {
      myReportingTeam = <MyReportingTeam>[];
      json['my_reporting_team'].forEach((v) {
        myReportingTeam!.add(MyReportingTeam.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (myReportingTeam != null) {
      data['my_reporting_team'] =
          myReportingTeam!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyReportingTeam {
  String? userId;
  String? branchId;
  String? departmentId;
  String? userFullName;
  String? userDesignation;
  String? userProfilePic;
  String? shortName;

  MyReportingTeam(
      {this.userId,
        this.branchId,
        this.departmentId,
        this.userFullName,
        this.userDesignation,
        this.userProfilePic,
        this.shortName});

  MyReportingTeam.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    branchId = json['branch_id'];
    departmentId = json['department_id'];
    userFullName = json['user_full_name'];
    userDesignation = json['user_designation'];
    userProfilePic = json['user_profile_pic'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['branch_id'] = branchId;
    data['department_id'] = departmentId;
    data['user_full_name'] = userFullName;
    data['user_designation'] = userDesignation;
    data['user_profile_pic'] = userProfilePic;
    data['short_name'] = shortName;
    return data;
  }
}
