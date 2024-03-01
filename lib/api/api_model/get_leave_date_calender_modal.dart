class GetLeaveDateCalenderModal {
  String? message;
  String? isAfterDate;
  String? isBeforeDate;
  List<LeaveCalender>? leaveCalender;

  GetLeaveDateCalenderModal(
      {this.message, this.isAfterDate, this.isBeforeDate, this.leaveCalender});

  GetLeaveDateCalenderModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isAfterDate = json['isAfterDate'];
    isBeforeDate = json['isBeforeDate'];
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
    data['isAfterDate'] = isAfterDate;
    data['isBeforeDate'] = isBeforeDate;
    if (leaveCalender != null) {
      data['leaveCalender'] =
          leaveCalender!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveCalender {
  String? date;
  bool? holiday;
  bool? weekOff;
  bool? isLeave;
  bool? isPresent;

  LeaveCalender(
      {this.date, this.holiday, this.weekOff, this.isLeave, this.isPresent});

  LeaveCalender.fromJson(Map<String, dynamic> json) {
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
