class CompanyDetailsModal {
  String? message;
  GetCompanyDetails? getCompanyDetails;

  CompanyDetailsModal({this.message, this.getCompanyDetails});

  CompanyDetailsModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    getCompanyDetails = json['getCompanyDetails'] != null
        ? GetCompanyDetails.fromJson(json['getCompanyDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (getCompanyDetails != null) {
      data['getCompanyDetails'] = getCompanyDetails!.toJson();
    }
    return data;
  }
}

class GetCompanyDetails {
  String? companyId;
  String? countryId;
  String? companyName;
  String? companyAddress;
  String? companyLatitude;
  String? companyLongitude;
  String? companyLogo;
  bool? hideUpcomingCelebration;
  bool? hideMyDepartment;
  bool? hideGallery;
  bool? hideBanner;
  bool? hideMyTeam;
  bool? hideMyReportingPerson;
  bool? attendanceSelfieRequired;
  bool? restrictAttendanceOutOfRange;
  bool? workReportRequiredOnPunchOut;

  GetCompanyDetails(
      {this.companyId,
        this.countryId,
        this.companyName,
        this.companyAddress,
        this.companyLatitude,
        this.companyLongitude,
        this.companyLogo,
        this.hideUpcomingCelebration,
        this.hideMyDepartment,
        this.hideGallery,
        this.hideBanner,
        this.hideMyTeam,
        this.hideMyReportingPerson,
        this.attendanceSelfieRequired,
        this.restrictAttendanceOutOfRange,
        this.workReportRequiredOnPunchOut});

  GetCompanyDetails.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    countryId = json['country_id'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    companyLatitude = json['company_latitude'];
    companyLongitude = json['company_longitude'];
    companyLogo = json['company_logo'];
    hideUpcomingCelebration = json['hide_upcoming_celebration'];
    hideMyDepartment = json['hide_my_department'];
    hideGallery = json['hide_gallery'];
    hideBanner = json['hide_banner'];
    hideMyTeam = json['hide_my_team'];
    hideMyReportingPerson = json['hide_my_reporting_person'];
    attendanceSelfieRequired = json['attendance_selfie_required'];
    restrictAttendanceOutOfRange = json['restrict_attendance_out_of_range'];
    workReportRequiredOnPunchOut = json['work_report_required_on_punch_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_id'] = companyId;
    data['country_id'] = countryId;
    data['company_name'] = companyName;
    data['company_address'] = companyAddress;
    data['company_latitude'] = companyLatitude;
    data['company_longitude'] = companyLongitude;
    data['company_logo'] = companyLogo;
    data['hide_upcoming_celebration'] = hideUpcomingCelebration;
    data['hide_my_department'] = hideMyDepartment;
    data['hide_gallery'] = hideGallery;
    data['hide_banner'] = hideBanner;
    data['hide_my_team'] = hideMyTeam;
    data['hide_my_reporting_person'] = hideMyReportingPerson;
    data['attendance_selfie_required'] = attendanceSelfieRequired;
    data['restrict_attendance_out_of_range'] =
        restrictAttendanceOutOfRange;
    data['work_report_required_on_punch_out'] =
        workReportRequiredOnPunchOut;
    return data;
  }
}
