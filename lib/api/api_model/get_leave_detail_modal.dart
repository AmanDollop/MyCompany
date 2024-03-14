class GetLeaveDetailModal {
  String? message;
  LeaveDetails? leaveDetails;

  GetLeaveDetailModal({this.message, this.leaveDetails});

  GetLeaveDetailModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    leaveDetails = json['leave_details'] != null
        ? LeaveDetails.fromJson(json['leave_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (leaveDetails != null) {
      data['leave_details'] = leaveDetails!.toJson();
    }
    return data;
  }
}

class LeaveDetails {
  String? leaveTypeId;
  String? leaveTypeName;
  String? leaveDayType;
  String? leaveDayTypeView;
  String? leaveDayTypeSession;
  String? leaveDayTypeSessionView;
  String? leaveStartDate;
  String? leaveStatus;
  String? isPaid;
  String? isPaidView;
  bool? isEdit;
  bool? isDelete;
  String? leaveReason;
  String? leaveAttachment;
  String? leaveAddedByType;
  String? shortName;

  LeaveDetails(
      {this.leaveTypeId,
        this.leaveTypeName,
        this.leaveDayType,
        this.leaveDayTypeView,
        this.leaveDayTypeSession,
        this.leaveDayTypeSessionView,
        this.leaveStartDate,
        this.leaveStatus,
        this.isPaid,
        this.isPaidView,
        this.isEdit,
        this.isDelete,
        this.leaveReason,
        this.leaveAttachment,
        this.leaveAddedByType,
        this.shortName});

  LeaveDetails.fromJson(Map<String, dynamic> json) {
    leaveTypeId = json['leave_type_id'];
    leaveTypeName = json['leave_type_name'];
    leaveDayType = json['leave_day_type'];
    leaveDayTypeView = json['leave_day_type_view'];
    leaveDayTypeSession = json['leave_day_type_session'];
    leaveDayTypeSessionView = json['leave_day_type_session_view'];
    leaveStartDate = json['leave_start_date'];
    leaveStatus = json['leave_status'];
    isPaid = json['is_paid'];
    isPaidView = json['is_paid_view'];
    isEdit = json['is_edit'];
    isDelete = json['is_delete'];
    leaveReason = json['leave_reason'];
    leaveAttachment = json['leave_attachment'];
    leaveAddedByType = json['leave_added_by_type'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leave_type_id'] = leaveTypeId;
    data['leave_type_name'] = leaveTypeName;
    data['leave_day_type'] = leaveDayType;
    data['leave_day_type_view'] = leaveDayTypeView;
    data['leave_day_type_session'] = leaveDayTypeSession;
    data['leave_day_type_session_view'] = leaveDayTypeSessionView;
    data['leave_start_date'] = leaveStartDate;
    data['leave_status'] = leaveStatus;
    data['is_paid'] = isPaid;
    data['is_paid_view'] = isPaidView;
    data['is_edit'] = isEdit;
    data['is_delete'] = isDelete;
    data['leave_reason'] = leaveReason;
    data['leave_attachment'] = leaveAttachment;
    data['leave_added_by_type'] = leaveAddedByType;
    data['short_name'] = shortName;
    return data;
  }
}
