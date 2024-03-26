class GetWorkReportModal {
  String? message;
  bool? isAssign;
  List<WorkReport>? workReport;

  GetWorkReportModal({this.message, this.isAssign, this.workReport});

  GetWorkReportModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isAssign = json['is_assign'];
    if (json['work_report'] != null) {
      workReport = <WorkReport>[];
      json['work_report'].forEach((v) {
        workReport!.add(WorkReport.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['is_assign'] = isAssign;
    if (workReport != null) {
      data['work_report'] = workReport!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkReport {
  String? workReportId;
  String? workReportDate;
  String? workReportType;
  String? workReport;
  String? createdDate;

  WorkReport(
      {this.workReportId,
        this.workReportDate,
        this.workReportType,
        this.workReport,
        this.createdDate});

  WorkReport.fromJson(Map<String, dynamic> json) {
    workReportId = json['work_report_id'];
    workReportDate = json['work_report_date'];
    workReportType = json['work_report_type'];
    workReport = json['work_report'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['work_report_id'] = workReportId;
    data['work_report_date'] = workReportDate;
    data['work_report_type'] = workReportType;
    data['work_report'] = workReport;
    data['created_date'] = createdDate;
    return data;
  }
}
