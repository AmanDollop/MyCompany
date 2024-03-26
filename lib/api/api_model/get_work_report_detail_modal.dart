class GetWorkReportDetailModal {
  String? message;
  WorkReportDetail? workReportDetail;

  GetWorkReportDetailModal({this.message, this.workReportDetail});

  GetWorkReportDetailModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    workReportDetail = json['work_report_detail'] != null
        ? WorkReportDetail.fromJson(json['work_report_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (workReportDetail != null) {
      data['work_report_detail'] = workReportDetail!.toJson();
    }
    return data;
  }
}

class WorkReportDetail {
  String? workReportDate;
  String? workReportType;
  String? workReport;
  String? createdDate;
  List<String>? workReportFile;
  List<WorkReportQueAns>? workReportQueAns;

  WorkReportDetail(
      {this.workReportDate,
        this.workReportType,
        this.workReport,
        this.createdDate,
        this.workReportFile,
        this.workReportQueAns});

  WorkReportDetail.fromJson(Map<String, dynamic> json) {
    workReportDate = json['work_report_date'];
    workReportType = json['work_report_type'];
    workReport = json['work_report'];
    createdDate = json['created_date'];
    workReportFile = json['work_report_file'].cast<String>();
    if (json['work_report_que_ans'] != null) {
      workReportQueAns = <WorkReportQueAns>[];
      json['work_report_que_ans'].forEach((v) {
        workReportQueAns!.add(new WorkReportQueAns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['work_report_date'] = workReportDate;
    data['work_report_type'] = workReportType;
    data['work_report'] = workReport;
    data['created_date'] = createdDate;
    data['work_report_file'] = workReportFile;
    if (workReportQueAns != null) {
      data['work_report_que_ans'] =
          workReportQueAns!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkReportQueAns {
  TemplateQuestions? templateQuestions;
  List<String>? templateAnswer;

  WorkReportQueAns({this.templateQuestions, this.templateAnswer});

  WorkReportQueAns.fromJson(Map<String, dynamic> json) {
    templateQuestions = json['template_question'] != null
        ? TemplateQuestions.fromJson(json['template_question'])
        : null;
    templateAnswer = json['template_answer'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (templateQuestions != null) {
      data['template_question'] = templateQuestions!.toJson();
    }
    data['template_answer'] = templateAnswer;
    return data;
  }
}

class TemplateQuestions {
  String? templateQuestion;
  String? templateQuestionType;
  String? isTemplateQuestionRequired;
  List<String>? templateQuestionValue;

  TemplateQuestions(
      {this.templateQuestion,
        this.templateQuestionType,
        this.isTemplateQuestionRequired,
        this.templateQuestionValue});

  TemplateQuestions.fromJson(Map<String, dynamic> json) {
    templateQuestion = json['template_question'];
    templateQuestionType = json['template_question_type'];
    isTemplateQuestionRequired = json['is_template_question_required'];
    templateQuestionValue = json['template_question_value'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['template_question'] = templateQuestion;
    data['template_question_type'] = templateQuestionType;
    data['is_template_question_required'] = isTemplateQuestionRequired;
    data['template_question_value'] = templateQuestionValue;
    return data;
  }
}
