class GetLeaveTypeBalanceModal {
  String? message;
  String? availableLeave;

  GetLeaveTypeBalanceModal({this.message, this.availableLeave});

  GetLeaveTypeBalanceModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    availableLeave = json['availableLeave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['availableLeave'] = availableLeave;
    return data;
  }
}
