class GetPenaltyModal {
  String? message;
  List<Penalty>? penalty;

  GetPenaltyModal({this.message, this.penalty});

  GetPenaltyModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['penalty'] != null) {
      penalty = <Penalty>[];
      json['penalty'].forEach((v) {
        penalty!.add(Penalty.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (penalty != null) {
      data['penalty'] = penalty!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Penalty {
  String? penaltyDate;
  String? penaltyDescription;
  String? paidStatus;
  String? paidStatusView;
  String? penaltyAmount;
  String? penaltyPercentage;
  List<String>? penaltyAttachment;

  Penalty(
      {this.penaltyDate,
        this.penaltyDescription,
        this.paidStatus,
        this.paidStatusView,
        this.penaltyAmount,
        this.penaltyPercentage,
        this.penaltyAttachment});

  Penalty.fromJson(Map<String, dynamic> json) {
    penaltyDate = json['penalty_date'];
    penaltyDescription = json['penalty_description'];
    paidStatus = json['paid_status'];
    paidStatusView = json['paid_status_view'];
    penaltyAmount = json['penalty_amount'];
    penaltyPercentage = json['penalty_percentage'];
    penaltyAttachment = json['penalty_attachment'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['penalty_date'] = penaltyDate;
    data['penalty_description'] = penaltyDescription;
    data['paid_status'] = paidStatus;
    data['paid_status_view'] = paidStatusView;
    data['penalty_amount'] = penaltyAmount;
    data['penalty_percentage'] = penaltyPercentage;
    data['penalty_attachment'] = penaltyAttachment;
    return data;
  }
}
