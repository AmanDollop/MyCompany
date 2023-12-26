class PersonalInfoModal {
  String? message;
  PersonalInfo? personalInfo;

  PersonalInfoModal({this.message, this.personalInfo});

  PersonalInfoModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    personalInfo = json['Personal_Info'] != null
        ? PersonalInfo.fromJson(json['Personal_Info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (personalInfo != null) {
      data['Personal_Info'] = personalInfo!.toJson();
    }
    return data;
  }
}

class PersonalInfo {
  String? userFirstName;
  String? userMiddleName;
  String? userLastName;
  String? userProfilePic;
  String? memberDateOfBirth;
  String? bloodGroup;
  String? gender;
  String? maritalStatus;
  String? nationality;
  String? hobbiesAndInterest;
  String? skills;
  String? languageKnown;

  PersonalInfo(
      {this.userFirstName,
        this.userMiddleName,
        this.userLastName,
        this.userProfilePic,
        this.memberDateOfBirth,
        this.bloodGroup,
        this.gender,
        this.maritalStatus,
        this.nationality,
        this.hobbiesAndInterest,
        this.skills,
        this.languageKnown});

  PersonalInfo.fromJson(Map<String, dynamic> json) {
    userFirstName = json['user_first_name'];
    userMiddleName = json['user_middle_name'];
    userLastName = json['user_last_name'];
    userProfilePic = json['user_profile_pic'];
    memberDateOfBirth = json['member_date_of_birth'];
    bloodGroup = json['blood_group'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    nationality = json['nationality'];
    hobbiesAndInterest = json['hobbies_and_interest'];
    skills = json['skills'];
    languageKnown = json['language_known'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_first_name'] = userFirstName;
    data['user_middle_name'] = userMiddleName;
    data['user_last_name'] = userLastName;
    data['user_profile_pic'] = userProfilePic;
    data['member_date_of_birth'] = memberDateOfBirth;
    data['blood_group'] = bloodGroup;
    data['gender'] = gender;
    data['marital_status'] = maritalStatus;
    data['nationality'] = nationality;
    data['hobbies_and_interest'] = hobbiesAndInterest;
    data['skills'] = skills;
    data['language_known'] = languageKnown;
    return data;
  }
}
