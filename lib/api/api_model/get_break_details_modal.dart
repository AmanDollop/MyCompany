class GetBreakDetailsModal {
  String? message;
  List<GetBreakDetails>? getBreakDetails;

  GetBreakDetailsModal({this.message, this.getBreakDetails});

  GetBreakDetailsModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['getBreakDetails'] != null) {
      getBreakDetails = <GetBreakDetails>[];
      json['getBreakDetails'].forEach((v) {
        getBreakDetails!.add(GetBreakDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (getBreakDetails != null) {
      data['getBreakDetails'] =
          getBreakDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetBreakDetails {
  String? breakTypeId;
  String? breakTypeName;

  GetBreakDetails({this.breakTypeId, this.breakTypeName});

  GetBreakDetails.fromJson(Map<String, dynamic> json) {
    breakTypeId = json['break_type_id'];
    breakTypeName = json['break_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['break_type_id'] = breakTypeId;
    data['break_type_name'] = breakTypeName;
    return data;
  }
}
