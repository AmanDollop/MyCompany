class BankDetailModal {
  String? message;
  List<GetBankDetails>? getBankDetails;

  BankDetailModal({this.message, this.getBankDetails});

  BankDetailModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['getBankDetails'] != null) {
      getBankDetails = <GetBankDetails>[];
      json['getBankDetails'].forEach((v) {
        getBankDetails!.add(GetBankDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (getBankDetails != null) {
      data['getBankDetails'] =
          getBankDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetBankDetails {
  String? bankId;
  String? accountHoldersName;
  String? bankName;
  String? bankBranchName;
  String? accountType;
  String? accountNo;
  String? ifscCode;
  String? crnNo;
  String? panCardNo;
  String? esicNo;
  String? pfNo;
  String? isPrimary;

  GetBankDetails(
      {this.bankId,
        this.accountHoldersName,
        this.bankName,
        this.bankBranchName,
        this.accountType,
        this.accountNo,
        this.ifscCode,
        this.crnNo,
        this.panCardNo,
        this.esicNo,
        this.pfNo,
        this.isPrimary});

  GetBankDetails.fromJson(Map<String, dynamic> json) {
    bankId = json['bank_id'];
    accountHoldersName = json['account_holders_name'];
    bankName = json['bank_name'];
    bankBranchName = json['bank_branch_name'];
    accountType = json['account_type'];
    accountNo = json['account_no'];
    ifscCode = json['ifsc_code'];
    crnNo = json['crn_no'];
    panCardNo = json['pan_card_no'];
    esicNo = json['esic_no'];
    pfNo = json['pf_no'];
    isPrimary = json['is_primary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_id'] = bankId;
    data['account_holders_name'] = accountHoldersName;
    data['bank_name'] = bankName;
    data['bank_branch_name'] = bankBranchName;
    data['account_type'] = accountType;
    data['account_no'] = accountNo;
    data['ifsc_code'] = ifscCode;
    data['crn_no'] = crnNo;
    data['pan_card_no'] = panCardNo;
    data['esic_no'] = esicNo;
    data['pf_no'] = pfNo;
    data['is_primary'] = isPrimary;
    return data;
  }
}
