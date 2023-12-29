class UserDataModal {
  String? message;
  UserDetails? userDetails;

  UserDataModal({this.message, this.userDetails});

  UserDataModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userDetails = json['userDetails'] != null
        ? UserDetails.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (userDetails != null) {
      data['userDetails'] = userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  PersonalInfo? personalInfo;
  ContactInfo? contactInfo;
  JobInfo? jobInfo;
  SocialInfo? socialInfo;
  String? token;

  UserDetails(
      {this.personalInfo,
        this.contactInfo,
        this.jobInfo,
        this.socialInfo,
        this.token});

  UserDetails.fromJson(Map<String, dynamic> json) {
    personalInfo = json['personal_info'] != null
        ? PersonalInfo.fromJson(json['personal_info'])
        : null;
    contactInfo = json['contact_info'] != null
        ? ContactInfo.fromJson(json['contact_info'])
        : null;
    jobInfo = json['job_info'] != null
        ? JobInfo.fromJson(json['job_info'])
        : null;
    socialInfo = json['social_info'] != null
        ? SocialInfo.fromJson(json['social_info'])
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (personalInfo != null) {
      data['personal_info'] = personalInfo!.toJson();
    }
    if (contactInfo != null) {
      data['contact_info'] = contactInfo!.toJson();
    }
    if (jobInfo != null) {
      data['job_info'] = jobInfo!.toJson();
    }
    if (socialInfo != null) {
      data['social_info'] = socialInfo!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class PersonalInfo {
  String? userFirstName;
  String? userMiddleName;
  String? userLastName;
  String? userFullName;
  String? gender;
  String? bloodGroup;
  String? userProfilePic;
  String? memberDateOfBirth;
  String? hobbiesAndInterest;
  String? skills;
  String? languageKnown;

  PersonalInfo(
      {this.userFirstName,
        this.userMiddleName,
        this.userLastName,
        this.userFullName,
        this.gender,
        this.bloodGroup,
        this.userProfilePic,
        this.memberDateOfBirth,
        this.hobbiesAndInterest,
        this.skills,
        this.languageKnown});

  PersonalInfo.fromJson(Map<String, dynamic> json) {
    userFirstName = json['user_first_name'];
    userMiddleName = json['user_middle_name'];
    userLastName = json['user_last_name'];
    userFullName = json['user_full_name'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    userProfilePic = json['user_profile_pic'];
    memberDateOfBirth = json['member_date_of_birth'];
    hobbiesAndInterest = json['hobbies_and_interest'];
    skills = json['skills'];
    languageKnown = json['language_known'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_first_name'] = userFirstName;
    data['user_middle_name'] = userMiddleName;
    data['user_last_name'] = userLastName;
    data['user_full_name'] = userFullName;
    data['gender'] = gender;
    data['blood_group'] = bloodGroup;
    data['user_profile_pic'] = userProfilePic;
    data['member_date_of_birth'] = memberDateOfBirth;
    data['hobbies_and_interest'] = hobbiesAndInterest;
    data['skills'] = skills;
    data['language_known'] = languageKnown;
    return data;
  }
}

class ContactInfo {
  String? countryCode;
  String? userMobile;
  String? whatsappCountryCode;
  String? whatsappNumber;
  String? personalEmail;
  String? userEmail;
  String? currentAddress;
  String? permanentAddress;
  String? userMobilePrivacy;
  String? whatsappNumberPrivacy;
  String? userEmailPrivacy;
  String? personalEmailPrivacy;
  String? currentAddressPrivacy;
  String? permanentAddressPrivacy;

  ContactInfo(
      {this.countryCode,
        this.userMobile,
        this.whatsappCountryCode,
        this.whatsappNumber,
        this.personalEmail,
        this.userEmail,
        this.currentAddress,
        this.permanentAddress,
        this.userMobilePrivacy,
        this.whatsappNumberPrivacy,
        this.userEmailPrivacy,
        this.personalEmailPrivacy,
        this.currentAddressPrivacy,
        this.permanentAddressPrivacy});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    userMobile = json['user_mobile'];
    whatsappCountryCode = json['whatsapp_country_code'];
    whatsappNumber = json['whatsapp_number'];
    personalEmail = json['personal_email'];
    userEmail = json['user_email'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    userMobilePrivacy = json['user_mobile_privacy'];
    whatsappNumberPrivacy = json['whatsapp_number_privacy'];
    userEmailPrivacy = json['user_email_privacy'];
    personalEmailPrivacy = json['personal_email_privacy'];
    currentAddressPrivacy = json['current_address_privacy'];
    permanentAddressPrivacy = json['permanent_address_privacy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_code'] = countryCode;
    data['user_mobile'] = userMobile;
    data['whatsapp_country_code'] = whatsappCountryCode;
    data['whatsapp_number'] = whatsappNumber;
    data['personal_email'] = personalEmail;
    data['user_email'] = userEmail;
    data['current_address'] = currentAddress;
    data['permanent_address'] = permanentAddress;
    data['user_mobile_privacy'] = userMobilePrivacy;
    data['whatsapp_number_privacy'] = whatsappNumberPrivacy;
    data['user_email_privacy'] = userEmailPrivacy;
    data['personal_email_privacy'] = personalEmailPrivacy;
    data['current_address_privacy'] = currentAddressPrivacy;
    data['permanent_address_privacy'] = permanentAddressPrivacy;
    return data;
  }
}

class JobInfo {
  String? userDesignation;
  String? dateOfJoining;
  String? employeeId;
  String? employeeType;
  String? employeeTypeView;
  String? branchName;
  String? departmentName;
  String? branchId;
  String? departmentId;

  JobInfo(
      {this.userDesignation,
        this.dateOfJoining,
        this.employeeId,
        this.employeeType,
        this.employeeTypeView,
        this.branchName,
        this.departmentName,
        this.branchId,
        this.departmentId});

  JobInfo.fromJson(Map<String, dynamic> json) {
    userDesignation = json['user_designation'];
    dateOfJoining = json['date_of_joining'];
    employeeId = json['employee_id'];
    employeeType = json['employee_type'];
    employeeTypeView = json['employee_type_view'];
    branchName = json['branch_name'];
    departmentName = json['department_name'];
    branchId = json['branch_id'];
    departmentId = json['department_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_designation'] = userDesignation;
    data['date_of_joining'] = dateOfJoining;
    data['employee_id'] = employeeId;
    data['employee_type'] = employeeType;
    data['employee_type_view'] = employeeTypeView;
    data['branch_name'] = branchName;
    data['department_name'] = departmentName;
    data['branch_id'] = branchId;
    data['department_id'] = departmentId;
    return data;
  }
}

class SocialInfo {
  String? twitter;
  String? linkedin;
  String? instagram;
  String? facebook;
  String? socialLinksPrivacy;

  SocialInfo(
      {this.twitter,
        this.linkedin,
        this.instagram,
        this.facebook,
        this.socialLinksPrivacy});

  SocialInfo.fromJson(Map<String, dynamic> json) {
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    socialLinksPrivacy = json['social_links_privacy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['twitter'] = twitter;
    data['linkedin'] = linkedin;
    data['instagram'] = instagram;
    data['facebook'] = facebook;
    data['social_links_privacy'] = socialLinksPrivacy;
    return data;
  }
}
