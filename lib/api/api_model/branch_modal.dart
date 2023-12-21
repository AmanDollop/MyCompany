class BranchModal {
  String? message;
  List<BranchList>? data;

  BranchModal({this.message, this.data});

  BranchModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <BranchList>[];
      json['data'].forEach((v) {
        data!.add(BranchList.fromJson(v));
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

class BranchList {
  String? branchName;
  String? branchId;

  BranchList({this.branchName, this.branchId});

  BranchList.fromJson(Map<String, dynamic> json) {
    branchName = json['branch_name'];
    branchId = json['branch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch_name'] = branchName;
    data['branch_id'] = branchId;
    return data;
  }
}
