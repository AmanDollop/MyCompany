class GetAssignTemplateModal {
  String? message;
  List<TemplateAssign>? templateAssign;

  GetAssignTemplateModal({this.message, this.templateAssign});

  GetAssignTemplateModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['template_assign'] != null) {
      templateAssign = <TemplateAssign>[];
      json['template_assign'].forEach((v) {
        templateAssign!.add(TemplateAssign.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (templateAssign != null) {
      data['template_assign'] = templateAssign!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TemplateAssign {
  String? templateId;
  String? templateAssignIds;
  String? templateName;
  String? templateDescription;
  String? isTemplateRequired;
  String? allowMultipleTime;
  String? templateType;
  bool? isSubmitted;

  TemplateAssign(
      {this.templateId,
        this.templateAssignIds,
        this.templateName,
        this.templateDescription,
        this.isTemplateRequired,
        this.allowMultipleTime,
        this.templateType,
        this.isSubmitted});

  TemplateAssign.fromJson(Map<String, dynamic> json) {
    templateId = json['template_id'];
    templateAssignIds = json['template_assign_ids'];
    templateName = json['template_name'];
    templateDescription = json['template_description'];
    isTemplateRequired = json['is_template_required'];
    allowMultipleTime = json['allow_multiple_time'];
    templateType = json['template_type'];
    isSubmitted = json['is_submitted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['template_id'] = templateId;
    data['template_assign_ids'] = templateAssignIds;
    data['template_name'] = templateName;
    data['template_description'] = templateDescription;
    data['is_template_required'] = isTemplateRequired;
    data['allow_multiple_time'] = allowMultipleTime;
    data['template_type'] = templateType;
    data['is_submitted'] = isSubmitted;
    return data;
  }
}
