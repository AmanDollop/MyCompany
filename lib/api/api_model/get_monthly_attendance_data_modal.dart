class GetMonthlyAttendanceDataModal {
  String? message;
  GetMonthlyAttendance? getMonthlyAttendance;

  GetMonthlyAttendanceDataModal({this.message, this.getMonthlyAttendance});

  GetMonthlyAttendanceDataModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    getMonthlyAttendance = json['getMonthlyAttendance'] != null
        ? GetMonthlyAttendance.fromJson(json['getMonthlyAttendance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (getMonthlyAttendance != null) {
      data['getMonthlyAttendance'] = getMonthlyAttendance!.toJson();
    }
    return data;
  }
}

class GetMonthlyAttendance {
  List<MonthlyHistory>? monthlyHistory;
  String? totalMonthlyTime;
  String? totalWorkingMinutes;
  String? totalRemainingMinutes;
  String? totalSpendMinutes;
  String? totalProductiveWorkingMinutes;
  String? totalExtraMinutes;
  String? totalWorkingDays;
  String? totalPresent;
  String? totalAbsent;
  String? lateIn;
  String? isLeave;
  String? earlyOut;
  String? totalExtraDays;
  String? totalHolidays;
  String? totalWeekOff;
  String? totalPendingAttendance;
  String? totalRejectedAttendance;
  String? totalPunchOutMissing;

  GetMonthlyAttendance(
      {this.monthlyHistory,
        this.totalMonthlyTime,
        this.totalWorkingMinutes,
        this.totalRemainingMinutes,
        this.totalSpendMinutes,
        this.totalProductiveWorkingMinutes,
        this.totalExtraMinutes,
        this.totalWorkingDays,
        this.totalPresent,
        this.totalAbsent,
        this.lateIn,
        this.isLeave,
        this.earlyOut,
        this.totalExtraDays,
        this.totalHolidays,
        this.totalWeekOff,
        this.totalPendingAttendance,
        this.totalRejectedAttendance,
        this.totalPunchOutMissing});

  GetMonthlyAttendance.fromJson(Map<String, dynamic> json) {
    if (json['monthly_history'] != null) {
      monthlyHistory = <MonthlyHistory>[];
      json['monthly_history'].forEach((v) {
        monthlyHistory!.add(MonthlyHistory.fromJson(v));
      });
    }
    totalMonthlyTime = json['total_monthly_time'];
    totalWorkingMinutes = json['total_working_minutes'];
    totalRemainingMinutes = json['total_remaining_minutes'];
    totalSpendMinutes = json['total_spend_minutes'];
    totalProductiveWorkingMinutes = json['total_productive_working_minutes'];
    totalExtraMinutes = json['total_extra_minutes'];
    totalWorkingDays = json['total_working_days'];
    totalPresent = json['total_present'];
    totalAbsent = json['total_absent'];
    lateIn = json['late_in'];
    isLeave = json['is_leave'];
    earlyOut = json['early_out'];
    totalExtraDays = json['total_extra_days'];
    totalHolidays = json['total_holidays'];
    totalWeekOff = json['total_week_off'];
    totalPendingAttendance = json['total_pending_attendance'];
    totalRejectedAttendance = json['total_rejected_attendance'];
    totalPunchOutMissing = json['total_punch_out_missing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (monthlyHistory != null) {
      data['monthly_history'] =
          monthlyHistory!.map((v) => v.toJson()).toList();
    }
    data['total_monthly_time'] = totalMonthlyTime;
    data['total_working_minutes'] = totalWorkingMinutes;
    data['total_remaining_minutes'] = totalRemainingMinutes;
    data['total_spend_minutes'] = totalSpendMinutes;
    data['total_productive_working_minutes'] =
        totalProductiveWorkingMinutes;
    data['total_extra_minutes'] = totalExtraMinutes;
    data['total_working_days'] = totalWorkingDays;
    data['total_present'] = totalPresent;
    data['total_absent'] = totalAbsent;
    data['late_in'] = lateIn;
    data['is_leave'] = isLeave;
    data['early_out'] = earlyOut;
    data['total_extra_days'] = totalExtraDays;
    data['total_holidays'] = totalHolidays;
    data['total_week_off'] = totalWeekOff;
    data['total_pending_attendance'] = totalPendingAttendance;
    data['total_rejected_attendance'] = totalRejectedAttendance;
    data['total_punch_out_missing'] = totalPunchOutMissing;
    return data;
  }
}

class MonthlyHistory {
  String? date;
  bool? holiday;
  bool? weekOff;
  bool? workReport;
  bool? leave;
  bool? present;
  bool? extraDay;
  bool? lateIn;
  bool? earlyOut;
  bool? isPunchOutMissing;
  String? holidayName;
  String? holidayDescription;
  String? punchInDate;
  String? punchInTime;
  String? punchOutDate;
  String? punchOutTime;
  String? totalSpendTime;
  String? extraWorkingMinutes;
  String? remainingWorkingMinutes;
  bool? attendnacePending;
  String? attendancePendingMessage;
  bool? attendanceDeclined;
  String? attendanceDeclinedMessage;
  String? attendanceId;
  String? totalShiftMinutes;
  String? totalWorkingMinutes;
  bool? punchInRequestSent;
  List<AttendanceBreakHistory>? attendanceBreakHistory;
  String? punchOutMissingMessage;

  MonthlyHistory(
      {this.date,
        this.holiday,
        this.weekOff,
        this.workReport,
        this.leave,
        this.present,
        this.extraDay,
        this.lateIn,
        this.earlyOut,
        this.isPunchOutMissing,
        this.holidayName,
        this.holidayDescription,
        this.punchInDate,
        this.punchInTime,
        this.punchOutDate,
        this.punchOutTime,
        this.totalSpendTime,
        this.extraWorkingMinutes,
        this.remainingWorkingMinutes,
        this.attendnacePending,
        this.attendancePendingMessage,
        this.attendanceDeclined,
        this.attendanceDeclinedMessage,
        this.attendanceId,
        this.totalShiftMinutes,
        this.totalWorkingMinutes,
        this.punchInRequestSent,
        this.attendanceBreakHistory,
        this.punchOutMissingMessage});

  MonthlyHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    holiday = json['holiday'];
    weekOff = json['week_off'];
    workReport = json['work_report'];
    leave = json['leave'];
    present = json['present'];
    extraDay = json['extra_day'];
    lateIn = json['late_in'];
    earlyOut = json['early_out'];
    isPunchOutMissing = json['is_punch_out_missing'];
    holidayName = json['holiday_name'];
    holidayDescription = json['holiday_description'];
    punchInDate = json['punch_in_date'];
    punchInTime = json['punch_in_time'];
    punchOutDate = json['punch_out_date'];
    punchOutTime = json['punch_out_time'];
    totalSpendTime = json['total_spend_time'];
    extraWorkingMinutes = json['extra_working_minutes'];
    remainingWorkingMinutes = json['remaining_working_minutes'];
    attendnacePending = json['attendnace_pending'];
    attendancePendingMessage = json['attendance_pending_message'];
    attendanceDeclined = json['attendance_declined'];
    attendanceDeclinedMessage = json['attendance_declined_message'];
    attendanceId = json['attendance_id'];
    totalShiftMinutes = json['total_shift_minutes'];
    totalWorkingMinutes = json['total_working_minutes'];
    punchInRequestSent = json['punch_in_request_sent'];
    if (json['attendance_break_history'] != null) {
      attendanceBreakHistory = <AttendanceBreakHistory>[];
      json['attendance_break_history'].forEach((v) {
        attendanceBreakHistory!.add(AttendanceBreakHistory.fromJson(v));
      });
    }
    punchOutMissingMessage = json['punch_out_missing_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['holiday'] = holiday;
    data['week_off'] = weekOff;
    data['work_report'] = workReport;
    data['leave'] = leave;
    data['present'] = present;
    data['extra_day'] = extraDay;
    data['late_in'] = lateIn;
    data['early_out'] = earlyOut;
    data['is_punch_out_missing'] = isPunchOutMissing;
    data['holiday_name'] = holidayName;
    data['holiday_description'] = holidayDescription;
    data['punch_in_date'] = punchInDate;
    data['punch_in_time'] = punchInTime;
    data['punch_out_date'] = punchOutDate;
    data['punch_out_time'] = punchOutTime;
    data['total_spend_time'] = totalSpendTime;
    data['extra_working_minutes'] = extraWorkingMinutes;
    data['remaining_working_minutes'] = remainingWorkingMinutes;
    data['attendnace_pending'] = attendnacePending;
    data['attendance_pending_message'] = attendancePendingMessage;
    data['attendance_declined'] = attendanceDeclined;
    data['attendance_declined_message'] = attendanceDeclinedMessage;
    data['attendance_id'] = attendanceId;
    data['total_shift_minutes'] = totalShiftMinutes;
    data['total_working_minutes'] = totalWorkingMinutes;
    data['punch_in_request_sent'] = punchInRequestSent;
    if (attendanceBreakHistory != null) {
      data['attendance_break_history'] =
          attendanceBreakHistory!.map((v) => v.toJson()).toList();
    }
    data['punch_out_missing_message'] = punchOutMissingMessage;
    return data;
  }
}

class AttendanceBreakHistory {
  String? breakHistoryId;
  String? breakTypeName;
  String? breakStartDate;
  String? breakEndDate;
  String? breakStartTime;
  String? breakEndTime;
  String? totalBreakTimeMinutes;

  AttendanceBreakHistory(
      {this.breakHistoryId,
        this.breakTypeName,
        this.breakStartDate,
        this.breakEndDate,
        this.breakStartTime,
        this.breakEndTime,
        this.totalBreakTimeMinutes});

  AttendanceBreakHistory.fromJson(Map<String, dynamic> json) {
    breakHistoryId = json['break_history_id'];
    breakTypeName = json['break_type_name'];
    breakStartDate = json['break_start_date'];
    breakEndDate = json['break_end_date'];
    breakStartTime = json['break_start_time'];
    breakEndTime = json['break_end_time'];
    totalBreakTimeMinutes = json['total_break_time_minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['break_history_id'] = breakHistoryId;
    data['break_type_name'] = breakTypeName;
    data['break_start_date'] = breakStartDate;
    data['break_end_date'] = breakEndDate;
    data['break_start_time'] = breakStartTime;
    data['break_end_time'] = breakEndTime;
    data['total_break_time_minutes'] = totalBreakTimeMinutes;
    return data;
  }
}
