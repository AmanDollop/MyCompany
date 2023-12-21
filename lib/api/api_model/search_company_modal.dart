class SearchCompanyModal {
  String? message;
  List<SearchCompanyList>? data;

  SearchCompanyModal({this.message, this.data});

  SearchCompanyModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <SearchCompanyList>[];
      json['data'].forEach((v) {
        data!.add(SearchCompanyList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchCompanyList {
  String? companyId;
  String? companyName;
  String? companyAddress;
  String? companyLogo;
  String? baseUrl;
  String? companyWebsite;

  SearchCompanyList(
      {this.companyId,
        this.companyName,
        this.companyAddress,
        this.companyLogo,
        this.baseUrl,
        this.companyWebsite});

  SearchCompanyList.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    companyLogo = json['company_logo'];
    baseUrl = json['base_url'];
    companyWebsite = json['company_website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['company_address'] = companyAddress;
    data['company_logo'] = companyLogo;
    data['base_url'] = baseUrl;
    data['company_website'] = companyWebsite;
    return data;
  }
}
