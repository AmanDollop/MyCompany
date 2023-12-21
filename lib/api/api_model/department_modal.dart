class DepartmentModal {
  String? message;
  List<DepartmentList>? data;

  DepartmentModal({this.message, this.data});

  DepartmentModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <DepartmentList>[];
      json['data'].forEach((v) {
        data!.add(DepartmentList.fromJson(v));
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

class DepartmentList {
  String? departmentName;
  String? departmentId;

  DepartmentList({this.departmentName, this.departmentId});

  DepartmentList.fromJson(Map<String, dynamic> json) {
    departmentName = json['department_name'];
    departmentId = json['department_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['department_name'] = departmentName;
    data['department_id'] = departmentId;
    return data;
  }
}
