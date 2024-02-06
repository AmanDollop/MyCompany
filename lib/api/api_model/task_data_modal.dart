class TaskDataModal {
  String? message;
  String? totalCompleteTask;
  String? totalDueTask;
  String? totalTodayDueTask;
  List<TaskCategory>? taskCategory;

  TaskDataModal(
      {this.message,
        this.totalCompleteTask,
        this.totalDueTask,
        this.totalTodayDueTask,
        this.taskCategory});

  TaskDataModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    totalCompleteTask = json['total_complete_task'];
    totalDueTask = json['total_due_task'];
    totalTodayDueTask = json['total_today_due_task'];
    if (json['task_category'] != null) {
      taskCategory = <TaskCategory>[];
      json['task_category'].forEach((v) {
        taskCategory!.add(TaskCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['total_complete_task'] = totalCompleteTask;
    data['total_due_task'] = totalDueTask;
    data['total_today_due_task'] = totalTodayDueTask;
    if (taskCategory != null) {
      data['task_category'] =
          taskCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskCategory {
  String? taskCategoryId;
  String? taskCategoryName;
  bool? isEditAllow;
  bool? isDeleteAllow;
  String? taskPercentage;
  List<TaskCount>? taskCount;

  TaskCategory(
      {this.taskCategoryId,
        this.taskCategoryName,
        this.isEditAllow,
        this.isDeleteAllow,
        this.taskPercentage,
        this.taskCount});

  TaskCategory.fromJson(Map<String, dynamic> json) {
    taskCategoryId = json['task_category_id'];
    taskCategoryName = json['task_category_name'];
    isEditAllow = json['is_edit_allow'];
    isDeleteAllow = json['is_delete_allow'];
    taskPercentage = json['task_percentage'];
    if (json['task_count'] != null) {
      taskCount = <TaskCount>[];
      json['task_count'].forEach((v) {
        taskCount!.add(TaskCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_category_id'] = taskCategoryId;
    data['task_category_name'] = taskCategoryName;
    data['is_edit_allow'] = isEditAllow;
    data['is_delete_allow'] = isDeleteAllow;
    data['task_percentage'] = taskPercentage;
    if (taskCount != null) {
      data['task_count'] = taskCount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskCount {
  String? name;
  String? color;
  String? count;

  TaskCount({this.name, this.color, this.count});

  TaskCount.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['color'] = color;
    data['count'] = count;
    return data;
  }
}
