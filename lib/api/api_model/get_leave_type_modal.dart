class GetLeaveTypeModal {
  String? message;
  List<LeaveType>? leaveType;

  GetLeaveTypeModal({this.message, this.leaveType});

  GetLeaveTypeModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['leaveType'] != null) {
      leaveType = <LeaveType>[];
      json['leaveType'].forEach((v) {
        leaveType!.add(LeaveType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (leaveType != null) {
      data['leaveType'] = leaveType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveType {
  String? leaveTypeId;
  String? leaveTypeName;
  String? attachmentRequired;

  LeaveType({this.leaveTypeId, this.leaveTypeName, this.attachmentRequired});

  LeaveType.fromJson(Map<String, dynamic> json) {
    leaveTypeId = json['leave_type_id'];
    leaveTypeName = json['leave_type_name'];
    attachmentRequired = json['attachment_required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leave_type_id'] = leaveTypeId;
    data['leave_type_name'] = leaveTypeName;
    data['attachment_required'] = attachmentRequired;
    return data;
  }
}
