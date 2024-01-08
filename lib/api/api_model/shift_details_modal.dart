class ShiftDetailsModal {
  String? message;
  ShiftDetails? shiftDetails;

  ShiftDetailsModal({this.message, this.shiftDetails});

  ShiftDetailsModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    shiftDetails = json['shiftDetails'] != null
        ? ShiftDetails.fromJson(json['shiftDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (shiftDetails != null) {
      data['shiftDetails'] = shiftDetails!.toJson();
    }
    return data;
  }
}

class ShiftDetails {
  String? shiftName;
  String? shiftCode;
  String? weekOffDays;
  String? weekOffDaysView;
  String? hasAlternateWeekOff;
  String? alternateWeekOff;
  String? alternateWeekOffView;
  String? alternateWeekOffDays;
  String? alternateWeekOffDaysView;
  String? maxLateInMonth;
  String? maxEarlyOutMonth;
  String? lateInReasonRequired;
  String? earlyOutReasonRequired;
  String? outOfRangeReasonRequired;
  List<ShiftTime>? shiftTime;

  ShiftDetails(
      {this.shiftName,
        this.shiftCode,
        this.weekOffDays,
        this.weekOffDaysView,
        this.hasAlternateWeekOff,
        this.alternateWeekOff,
        this.alternateWeekOffView,
        this.alternateWeekOffDays,
        this.alternateWeekOffDaysView,
        this.maxLateInMonth,
        this.maxEarlyOutMonth,
        this.lateInReasonRequired,
        this.earlyOutReasonRequired,
        this.outOfRangeReasonRequired,
        this.shiftTime});

  ShiftDetails.fromJson(Map<String, dynamic> json) {
    shiftName = json['shift_name'];
    shiftCode = json['shift_code'];
    weekOffDays = json['week_off_days'];
    weekOffDaysView = json['week_off_days_view'];
    hasAlternateWeekOff = json['has_alternate_week_off'];
    alternateWeekOff = json['alternate_week_off'];
    alternateWeekOffView = json['alternate_week_off_view'];
    alternateWeekOffDays = json['alternate_week_off_days'];
    alternateWeekOffDaysView = json['alternate_week_off_days_view'];
    maxLateInMonth = json['max_late_in_month'];
    maxEarlyOutMonth = json['max_early_out_month'];
    lateInReasonRequired = json['late_in_reason_required'];
    earlyOutReasonRequired = json['early_out_reason_required'];
    outOfRangeReasonRequired = json['out_of_range_reason_required'];
    if (json['shiftTime'] != null) {
      shiftTime = <ShiftTime>[];
      json['shiftTime'].forEach((v) {
        shiftTime!.add(ShiftTime.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shift_name'] = shiftName;
    data['shift_code'] = shiftCode;
    data['week_off_days'] = weekOffDays;
    data['week_off_days_view'] = weekOffDaysView;
    data['has_alternate_week_off'] = hasAlternateWeekOff;
    data['alternate_week_off'] = alternateWeekOff;
    data['alternate_week_off_view'] = alternateWeekOffView;
    data['alternate_week_off_days'] = alternateWeekOffDays;
    data['alternate_week_off_days_view'] = alternateWeekOffDaysView;
    data['max_late_in_month'] = maxLateInMonth;
    data['max_early_out_month'] = maxEarlyOutMonth;
    data['late_in_reason_required'] = lateInReasonRequired;
    data['early_out_reason_required'] = earlyOutReasonRequired;
    data['out_of_range_reason_required'] = outOfRangeReasonRequired;
    if (shiftTime != null) {
      data['shiftTime'] = shiftTime!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShiftTime {
  String? shiftDay;
  String? shiftDayName;
  String? shiftStartTime;
  String? shiftEndTime;
  String? totalShiftMinutes;
  String? lunchBreakStartTime;
  String? lunchBreakEndTime;
  String? teaBreakStartTime;
  String? teaBreakEndTime;
  String? secondTeaBreakStartTime;
  String? secondTeaBreakEndTime;
  String? dinnerBreakStartTime;
  String? dinnerBreakEndTime;
  String? halfDayAfterTime;
  String? halfDayBeforeTime;
  String? lateInMinutes;
  String? earlyOutMinutes;
  String? minHalfHours;
  String? minFullDayHours;
  String? shiftType;

  ShiftTime(
      {this.shiftDay,
        this.shiftDayName,
        this.shiftStartTime,
        this.shiftEndTime,
        this.totalShiftMinutes,
        this.lunchBreakStartTime,
        this.lunchBreakEndTime,
        this.teaBreakStartTime,
        this.teaBreakEndTime,
        this.secondTeaBreakStartTime,
        this.secondTeaBreakEndTime,
        this.dinnerBreakStartTime,
        this.dinnerBreakEndTime,
        this.halfDayAfterTime,
        this.halfDayBeforeTime,
        this.lateInMinutes,
        this.earlyOutMinutes,
        this.minHalfHours,
        this.minFullDayHours,
        this.shiftType});

  ShiftTime.fromJson(Map<String, dynamic> json) {
    shiftDay = json['shift_day'];
    shiftDayName = json['shift_day_name'];
    shiftStartTime = json['shift_start_time'];
    shiftEndTime = json['shift_end_time'];
    totalShiftMinutes = json['total_shift_minutes'];
    lunchBreakStartTime = json['lunch_break_start_time'];
    lunchBreakEndTime = json['lunch_break_end_time'];
    teaBreakStartTime = json['tea_break_start_time'];
    teaBreakEndTime = json['tea_break_end_time'];
    secondTeaBreakStartTime = json['second_tea_break_start_time'];
    secondTeaBreakEndTime = json['second_tea_break_end_time'];
    dinnerBreakStartTime = json['dinner_break_start_time'];
    dinnerBreakEndTime = json['dinner_break_end_time'];
    halfDayAfterTime = json['half_day_after_time'];
    halfDayBeforeTime = json['half_day_before_time'];
    lateInMinutes = json['late_in_minutes'];
    earlyOutMinutes = json['early_out_minutes'];
    minHalfHours = json['min_half_hours'];
    minFullDayHours = json['min_full_day_hours'];
    shiftType = json['shift_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shift_day'] = shiftDay;
    data['shift_day_name'] = shiftDayName;
    data['shift_start_time'] = shiftStartTime;
    data['shift_end_time'] = shiftEndTime;
    data['total_shift_minutes'] = totalShiftMinutes;
    data['lunch_break_start_time'] = lunchBreakStartTime;
    data['lunch_break_end_time'] = lunchBreakEndTime;
    data['tea_break_start_time'] = teaBreakStartTime;
    data['tea_break_end_time'] = teaBreakEndTime;
    data['second_tea_break_start_time'] = secondTeaBreakStartTime;
    data['second_tea_break_end_time'] = secondTeaBreakEndTime;
    data['dinner_break_start_time'] = dinnerBreakStartTime;
    data['dinner_break_end_time'] = dinnerBreakEndTime;
    data['half_day_after_time'] = halfDayAfterTime;
    data['half_day_before_time'] = halfDayBeforeTime;
    data['late_in_minutes'] = lateInMinutes;
    data['early_out_minutes'] = earlyOutMinutes;
    data['min_half_hours'] = minHalfHours;
    data['min_full_day_hours'] = minFullDayHours;
    data['shift_type'] = shiftType;
    return data;
  }
}
