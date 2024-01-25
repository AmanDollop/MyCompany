class GetTodayAttendanceModal {
  String? message;
  GetTodayAttendance? getTodayAttendance;

  GetTodayAttendanceModal({this.message, this.getTodayAttendance});

  GetTodayAttendanceModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    getTodayAttendance = json['getTodayAttendance'] != null
        ? GetTodayAttendance.fromJson(json['getTodayAttendance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (getTodayAttendance != null) {
      data['getTodayAttendance'] = getTodayAttendance!.toJson();
    }
    return data;
  }
}

class GetTodayAttendance {
  String? branchGeofenceLatitude;
  String? branchGeofenceLongitude;
  String? branchGeofenceRange;
  bool? isPunchIn;
  String? punchInTime;
  String? punchInDate;
  bool? isPunchOut;
  String? punchOutTime;
  String? punchOutDate;
  String? totalWorkingMinutes;
  bool? isBreak;
  String? breakTypeName;
  String? breakStartTime;
  String? attendanceId;
  String? breakHistoryId;

  GetTodayAttendance(
      {this.branchGeofenceLatitude,
        this.branchGeofenceLongitude,
        this.branchGeofenceRange,
        this.isPunchIn,
        this.punchInTime,
        this.punchInDate,
        this.isPunchOut,
        this.punchOutTime,
        this.punchOutDate,
        this.totalWorkingMinutes,
        this.isBreak,
        this.breakTypeName,
        this.breakStartTime,
        this.attendanceId,
        this.breakHistoryId,
      });

  GetTodayAttendance.fromJson(Map<String, dynamic> json) {
    branchGeofenceLatitude = json['branch_geofence_latitude'];
    branchGeofenceLongitude = json['branch_geofence_longitude'];
    branchGeofenceRange = json['branch_geofence_range'];
    isPunchIn = json['is_punch_in'];
    punchInTime = json['punch_in_time'];
    punchInDate = json['punch_in_date'];
    isPunchOut = json['is_punch_out'];
    punchOutTime = json['punch_out_time'];
    punchOutDate = json['punch_out_date'];
    totalWorkingMinutes = json['total_working_minutes'];
    isBreak = json['is_break'];
    breakTypeName = json['break_type_name'];
    breakStartTime = json['break_start_time'];
    attendanceId = json['attendance_id'];
    breakHistoryId = json['break_history_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch_geofence_latitude'] = branchGeofenceLatitude;
    data['branch_geofence_longitude'] = branchGeofenceLongitude;
    data['branch_geofence_range'] = branchGeofenceRange;
    data['is_punch_in'] = isPunchIn;
    data['punch_in_time'] = punchInTime;
    data['punch_in_date'] = punchInDate;
    data['is_punch_out'] = isPunchOut;
    data['punch_out_time'] = punchOutTime;
    data['punch_out_date'] = punchOutDate;
    data['total_working_minutes'] = totalWorkingMinutes;
    data['is_break'] = isBreak;
    data['break_type_name'] = breakTypeName;
    data['break_start_time'] = breakStartTime;
    data['attendance_id'] = attendanceId;
    data['break_history_id'] = breakHistoryId;
    return data;
  }
}
