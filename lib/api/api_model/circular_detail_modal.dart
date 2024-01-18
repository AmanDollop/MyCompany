class CircularDetailModal {
  String? message;
  List<Circular>? circular;

  CircularDetailModal({this.message, this.circular});

  CircularDetailModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['circular'] != null) {
      circular = <Circular>[];
      json['circular'].forEach((v) {
        circular!.add(Circular.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (circular != null) {
      data['circular'] = circular!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Circular {
  String? circularId;
  String? title;
  String? description;
  String? attachment;
  String? createdByName;
  String? createdDate;

  Circular(
      {this.circularId,
        this.title,
        this.description,
        this.attachment,
        this.createdByName,
        this.createdDate});

  Circular.fromJson(Map<String, dynamic> json) {
    circularId = json['circular_id '];
    title = json['title'];
    description = json['description'];
    attachment = json['attachment'];
    createdByName = json['created_by_name'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['circular_id '] = circularId;
    data['title'] = title;
    data['description'] = description;
    data['attachment'] = attachment;
    data['created_by_name'] = createdByName;
    data['created_date'] = createdDate;
    return data;
  }
}
