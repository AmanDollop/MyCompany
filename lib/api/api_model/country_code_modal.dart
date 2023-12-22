class CountryCodeModal {
  String? message;
  List<CountryCodeList>? data;

  CountryCodeModal({this.message, this.data});

  CountryCodeModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <CountryCodeList>[];
      json['data'].forEach((v) {
        data!.add(CountryCodeList.fromJson(v));
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

class CountryCodeList {
  String? countryId;
  String? countryName;
  String? iso2;
  String? phonecode;
  String? flag;

  CountryCodeList(
      {this.countryId, this.countryName, this.iso2, this.phonecode, this.flag});

  CountryCodeList.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    countryName = json['countryName'];
    iso2 = json['iso2'];
    phonecode = json['phonecode'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countryId'] = countryId;
    data['countryName'] = countryName;
    data['iso2'] = iso2;
    data['phonecode'] = phonecode;
    data['flag'] = flag;
    return data;
  }
}
