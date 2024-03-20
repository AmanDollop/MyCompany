class GetTemplateQuestionModal {
  String? message;
  List<TemplateQuestion>? templateQuestion;

  GetTemplateQuestionModal({this.message, this.templateQuestion});

  GetTemplateQuestionModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['template_question'] != null) {
      templateQuestion = <TemplateQuestion>[];
      json['template_question'].forEach((v) {
        templateQuestion!.add(TemplateQuestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (templateQuestion != null) {
      data['template_question'] =
          templateQuestion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TemplateQuestion {
  String? templateQuestionId;
  String? templateQuestion;
  String? templateQuestionType;
  List<String>? templateQuestionValue;
  String? isTemplateQuestionRequired;
  String? templateQuestionDropdownType;
  String? templateQuestionFileType;
  String? templateQuestionUploadType;
  String? templateQuestionMultipleFileLimit;

  TemplateQuestion(
      {this.templateQuestionId,
        this.templateQuestion,
        this.templateQuestionType,
        this.templateQuestionValue,
        this.isTemplateQuestionRequired,
        this.templateQuestionDropdownType,
        this.templateQuestionFileType,
        this.templateQuestionUploadType,
        this.templateQuestionMultipleFileLimit});

  TemplateQuestion.fromJson(Map<String, dynamic> json) {
    templateQuestionId = json['template_question_id'];
    templateQuestion = json['template_question'];
    templateQuestionType = json['template_question_type'];
    templateQuestionValue = json['template_question_value'].cast<String>();
    isTemplateQuestionRequired = json['is_template_question_required'];
    templateQuestionDropdownType = json['template_question_dropdown_type'];
    templateQuestionFileType = json['template_question_file_type'];
    templateQuestionUploadType = json['template_question_upload_type'];
    templateQuestionMultipleFileLimit =
    json['template_question_multiple_file_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['template_question_id'] = templateQuestionId;
    data['template_question'] = templateQuestion;
    data['template_question_type'] = templateQuestionType;
    data['template_question_value'] = templateQuestionValue;
    data['is_template_question_required'] = isTemplateQuestionRequired;
    data['template_question_dropdown_type'] = templateQuestionDropdownType;
    data['template_question_file_type'] = templateQuestionFileType;
    data['template_question_upload_type'] = templateQuestionUploadType;
    data['template_question_multiple_file_limit'] = templateQuestionMultipleFileLimit;
    return data;
  }
}
