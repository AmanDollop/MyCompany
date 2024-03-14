class GetWorkReportDetailModal {
  String? message;
  WorkDetails? workDetails;

  GetWorkReportDetailModal({this.message, this.workDetails});

  GetWorkReportDetailModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    workDetails = json['work_details'] != null
        ? WorkDetails.fromJson(json['work_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (workDetails != null) {
      data['work_details'] = workDetails!.toJson();
    }
    return data;
  }
}

class WorkDetails {
  String? workReportDate;
  String? workReportType;
  String? workReportDateView;
  String? workReport;
  List<String>? workReportFile;

  WorkDetails(
      {this.workReportDate,
        this.workReportType,
        this.workReportDateView,
        this.workReport,
        this.workReportFile});

  WorkDetails.fromJson(Map<String, dynamic> json) {
    workReportDate = json['work_report_date'];
    workReportType = json['work_report_type'];
    workReportDateView = json['work_report_date_view'];
    workReport = json['work_report'];
    workReportFile = json['work_report_file'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['work_report_date'] = workReportDate;
    data['work_report_type'] = workReportType;
    data['work_report_date_view'] = workReportDateView;
    data['work_report'] = workReport;
    data['work_report_file'] = workReportFile;
    return data;
  }
}
