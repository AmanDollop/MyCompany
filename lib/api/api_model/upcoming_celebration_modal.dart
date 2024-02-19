class UpcomingCelebrationModal {
  String? message;
  List<Celebration>? celebration;

  UpcomingCelebrationModal({this.message, this.celebration});

  UpcomingCelebrationModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['celebration'] != null) {
      celebration = <Celebration>[];
      json['celebration'].forEach((v) {
        celebration!.add(Celebration.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (celebration != null) {
      data['celebration'] = celebration!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Celebration {
  String? userId;
  String? userFullName;
  String? userProfilePic;
  String? userDesignation;
  String? date;
  String? celebrationDate;
  String? celebrationType;
  String? celebrationYear;
  String? branchName;
  String? departmentName;
  String? shortName;

  Celebration(
      {this.userId,
        this.userFullName,
        this.userProfilePic,
        this.userDesignation,
        this.date,
        this.celebrationDate,
        this.celebrationType,
        this.celebrationYear,
        this.branchName,
        this.departmentName,
        this.shortName});

  Celebration.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userFullName = json['user_full_name'];
    userProfilePic = json['user_profile_pic'];
    userDesignation = json['user_designation'];
    date = json['date'];
    celebrationDate = json['celebration_date'];
    celebrationType = json['celebration_type'];
    celebrationYear = json['celebration_year'];
    branchName = json['branch_name'];
    departmentName = json['department_name'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_full_name'] = userFullName;
    data['user_profile_pic'] = userProfilePic;
    data['user_designation'] = userDesignation;
    data['date'] = date;
    data['celebration_date'] = celebrationDate;
    data['celebration_type'] = celebrationType;
    data['celebration_year'] = celebrationYear;
    data['branch_name'] = branchName;
    data['department_name'] = departmentName;
    data['short_name'] = shortName;
    return data;
  }
}
