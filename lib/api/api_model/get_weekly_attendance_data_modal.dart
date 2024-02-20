class GetWeeklyAttendanceDataModal {
  String? message;
  GetWeeklyAttendance? getWeeklyAttendance;

  GetWeeklyAttendanceDataModal({this.message, this.getWeeklyAttendance});

  GetWeeklyAttendanceDataModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    getWeeklyAttendance = json['getWeeklyAttendance'] != null
        ? GetWeeklyAttendance.fromJson(json['getWeeklyAttendance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (getWeeklyAttendance != null) {
      data['getWeeklyAttendance'] = getWeeklyAttendance!.toJson();
    }
    return data;
  }
}

class GetWeeklyAttendance {
  List<WeeklyHistory>? weeklyHistory;

  GetWeeklyAttendance({this.weeklyHistory});

  GetWeeklyAttendance.fromJson(Map<String, dynamic> json) {
    if (json['weekly_history'] != null) {
      weeklyHistory = <WeeklyHistory>[];
      json['weekly_history'].forEach((v) {
        weeklyHistory!.add(WeeklyHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (weeklyHistory != null) {
      data['weekly_history'] =
          weeklyHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WeeklyHistory {
  String? week;
  String? startDate;
  String? endDate;
  String? totalWeekMinutes;
  String? totalWeekRemainingMinutes;
  String? totalWeekExtraMinutes;
  String? totalProductiveWorkingMinutes;
  String? totalSpendMinutes;
  List<History>? history;

  WeeklyHistory(
      {this.week,
        this.startDate,
        this.endDate,
        this.totalWeekMinutes,
        this.totalWeekRemainingMinutes,
        this.totalWeekExtraMinutes,
        this.totalProductiveWorkingMinutes,
        this.totalSpendMinutes,
        this.history});

  WeeklyHistory.fromJson(Map<String, dynamic> json) {
    week = json['week'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    totalWeekMinutes = json['total_week_minutes'];
    totalWeekRemainingMinutes = json['total_week_remaining_minutes'];
    totalWeekExtraMinutes = json['total_week_extra_minutes'];
    totalProductiveWorkingMinutes = json['total_productive_working_minutes'];
    totalSpendMinutes = json['total_spend_minutes'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['week'] = week;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['total_week_minutes'] = totalWeekMinutes;
    data['total_week_remaining_minutes'] = totalWeekRemainingMinutes;
    data['total_week_extra_minutes'] = totalWeekExtraMinutes;
    data['total_productive_working_minutes'] =
        totalProductiveWorkingMinutes;
    data['total_spend_minutes'] = totalSpendMinutes;
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  String? dayName;
  String? attendanceDate;
  String? punchInTime;
  String? punchInDate;
  String? punchOutTime;
  String? punchOutDate;
  bool? extraDay;
  bool? isPunchOutMissing;
  String? attendanceId;
  String? totalWorkingMinutes;
  String? remainingWorkingMinutes;
  String? productiveWorkingMinutes;
  String? extraWorkingMinutes;
  bool? attendanceRejected;
  bool? attendnacePending;
  String? attendancePendingMessage;

  History(
      {this.dayName,
        this.attendanceDate,
        this.punchInTime,
        this.punchInDate,
        this.punchOutTime,
        this.punchOutDate,
        this.extraDay,
        this.isPunchOutMissing,
        this.attendanceId,
        this.totalWorkingMinutes,
        this.remainingWorkingMinutes,
        this.productiveWorkingMinutes,
        this.extraWorkingMinutes,
        this.attendanceRejected,
        this.attendnacePending,
        this.attendancePendingMessage});

  History.fromJson(Map<String, dynamic> json) {
    dayName = json['day_name'];
    attendanceDate = json['attendance_date'];
    punchInTime = json['punch_in_time'];
    punchInDate = json['punch_in_date'];
    punchOutTime = json['punch_out_time'];
    punchOutDate = json['punch_out_date'];
    extraDay = json['extra_day'];
    isPunchOutMissing = json['is_punch_out_missing'];
    attendanceId = json['attendance_id'];
    totalWorkingMinutes = json['total_working_minutes'];
    remainingWorkingMinutes = json['remaining_working_minutes'];
    productiveWorkingMinutes = json['productive_working_minutes'];
    extraWorkingMinutes = json['extra_working_minutes'];
    attendanceRejected = json['attendance_rejected'];
    attendnacePending = json['attendnace_pending'];
    attendancePendingMessage = json['attendance_pending_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day_name'] = dayName;
    data['attendance_date'] = attendanceDate;
    data['punch_in_time'] = punchInTime;
    data['punch_in_date'] = punchInDate;
    data['punch_out_time'] = punchOutTime;
    data['punch_out_date'] = punchOutDate;
    data['extra_day'] = extraDay;
    data['is_punch_out_missing'] = isPunchOutMissing;
    data['attendance_id'] = attendanceId;
    data['total_working_minutes'] = totalWorkingMinutes;
    data['remaining_working_minutes'] = remainingWorkingMinutes;
    data['productive_working_minutes'] = productiveWorkingMinutes;
    data['extra_working_minutes'] = extraWorkingMinutes;
    data['attendance_rejected'] = attendanceRejected;
    data['attendnace_pending'] = attendnacePending;
    data['attendance_pending_message'] = attendancePendingMessage;
    return data;
  }
}
