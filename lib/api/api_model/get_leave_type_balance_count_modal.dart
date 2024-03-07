class GetLeaveTypeBalanceCountModal {
  String? message;
  String? isUsedLeave;
  String? isTotalLeave;
  List<LeaveBalanceCountList>? leaveBalanceCountList;

  GetLeaveTypeBalanceCountModal(
      {this.message,
        this.isUsedLeave,
        this.isTotalLeave,
        this.leaveBalanceCountList});

  GetLeaveTypeBalanceCountModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isUsedLeave = json['is_used_leave'];
    isTotalLeave = json['is_total_leave'];
    if (json['leaveBalanceCountList'] != null) {
      leaveBalanceCountList = <LeaveBalanceCountList>[];
      json['leaveBalanceCountList'].forEach((v) {
        leaveBalanceCountList!.add(LeaveBalanceCountList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['is_used_leave'] = isUsedLeave;
    data['is_total_leave'] = isTotalLeave;
    if (leaveBalanceCountList != null) {
      data['leaveBalanceCountList'] =
          leaveBalanceCountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveBalanceCountList {
  String? leaveTypeId;
  String? leaveTypeName;
  String? totalLeave;
  String? totalUsedLeave;
  String? totalRemainingLeave;
  String? remainingLeaveMonth;

  LeaveBalanceCountList(
      {this.leaveTypeId,
        this.leaveTypeName,
        this.totalLeave,
        this.totalUsedLeave,
        this.totalRemainingLeave,
        this.remainingLeaveMonth});

  LeaveBalanceCountList.fromJson(Map<String, dynamic> json) {
    leaveTypeId = json['leave_type_id'];
    leaveTypeName = json['leave_type_name'];
    totalLeave = json['total_leave'];
    totalUsedLeave = json['total_used_leave'];
    totalRemainingLeave = json['total_remaining_leave'];
    remainingLeaveMonth = json['remaining_leave_month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leave_type_id'] = leaveTypeId;
    data['leave_type_name'] = leaveTypeName;
    data['total_leave'] = totalLeave;
    data['total_used_leave'] = totalUsedLeave;
    data['total_remaining_leave'] = totalRemainingLeave;
    data['remaining_leave_month'] = remainingLeaveMonth;
    return data;
  }
}
