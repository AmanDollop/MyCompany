class GetLeaveDateCalenderModal {
  String? message;
  String? isBeforeDate;
  String? isAfterDate;
  List<LeaveCalender>? leaveCalender;

  GetLeaveDateCalenderModal(
      {this.message, this.isBeforeDate, this.isAfterDate, this.leaveCalender});

  GetLeaveDateCalenderModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isBeforeDate = json['isBeforeDate'];
    isAfterDate = json['isAfterDate'];
    if (json['leaveCalender'] != null) {
      leaveCalender = <LeaveCalender>[];
      json['leaveCalender'].forEach((v) {
        leaveCalender!.add(LeaveCalender.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['isBeforeDate'] = isBeforeDate;
    data['isAfterDate'] = isAfterDate;
    if (leaveCalender != null) {
      data['leaveCalender'] =
          leaveCalender!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveCalender {
  String? monthName;
  List<MonthDates>? monthDates;

  LeaveCalender({this.monthName, this.monthDates});

  LeaveCalender.fromJson(Map<String, dynamic> json) {
    monthName = json['monthName'];
    if (json['monthDates'] != null) {
      monthDates = <MonthDates>[];
      json['monthDates'].forEach((v) {
        monthDates!.add(MonthDates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['monthName'] = monthName;
    if (monthDates != null) {
      data['monthDates'] = monthDates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MonthDates {
  String? date;
  bool? holiday;
  bool? weekOff;
  bool? isLeave;
  bool? isPresent;

  MonthDates(
      {this.date, this.holiday, this.weekOff, this.isLeave, this.isPresent});

  MonthDates.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    holiday = json['holiday'];
    weekOff = json['week_off'];
    isLeave = json['is_leave'];
    isPresent = json['is_present'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['holiday'] = holiday;
    data['week_off'] = weekOff;
    data['is_leave'] = isLeave;
    data['is_present'] = isPresent;
    return data;
  }
}
