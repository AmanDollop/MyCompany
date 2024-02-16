class HolidayModal {
  String? message;
  List<Holiday>? holiday;

  HolidayModal({this.message, this.holiday});

  HolidayModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['holiday'] != null) {
      holiday = <Holiday>[];
      json['holiday'].forEach((v) {
        holiday!.add(Holiday.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (holiday != null) {
      data['holiday'] = holiday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Holiday {
  String? holidayName;
  String? holidayStartDate;

  Holiday({this.holidayName, this.holidayStartDate});

  Holiday.fromJson(Map<String, dynamic> json) {
    holidayName = json['holiday_name'];
    holidayStartDate = json['holiday_start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['holiday_name'] = holidayName;
    data['holiday_start_date'] = holidayStartDate;
    return data;
  }
}
