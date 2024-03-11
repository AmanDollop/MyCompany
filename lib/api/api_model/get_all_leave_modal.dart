class GetAllLeaveModal {
  String? message;
  List<GetLeave>? getLeave;

  GetAllLeaveModal({this.message, this.getLeave});

  GetAllLeaveModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['getLeave'] != null) {
      getLeave = <GetLeave>[];
      json['getLeave'].forEach((v) {
        getLeave!.add(GetLeave.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (getLeave != null) {
      data['getLeave'] = getLeave!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetLeave {
  String? leaveId;
  String? leaveTypeName;
  String? leaveDayType;
  String? leaveDayTypeView;
  String? leaveDayTypeSession;
  String? leaveDayTypeSessionView;
  String? leaveStartDate;
  String? leaveStatus;
  String? isPaid;
  String? isPaidView;

  GetLeave(
      {this.leaveId,
        this.leaveTypeName,
        this.leaveDayType,
        this.leaveDayTypeView,
        this.leaveDayTypeSession,
        this.leaveDayTypeSessionView,
        this.leaveStartDate,
        this.leaveStatus,
        this.isPaid,
        this.isPaidView});

  GetLeave.fromJson(Map<String, dynamic> json) {
    leaveId = json['leave_id'];
    leaveTypeName = json['leave_type_name'];
    leaveDayType = json['leave_day_type'];
    leaveDayTypeView = json['leave_day_type_view'];
    leaveDayTypeSession = json['leave_day_type_session'];
    leaveDayTypeSessionView = json['leave_day_type_session_view'];
    leaveStartDate = json['leave_start_date'];
    leaveStatus = json['leave_status'];
    isPaid = json['is_paid'];
    isPaidView = json['is_paid_view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leave_id'] = leaveId;
    data['leave_type_name'] = leaveTypeName;
    data['leave_day_type'] = leaveDayType;
    data['leave_day_type_view'] = leaveDayTypeView;
    data['leave_day_type_session'] = leaveDayTypeSession;
    data['leave_day_type_session_view'] = leaveDayTypeSessionView;
    data['leave_start_date'] = leaveStartDate;
    data['leave_status'] = leaveStatus;
    data['is_paid'] = isPaid;
    data['is_paid_view'] = isPaidView;
    return data;
  }
}
