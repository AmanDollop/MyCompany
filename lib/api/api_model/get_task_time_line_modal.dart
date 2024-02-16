class GetTaskTimeLineModal {
  String? message;
  String? timelineMsg;
  bool? isTaskTimeLineActive;
  List<TimeLine>? timeLine;

  GetTaskTimeLineModal(
      {this.message, this.timelineMsg, this.isTaskTimeLineActive, this.timeLine});

  GetTaskTimeLineModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    timelineMsg = json['timelineMsg'];
    isTaskTimeLineActive = json['isTaskTimeLineActive'];
    if (json['timeLine'] != null) {
      timeLine = <TimeLine>[];
      json['timeLine'].forEach((v) {
        timeLine!.add(TimeLine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['timelineMsg'] = timelineMsg;
    data['isTaskTimeLineActive'] = isTaskTimeLineActive;
    if (timeLine != null) {
      data['timeLine'] = timeLine!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeLine {
  String? taskTimelineId;
  String? taskId;
  String? taskTimelineStatus;
  String? taskStatusColor;
  String? taskStatusName;
  String? taskTimelineDescription;
  String? taskTimelineAttachment;
  String? taskTimelineDate;
  String? taskTimelineAddedByType;
  String? taskTimelineAddedBy;
  bool? isSender;
  String? userName;
  String? userProfile;
  String? shortName;
  bool? isDeleteAllow;

  TimeLine(
      {this.taskTimelineId,
        this.taskId,
        this.taskTimelineStatus,
        this.taskStatusColor,
        this.taskStatusName,
        this.taskTimelineDescription,
        this.taskTimelineAttachment,
        this.taskTimelineDate,
        this.taskTimelineAddedByType,
        this.taskTimelineAddedBy,
        this.isSender,
        this.userName,
        this.userProfile,
        this.shortName,
        this.isDeleteAllow});

  TimeLine.fromJson(Map<String, dynamic> json) {
    taskTimelineId = json['task_timeline_id'];
    taskId = json['task_id'];
    taskTimelineStatus = json['task_timeline_status'];
    taskStatusColor = json['task_status_color'];
    taskStatusName = json['task_status_name'];
    taskTimelineDescription = json['task_timeline_description'];
    taskTimelineAttachment = json['task_timeline_attachment'];
    taskTimelineDate = json['task_timeline_date'];
    taskTimelineAddedByType = json['task_timeline_added_by_type'];
    taskTimelineAddedBy = json['task_timeline_added_by'];
    isSender = json['isSender'];
    userName = json['user_name'];
    userProfile = json['user_profile'];
    shortName = json['short_name'];
    isDeleteAllow = json['is_delete_allow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_timeline_id'] = taskTimelineId;
    data['task_id'] = taskId;
    data['task_timeline_status'] = taskTimelineStatus;
    data['task_status_color'] = taskStatusColor;
    data['task_status_name'] = taskStatusName;
    data['task_timeline_description'] = taskTimelineDescription;
    data['task_timeline_attachment'] = taskTimelineAttachment;
    data['task_timeline_date'] = taskTimelineDate;
    data['task_timeline_added_by_type'] = taskTimelineAddedByType;
    data['task_timeline_added_by'] = taskTimelineAddedBy;
    data['isSender'] = isSender;
    data['user_name'] = userName;
    data['user_profile'] = userProfile;
    data['short_name'] = shortName;
    data['is_delete_allow'] = isDeleteAllow;
    return data;
  }
}
