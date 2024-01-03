class EducationDetailsModal {
  String? message;
  List<GetEducationDetails>? getEducationDetails;

  EducationDetailsModal({this.message, this.getEducationDetails});

  EducationDetailsModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['getEducationDetails'] != null) {
      getEducationDetails = <GetEducationDetails>[];
      json['getEducationDetails'].forEach((v) {
        getEducationDetails!.add(GetEducationDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (getEducationDetails != null) {
      data['getEducationDetails'] =
          getEducationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetEducationDetails {
  String? classAchievement;
  String? educationAchievementId;
  String? type;
  String? typeView;
  String? universityLocation;
  String? year;
  String? remark;

  GetEducationDetails(
      {this.classAchievement,
        this.educationAchievementId,
        this.type,
        this.typeView,
        this.universityLocation,
        this.year,
        this.remark});

  GetEducationDetails.fromJson(Map<String, dynamic> json) {
    classAchievement = json['class_achievement'];
    educationAchievementId = json['education_achievement_id'];
    type = json['type'];
    typeView = json['type_view'];
    universityLocation = json['university_location'];
    year = json['year'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_achievement'] = classAchievement;
    data['education_achievement_id'] = educationAchievementId;
    data['type'] = type;
    data['type_view'] = typeView;
    data['university_location'] = universityLocation;
    data['year'] = year;
    data['remark'] = remark;
    return data;
  }
}
