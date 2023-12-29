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

  GetCompanyDetails(
      {this.companyId,
        this.countryId,
        this.companyName,
        this.companyAddress,
        this.companyLatitude,
        this.companyLongitude,
        this.companyLogo});

  GetCompanyDetails.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    countryId = json['country_id'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    companyLatitude = json['company_latitude'];
    companyLongitude = json['company_longitude'];
    companyLogo = json['company_logo'];
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
    return data;
  }
}
