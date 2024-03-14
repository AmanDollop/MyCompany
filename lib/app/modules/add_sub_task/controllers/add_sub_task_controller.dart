import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_my_team_member_modal.dart';
import 'package:task/api/api_model/sub_task_data_modal.dart';
import 'package:task/api/api_model/user_data_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:http/http.dart' as http;
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';
import 'package:task/theme/colors/colors.dart';

class AddSubTaskController extends GetxController {
  final count = 0.obs;

  final assignToListViewValue = false.obs;

  final pageName = ''.obs;
  final taskCategoryId = ''.obs;

  final key = GlobalKey<FormState>();
  final image = Rxn<File?>();

  List<String> selectPriorityList = [
    'Low',
    'Medium',
    'High',
  ];

  final subTaskNameController = TextEditingController();
  final selectPriorityController = TextEditingController();
  final taskStartDateController = TextEditingController();
  final taskDueDateController = TextEditingController();
  final dueTimeController = TextEditingController();
  final remarkController = TextEditingController();

  final notCompletedTaskValue = false.obs;
  final repeatTaskValue = false.obs;
  final addSubTaskButtonValue = false.obs;

  final result = Rxn<FilePickerResult>();
  final docLogo = ''.obs;
  final docType = ''.obs;
  final imagePathForAdd = ''.obs;
  final imagePathFoeUpDate = ''.obs;
  final imageFile = Rxn<File>();

  TaskDetails? subTaskList;

  Map<String, dynamic> bodyParamsForAddSubTask = {};

  final userDataFromLocalDataBase =''.obs;
  UserDetails? userData;
  PersonalInfo? personalInfo;
  JobInfo? jobInfo;

  /*final userId = ''.obs;
  final userPic = ''.obs;
  final userFullName = ''.obs;
  final userShortName = ''.obs;
  final developer = ''.obs;*/


  late OverlayEntry overlayEntry;

  List<MyTeam> selectedMyTeamMemberList = [];
  MyTeam? selfDataForMyTeamMember;

  @override
  void onInit() {
    super.onInit();
    pageName.value = Get.arguments[0];
    taskCategoryId.value = Get.arguments[1];
    if (pageName.value == 'Update Task') {
      subTaskList = Get.arguments[2];
      setDefaultData();
    }else{
      setDefaultUserData();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void setDefaultData() {
    subTaskNameController.text = subTaskList?.taskName ?? '';
    selectPriorityController.text = subTaskList?.taskPriority ?? '';
    taskStartDateController.text = CMForDateTime.dateFormatForDateMonthYear(date: '${subTaskList?.taskStartDate}');
    taskDueDateController.text = CMForDateTime.dateFormatForDateMonthYear(date: '${subTaskList?.taskDueDate}');
    dueTimeController.text =  CMForDateTime.timeFormatForHourMinuetAmPm(dateAndTime: '${subTaskList?.taskDueDate} ${subTaskList?.taskDueTime}');

    remarkController.text = subTaskList?.taskNote ?? '';
    docType.value = CM.getDocumentType(filePath: '${subTaskList?.taskAttachment}');
    docLogo.value = CM.getDocumentTypeLogo(fileType: docType.value);
    if (docType.value == 'Image') {
      imagePathFoeUpDate.value = '${AU.baseUrlAllApisImage}${subTaskList?.taskAttachment}';
    }

   /* userId.value = subTaskList?.assignUserId ?? '';
    userFullName.value = subTaskList?.userName ?? '';
    userShortName.value = subTaskList?.shortName ?? '';
    userPic.value = subTaskList?.userProfile ?? '';
    print('userPic.value:::: ${AU.baseUrlAllApisImage}${userPic.value}');
    developer.value = subTaskList?.userDesignation ?? '';*/

    selfDataForMyTeamMember = MyTeam(
      branchId:  '',
      departmentId:  '',
      shortName: subTaskList?.shortName ?? '',
      userDesignation: subTaskList?.userDesignation ?? '',
      userFullName: subTaskList?.userName ?? '',
      userId: subTaskList?.assignUserId ?? '',
      userProfilePic: subTaskList?.userProfile ?? '',
    );
    print('selfDataForMyTeamMember:: UPDATE:: $selfDataForMyTeamMember');
    if(selfDataForMyTeamMember != null){
      selectedMyTeamMemberList.insert(0, selfDataForMyTeamMember!);
    }

  }

  Future<void> setDefaultUserData() async {
    try{
      userDataFromLocalDataBase.value = await DataBaseHelper().getParticularData(key:DataBaseConstant.userDetail,tableName: DataBaseConstant.tableNameForUserDetail);
      userData = UserDataModal.fromJson(jsonDecode(userDataFromLocalDataBase.value)).userDetails;
      personalInfo=userData?.personalInfo;
      jobInfo=userData?.jobInfo;

     /* userId.value = personalInfo?.userId??'';
      userFullName.value = personalInfo?.userFullName ?? '';
      userShortName.value = personalInfo?.shortName ?? '';
      userPic.value = personalInfo?.userProfilePic ?? '';
      developer.value = jobInfo?.userDesignation ?? '';*/

      selfDataForMyTeamMember = MyTeam(
        branchId: jobInfo?.branchId ?? '',
        departmentId: jobInfo?.departmentId ?? '',
        shortName: personalInfo?.shortName ?? '',
        userDesignation: jobInfo?.userDesignation ?? '',
        userFullName: personalInfo?.userFullName ?? '',
        userId: personalInfo?.userId ?? '',
        userProfilePic: personalInfo?.userProfilePic ?? '',
      );
      print('selfDataForMyTeamMember:: ADD:: $selfDataForMyTeamMember');
      if(selfDataForMyTeamMember != null){
        selectedMyTeamMemberList.insert(0, selfDataForMyTeamMember!);
      }

      count.value++;
    }catch(e){
      print('error from user data :::: $e');
    }
  }

  Future<void> clickOnSelectPriorityTextFormFiled() async {
    await CBS.commonBottomSheet(
        showDragHandle: false,
        isDismissible: false,
        isFullScreen: true,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12.px),
            itemCount: selectPriorityList.length,
            itemBuilder: (context, index) {
              return Obx(() {
                count.value;
                return Container(
                  margin: EdgeInsets.only(bottom: 10.px),
                  padding: EdgeInsets.symmetric(vertical: 6.px, horizontal: 10.px),
                  height: 46.px,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.px),
                    color: selectPriorityController.text == selectPriorityList[index]
                        ? Col.primary.withOpacity(.08)
                        : Colors.transparent,
                    border: Border.all(
                      color: selectPriorityController.text == selectPriorityList[index]
                          ? Col.primary
                          : Col.darkGray,
                      width: selectPriorityController.text == selectPriorityList[index]
                          ? 1.5.px
                          : 1.px,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => clickOnSelectPriorityList(index: index),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectPriorityList[index],
                          style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Container(
                          height: selectPriorityController.text == selectPriorityList[index]
                              ? 18.px
                              : 16.px,
                          width: selectPriorityController.text == selectPriorityList[index]
                              ? 18.px
                              : 16.px,
                          padding: EdgeInsets.all(2.px),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                              selectPriorityController.text == selectPriorityList[index]
                                  ? Col.primary
                                  : Col.text,
                              width: 1.5.px,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: selectPriorityController.text == selectPriorityList[index]
                                    ? Col.primary
                                    : Colors.transparent),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ],
    ).whenComplete(
      () => CM.unFocusKeyBoard(),
    );
  }

  void clickOnBackButton() {
    Get.back();
  }

  void clickOnSelectPriorityList({required int index}) {
    selectPriorityController.text = selectPriorityList[index];
    Get.back();
  }

  Future<void> clickOnTaskStartDateTextFormFiled() async {
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: taskStartDateController,
      firstDate: taskStartDateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(taskStartDateController.text)
          : DateTime.now(),
      initialDate: taskStartDateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(taskStartDateController.text)
          : DateTime.now(),
      lastDate: taskDueDateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(taskDueDateController.text)
          : DateTime.now(),
    ).whenComplete(() async {
      CM.unFocusKeyBoard();
    });
  }

  Future<void> clickOnTaskDueDateTextFormFiled() async {
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: taskDueDateController,
      firstDate: taskStartDateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(taskStartDateController.text)
          : DateTime.now(),
      initialDate: taskDueDateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(taskDueDateController.text)
          : DateTime.now(),
      lastDate: taskDueDateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(taskDueDateController.text).add(const Duration(days: 20))
          : DateTime.now().add(const Duration(days: 20)),
    ).whenComplete(() async {
      CM.unFocusKeyBoard();
    });
  }

  Future<void> clickOnDueTimeTextFormFiled() async {
    // CDT.androidTimePicker(
    //   context: Get.context!,
    //   initialTime: dueTimeController.text.isNotEmpty
    //       ? convertToTimeOfDay(dueTimeController.text)
    //       : TimeOfDay.now(),
    // ).then((value) {
    //   CM.unFocusKeyBoard();
    //   if(value != null){
    //     dueTimeController.text = '${value.hour}:${value.minute}';
    //   }
    // });
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: dueTimeController,
      mode: CupertinoDatePickerMode.time,
      firstDate: dueTimeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(dueTimeController.text)
          : DateTime.now(),
      initialDate: dueTimeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(dueTimeController.text)
          : DateTime.now(),
      lastDate: dueTimeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(dueTimeController.text).add(const Duration(hours: 12))
          : DateTime.now().add(const Duration(hours: 12)),
    ).whenComplete(() async {
      CM.unFocusKeyBoard();
    });

  }

  Future<void> clickOnAttachFileButton() async {
    result.value = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: [
        'jpg',
        'pdf',
        'doc',
        'doc',
        'docx',
      ],
    );
    if (result.value != null) {
      imageFile.value = await CM.pickFilePickerResultAndConvertFile(result1: result.value);
      print('imageFile.value:::: ${imageFile.value}');
      if (result.value?.paths != null && result.value!.paths.isNotEmpty) {
        for (var element in result.value!.paths) {
          docType.value = CM.getDocumentType(filePath: '$element');
          docLogo.value = CM.getDocumentTypeLogo(fileType: docType.value);
          if (docType.value == 'Image') {
            imagePathForAdd.value = '$element';
          }
        }
      }
    }
  }

  Future<void> clickOnAddAndUpdateButton() async {
    if (key.currentState!.validate() /*&& notCompletedTaskValue.value && repeatTaskValue.value*/) {
      // Get.back();
      addSubTaskButtonValue.value = true;
      await callingAddSubTaskApi();
    }
  }

  Future<void> callingAddSubTaskApi() async {
    try {
     String userIds;
     if(selectedMyTeamMemberList.isNotEmpty){
       userIds = selfDataForMyTeamMember?.userId ?? ',${selectedMyTeamMemberList.map((data) {
         if(data.userId != null && data.userId!.isNotEmpty){
           return data.userId;
         }
       }).join(',')}';
     }else{
       userIds = selfDataForMyTeamMember?.userId ?? '';
     }

      bodyParamsForAddSubTask = {
        AK.action: ApiEndPointAction.addTask,
        AK.taskCategoryId: taskCategoryId.value,
        AK.taskId: subTaskList?.taskId ?? '',
        AK.taskPriority: selectPriorityController.text.trim().toString(),
        AK.taskStartDate: CMForDateTime.dateTimeFormatForApi(dateTime: taskStartDateController.text.trim().toString()),
        AK.taskDueDate: CMForDateTime.dateTimeFormatForApi(dateTime: taskDueDateController.text.trim().toString()),
        AK.taskDueTime: dueTimeController.text.trim().toString(),
        AK.taskName: subTaskNameController.text.trim().toString(),
        AK.taskNote: remarkController.text.trim().toString(),
        AK.taskAssignTo: userIds,
      };
      print('imageFile.value::::: ${imageFile.value}');
      http.Response? response = await CAI.addSubTaskApi(bodyParams: bodyParamsForAddSubTask, filePath: imageFile.value);
      if (response != null && response.statusCode == 200) {
        addSubTaskButtonValue.value = false;
        Get.back();
      } else {
        addSubTaskButtonValue.value = false;
        CM.error();
      }
    } catch (e) {
      print('add task error::: $e');
      addSubTaskButtonValue.value = false;
      CM.error();
    }
  }

  Future<void> clickOnAssignToAddButton() async {
    if(assignToListViewValue.value){
      selectedMyTeamMemberList.clear();
      assignToListViewValue.value = false;
    }else{
      var result  = await Get.toNamed(Routes.MY_TEAM);
      if(result != null){
        selectedMyTeamMemberList = result;
        assignToListViewValue.value = true;
      }
    }
    count.value++;
  }

}
