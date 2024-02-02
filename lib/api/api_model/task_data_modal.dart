class TaskDataModal {
  String? message;
  String? totalCompleteTask;
  String? totalDueTask;
  String? totalTodayDueTask;
  List<CategoryDetails>? categoryDetails;

  TaskDataModal(
      {this.message,
        this.totalCompleteTask,
        this.totalDueTask,
        this.totalTodayDueTask,
        this.categoryDetails});

  TaskDataModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    totalCompleteTask = json['total_complete_task'];
    totalDueTask = json['total_due_task'];
    totalTodayDueTask = json['total_today_due_task'];
    if (json['categoryDetails'] != null) {
      categoryDetails = <CategoryDetails>[];
      json['categoryDetails'].forEach((v) {
        categoryDetails!.add(CategoryDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['total_complete_task'] = totalCompleteTask;
    data['total_due_task'] = totalDueTask;
    data['total_today_due_task'] = totalTodayDueTask;
    if (categoryDetails != null) {
      data['categoryDetails'] =
          categoryDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryDetails {
  String? taskCategoryId;
  String? taskCategoryName;
  String? totalTaskCount;
  String? pendingTaskCount;
  String? inprogressTaskCount;
  String? onholdTaskCount;
  String? cancelTaskCount;
  String? completeTaskCount;

  CategoryDetails(
      {this.taskCategoryId,
        this.taskCategoryName,
        this.totalTaskCount,
        this.pendingTaskCount,
        this.inprogressTaskCount,
        this.onholdTaskCount,
        this.cancelTaskCount,
        this.completeTaskCount});

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    taskCategoryId = json['task_category_id'];
    taskCategoryName = json['task_category_name'];
    totalTaskCount = json['total_task_count'];
    pendingTaskCount = json['pending_task_count'];
    inprogressTaskCount = json['inprogress_task_count'];
    onholdTaskCount = json['onhold_task_count'];
    cancelTaskCount = json['cancel_task_count'];
    completeTaskCount = json['complete_task_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_category_id'] = taskCategoryId;
    data['task_category_name'] = taskCategoryName;
    data['total_task_count'] = totalTaskCount;
    data['pending_task_count'] = pendingTaskCount;
    data['inprogress_task_count'] = inprogressTaskCount;
    data['onhold_task_count'] = onholdTaskCount;
    data['cancel_task_count'] = cancelTaskCount;
    data['complete_task_count'] = completeTaskCount;
    return data;
  }
}
