class PromotionModal {
  String? message;
  List<GetPromotionDetails>? getPromotionDetails;

  PromotionModal({this.message, this.getPromotionDetails});

  PromotionModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['getPromotionDetails'] != null) {
      getPromotionDetails = <GetPromotionDetails>[];
      json['getPromotionDetails'].forEach((v) {
        getPromotionDetails!.add(GetPromotionDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (getPromotionDetails != null) {
      data['getPromotionDetails'] =
          getPromotionDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetPromotionDetails {
  String? promotionId;
  String? designation;
  String? promotionDate;
  String? remark;

  GetPromotionDetails(
      {this.promotionId, this.designation, this.promotionDate, this.remark});

  GetPromotionDetails.fromJson(Map<String, dynamic> json) {
    promotionId = json['promotion_id'];
    designation = json['designation'];
    promotionDate = json['promotion_date'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['promotion_id'] = promotionId;
    data['designation'] = designation;
    data['promotion_date'] = promotionDate;
    data['remark'] = remark;
    return data;
  }
}
