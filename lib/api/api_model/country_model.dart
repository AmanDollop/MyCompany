class CountryModel {
  String? message;
  List<Country>? country;

  CountryModel({this.message, this.country});

  CountryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      country = <Country>[];
      json['data'].forEach((v) {
        country!.add(Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (country != null) {
      data['data'] = country!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  String? countryId;
  String? countryName;
  String? countryCode;
  String? shortName;
  String? flag;

  Country(
      {this.countryId,
        this.countryName,
        this.countryCode,
        this.shortName,
        this.flag});

  Country.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    countryName = json['countryName'];
    countryCode = json['countryCode'];
    shortName = json['shortName'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countryId'] = countryId;
    data['countryName'] = countryName;
    data['countryCode'] = countryCode;
    data['shortName'] = shortName;
    data['flag'] = flag;
    return data;
  }
}