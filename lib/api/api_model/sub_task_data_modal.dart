class SubTaskDataModal {
  String? message;
  List<TaskDetails>? taskDetails;

  SubTaskDataModal({this.message, this.taskDetails});

  SubTaskDataModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['taskDetails'] != null) {
      taskDetails = <TaskDetails>[];
      json['taskDetails'].forEach((v) {
        taskDetails!.add(TaskDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (taskDetails != null) {
      data['taskDetails'] = taskDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskDetails {
  String? taskId;
  String? taskName;
  String? taskNote;
  String? createdDate;
  String? taskStartDate;
  String? taskDueDate;
  String? taskDueTime;
  String? taskPriority;
  String? taskStatus;
  String? taskStatusName;
  String? taskStatusColor;
  String? taskAttachment;
  bool? isEditAllow;
  bool? isDeleteAllow;
  bool? hasSubTask;
  String? subTaskPercentage;
  String? isSelfAddedTask;
  String? userName;
  String? userProfile;
  String? shortName;

  TaskDetails(
      {this.taskId,
        this.taskName,
        this.taskNote,
        this.createdDate,
        this.taskStartDate,
        this.taskDueDate,
        this.taskDueTime,
        this.taskPriority,
        this.taskStatus,
        this.taskStatusName,
        this.taskStatusColor,
        this.taskAttachment,
        this.isEditAllow,
        this.isDeleteAllow,
        this.hasSubTask,
        this.subTaskPercentage,
        this.isSelfAddedTask,
        this.userName,
        this.userProfile,
        this.shortName});

  TaskDetails.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskName = json['task_name'];
    taskNote = json['task_note'];
    createdDate = json['created_date'];
    taskStartDate = json['task_start_date'];
    taskDueDate = json['task_due_date'];
    taskDueTime = json['task_due_time'];
    taskPriority = json['task_priority'];
    taskStatus = json['task_status'];
    taskStatusName = json['task_status_name'];
    taskStatusColor = json['task_status_color'];
    taskAttachment = json['task_attachment'];
    isEditAllow = json['is_edit_allow'];
    isDeleteAllow = json['is_delete_allow'];
    hasSubTask = json['has_sub_task'];
    subTaskPercentage = json['sub_task_percentage'];
    isSelfAddedTask = json['is_self_added_task'];
    userName = json['user_name'];
    userProfile = json['user_profile'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_id'] = taskId;
    data['task_name'] = taskName;
    data['task_note'] = taskNote;
    data['created_date'] = createdDate;
    data['task_start_date'] = taskStartDate;
    data['task_due_date'] = taskDueDate;
    data['task_due_time'] = taskDueTime;
    data['task_priority'] = taskPriority;
    data['task_status'] = taskStatus;
    data['task_status_name'] = taskStatusName;
    data['task_status_color'] = taskStatusColor;
    data['task_attachment'] = taskAttachment;
    data['is_edit_allow'] = isEditAllow;
    data['is_delete_allow'] = isDeleteAllow;
    data['has_sub_task'] = hasSubTask;
    data['sub_task_percentage'] = subTaskPercentage;
    data['is_self_added_task'] = isSelfAddedTask;
    data['user_name'] = userName;
    data['user_profile'] = userProfile;
    data['short_name'] = shortName;
    return data;
  }
}
