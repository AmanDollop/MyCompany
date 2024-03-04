class GetLeaveDetailModal {
  String? message;
  GetLeaveDetails? getLeaveDetails;

  GetLeaveDetailModal({this.message, this.getLeaveDetails});

  GetLeaveDetailModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    getLeaveDetails = json['getLeaveDetails'] != null
        ? GetLeaveDetails.fromJson(json['getLeaveDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (getLeaveDetails != null) {
      data['getLeaveDetails'] = getLeaveDetails!.toJson();
    }
    return data;
  }
}

class GetLeaveDetails {
  String? leaveTypeName;
  String? leaveDayType;
  String? leaveDayTypeView;
  String? leaveStartDate;
  String? leaveStatus;
  String? isPaid;
  String? isPaidView;
  String? leaveReason;
  String? leaveAttachment;
  String? leaveAddedByType;
  String? shortName;

  GetLeaveDetails(
      {this.leaveTypeName,
        this.leaveDayType,
        this.leaveDayTypeView,
        this.leaveStartDate,
        this.leaveStatus,
        this.isPaid,
        this.isPaidView,
        this.leaveReason,
        this.leaveAttachment,
        this.leaveAddedByType,
        this.shortName});

  GetLeaveDetails.fromJson(Map<String, dynamic> json) {
    leaveTypeName = json['leave_type_name'];
    leaveDayType = json['leave_day_type'];
    leaveDayTypeView = json['leave_day_type_view'];
    leaveStartDate = json['leave_start_date'];
    leaveStatus = json['leave_status'];
    isPaid = json['is_paid'];
    isPaidView = json['is_paid_view'];
    leaveReason = json['leave_reason'];
    leaveAttachment = json['leave_attachment'];
    leaveAddedByType = json['leave_added_by_type'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leave_type_name'] = leaveTypeName;
    data['leave_day_type'] = leaveDayType;
    data['leave_day_type_view'] = leaveDayTypeView;
    data['leave_start_date'] = leaveStartDate;
    data['leave_status'] = leaveStatus;
    data['is_paid'] = isPaid;
    data['is_paid_view'] = isPaidView;
    data['leave_reason'] = leaveReason;
    data['leave_attachment'] = leaveAttachment;
    data['leave_added_by_type'] = leaveAddedByType;
    data['short_name'] = shortName;
    return data;
  }
}
