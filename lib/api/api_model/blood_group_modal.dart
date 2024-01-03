class BloodGroupModal {
  String? message;
  String? bloodGroup;

  BloodGroupModal({this.message, this.bloodGroup});

  BloodGroupModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    bloodGroup = json['blood_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['blood_group'] = bloodGroup;
    return data;
  }
}
