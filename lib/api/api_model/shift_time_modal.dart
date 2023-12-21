class ShiftTimeModal {
  String? message;
  List<ShiftTimeList>? data;

  ShiftTimeModal({this.message, this.data});

  ShiftTimeModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ShiftTimeList>[];
      json['data'].forEach((v) {
        data!.add(ShiftTimeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShiftTimeList {
  String? shiftName;
  String? shiftId;

  ShiftTimeList({this.shiftName, this.shiftId});

  ShiftTimeList.fromJson(Map<String, dynamic> json) {
    shiftName = json['shift_name'];
    shiftId = json['shift_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shift_name'] = shiftName;
    data['shift_id'] = shiftId;
    return data;
  }
}
