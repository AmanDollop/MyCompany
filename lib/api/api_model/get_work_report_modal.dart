class GetWorkReportModal {
  String? message;
  List<WorkReport>? workReport;

  GetWorkReportModal({this.message, this.workReport});

  GetWorkReportModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
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
  List<String>? workReportFile;

  WorkReport(
      {this.workReportDate,
        this.workReportId,
        this.workReportType,
        this.workReport,
        this.workReportFile});

  WorkReport.fromJson(Map<String, dynamic> json) {
    workReportId = json['work_report_id'];
    workReportDate = json['work_report_date'];
    workReportType = json['work_report_type'];
    workReport = json['work_report'];
    workReportFile = json['work_report_file'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['work_report_id'] = workReportId;
    data['work_report_date'] = workReportDate;
    data['work_report_type'] = workReportType;
    data['work_report'] = workReport;
    data['work_report_file'] = workReportFile;
    return data;
  }
}
