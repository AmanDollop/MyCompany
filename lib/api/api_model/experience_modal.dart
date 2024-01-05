class ExperienceModal {
  String? message;
  List<GetExperienceDetails>? getExperienceDetails;

  ExperienceModal({this.message, this.getExperienceDetails});

  ExperienceModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['getExperienceDetails'] != null) {
      getExperienceDetails = <GetExperienceDetails>[];
      json['getExperienceDetails'].forEach((v) {
        getExperienceDetails!.add(GetExperienceDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (getExperienceDetails != null) {
      data['getExperienceDetails'] =
          getExperienceDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetExperienceDetails {
  String? companyName;
  String? experienceId;
  String? designation;
  String? joiningDate;
  String? releaseDate;
  String? companyLocation;
  String? remark;

  GetExperienceDetails(
      {this.companyName,
        this.experienceId,
        this.designation,
        this.joiningDate,
        this.releaseDate,
        this.companyLocation,
        this.remark});

  GetExperienceDetails.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    experienceId = json['experience_id'];
    designation = json['designation'];
    joiningDate = json['joining_date'];
    releaseDate = json['release_date'];
    companyLocation = json['company_location'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_name'] = companyName;
    data['experience_id'] = experienceId;
    data['designation'] = designation;
    data['joining_date'] = joiningDate;
    data['release_date'] = releaseDate;
    data['company_location'] = companyLocation;
    data['remark'] = remark;
    return data;
  }
}
