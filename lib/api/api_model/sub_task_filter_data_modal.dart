class SubTaskFilterDataModal {
  String? message;
  List<TaskStatus>? taskStatus;

  SubTaskFilterDataModal({this.message, this.taskStatus});

  SubTaskFilterDataModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['task_status'] != null) {
      taskStatus = <TaskStatus>[];
      json['task_status'].forEach((v) {
        taskStatus!.add(TaskStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (taskStatus != null) {
      data['task_status'] = taskStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskStatus {
  String? taskStatusName;
  String? taskStatusColor;
  String? taskActualStatus;

  TaskStatus(
      {this.taskStatusName, this.taskStatusColor, this.taskActualStatus});

  TaskStatus.fromJson(Map<String, dynamic> json) {
    taskStatusName = json['task_status_name'];
    taskStatusColor = json['task_status_color'];
    taskActualStatus = json['task_actual_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_status_name'] = taskStatusName;
    data['task_status_color'] = taskStatusColor;
    data['task_actual_status'] = taskActualStatus;
    return data;
  }
}
