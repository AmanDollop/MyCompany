class DocumentModal {
  String? message;
  List<GetDocumentDetails>? getDocumentDetails;

  DocumentModal({this.message, this.getDocumentDetails});

  DocumentModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['getDocumentDetails'] != null) {
      getDocumentDetails = <GetDocumentDetails>[];
      json['getDocumentDetails'].forEach((v) {
        getDocumentDetails!.add(GetDocumentDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (getDocumentDetails != null) {
      data['getDocumentDetails'] =
          getDocumentDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetDocumentDetails {
  String? documentId;
  String? documentName;
  String? documentFile;
  String? createdByName;
  String? createdDate;
  String? remark;

  GetDocumentDetails(
      {this.documentId,
        this.documentName,
        this.documentFile,
        this.createdByName,
        this.createdDate,
        this.remark});

  GetDocumentDetails.fromJson(Map<String, dynamic> json) {
    documentId = json['document_id'];
    documentName = json['document_name'];
    documentFile = json['document_file'];
    createdByName = json['created_by_name'];
    createdDate = json['created_date'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['document_id'] = documentId;
    data['document_name'] = documentName;
    data['document_file'] = documentFile;
    data['created_by_name'] = createdByName;
    data['created_date'] = createdDate;
    data['remark'] = remark;
    return data;
  }
}
