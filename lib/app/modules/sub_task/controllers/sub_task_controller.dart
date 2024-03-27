import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/sub_task_data_modal.dart';
import 'package:task/api/api_model/sub_task_filter_data_modal.dart';
import 'package:task/app/modules/sub_task/views/sub_task_view.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_dialog/cd.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:http/http.dart' as http;
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/custom_outline_button.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class SubTaskController extends GetxController {
  final count = 0.obs;
  final taskCategoryId = ''.obs;
  final taskName = 'Task Name'.obs;
  final apiResValue = true.obs;
  final hideSearchFieldValue = false.obs;
  final apiResValueForSubTaskFilter = true.obs;
  final apiResValueForSubTask = true.obs;
  final switchValue = false.obs;

  final bottomSheetSelectPriorityValue = false.obs;
  final taskSearchController = TextEditingController();
  FocusNode focusNodeTaskSearch = FocusNode();

  final selectPriorityValue = ''.obs;
  final selectPriorityId = ''.obs;

  final filterIdValueList = [].obs;

  final getSubTaskFilterDataModal = Rxn<SubTaskFilterDataModal>();
  List<TaskStatus>? subTaskFilterList;
  List<TaskStatus>? subTaskFilterListForPriority;
  Map<String, dynamic> bodyParamsForGetSubTaskFilter = {};

  final getSubTaskDataModal = Rxn<SubTaskDataModal>();
  List<TaskDetails> subTaskList = [];
  List selectedStatusFilterIds = [];
  Map<String, dynamic> bodyParamsForGetSubTask = {};

  final isLastPage = false.obs;
  String limit = '10';
  final offset = 0.obs;

  Map<String, dynamic> bodyParamsForDeleteSubTask = {};

  final descriptionController = TextEditingController();
  FocusNode focusNodeDescription = FocusNode();
  final updatePriorityButtonValue = false.obs;

  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;

  late OverlayEntry overlayEntry;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      taskCategoryId.value = Get.arguments[0];
      taskName.value = Get.arguments[1];
      await callingGetSubTaskFilterApi();
      await callingGetSubTaskApi();
    } catch (e) {
      apiResValue.value = false;
    }
    apiResValue.value = false;
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

  void clickOnBackButton() {
    Get.back();
  }

  onRefresh() async {
    CM.unFocusKeyBoard();
    apiResValue.value = true;
    apiResValueForSubTaskFilter.value = true;
    apiResValueForSubTask.value = true;
    await onInit();
  }

  Future<void> subTaskSearchOnChange({required String value}) async {
    subTaskList.clear();
    offset.value = 0;
    isLastPage.value = false;
    await callingGetSubTaskApi();
    count.value++;
  }

  Future<void> clickOnSubTaskFilterCard({required int index}) async {
    CM.unFocusKeyBoard();
    count.value = 0;

    subTaskFilterList?[index].isSelected = !subTaskFilterList![index].isSelected;

    selectedStatusFilterIds = [
      for (var e in subTaskFilterList!)
        if (e.isSelected) e.taskActualStatus
    ];

    subTaskList.clear();
    offset.value = 0;
    isLastPage.value = false;
    bodyParamsForGetSubTask.clear();
    bodyParamsForGetSubTask = {
      AK.action: ApiEndPointAction.getTask,
      AK.taskCategoryId: taskCategoryId.value,
      AK.statusFilter: selectedStatusFilterIds.join(','),
      AK.searchFilter: taskSearchController.text.trim().toString(),
      AK.limit: limit.toString(),
      AK.offset: offset.toString(),
    };
    await callingGetSubTaskApi(filterValue: true);
    count.value++;
  }

  Future<void> clickOnEditStatusButton({required String taskId}) async {
    CM.unFocusKeyBoard();
    bodyParamsForGetSubTaskFilter = {
      AK.action: ApiEndPointAction.getTaskStatus,
      AK.taskId: taskId
    };
    await callingGetSubTaskFilterApi(forPriorityValue: true);
    await CBS.commonBottomSheet(
      showDragHandle: false,
      isDismissible: false,
      isFullScreen: true,
      onTap: () => CM.unFocusKeyBoard(),
      children: [
        Center(child: Text('Edit Status', style: Theme.of(Get.context!).textTheme.displaySmall)),
        SizedBox(height: 20.px),
        Obx(() {
          count.value;
          return CustomOutlineButton(
            padding: EdgeInsets.all(10.px),
            gradient: CW.commonLinearGradientForButtonsView(),
            radius: 6.px,
            strokeWidth: 1.px,
            onPressed: () {},
            customOutlineForButtonValue: false,
            child: AnimatedCrossFade(
              sizeCurve: Curves.easeInOutCubicEmphasized,
              firstCurve: Curves.easeInOutCubicEmphasized,
              reverseDuration: const Duration(microseconds: 0),
              firstChild: InkWell(
                onTap: () => bottomSheetSelectPriorityValue.value = !bottomSheetSelectPriorityValue.value,
                child: commonRowForSelectPriorityView(),
              ),
              secondChild: Column(
                children: [
                  InkWell(
                    onTap: () => bottomSheetSelectPriorityValue.value = !bottomSheetSelectPriorityValue.value,
                    child: commonRowForSelectPriorityView(),
                  ),
                  SizedBox(height: 10.px),
                  filterCardGridView(),
                  SizedBox(height: 10.px),
                ],
              ),
              crossFadeState: bottomSheetSelectPriorityValue.value
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 500),
              secondCurve: Curves.easeInOutSine,
            ),
          );
        }),
        SizedBox(height: 10.px),
        CW.commonTextFieldForMultiline(
            labelText: 'Description',
            hintText: 'Description',
            controller: descriptionController,
            focusNode: focusNodeDescription,
            isSearchLabelText: false,
            maxLines: 3),
        SizedBox(height: 10.px),
        Obx(() {
          count.value;
          return CW.myElevatedButton(
              onPressed: updatePriorityButtonValue.value
                  ? () => null
                  : () => clickOnPriorityUpdateButton(
                      taskId: taskId,
                      taskStatus: selectPriorityId.value,
                      description: descriptionController.text.trim().toString()),
              buttonText: 'Update',
              isLoading: updatePriorityButtonValue.value);
        }),
        SizedBox(height: 20.px),
      ],
    ).whenComplete(
      () {
        CM.unFocusKeyBoard();
        bottomSheetSelectPriorityValue.value = false;
        selectPriorityValue.value = '';
        selectPriorityId.value = '';
        descriptionController.clear();
      },
    );
  }

  Widget commonRowForSelectPriorityView() {
    return Obx(() {
      count.value;
      return Padding(
        padding: EdgeInsets.only(left: 10.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectPriorityValue.value.isNotEmpty
                  ? selectPriorityValue.value
                  : 'Select Status*',
              style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(color: selectPriorityValue.value.isNotEmpty?Col.inverseSecondary:Col.gTextColor),
            ),
            InkWell(
              onTap: () => bottomSheetSelectPriorityValue.value = !bottomSheetSelectPriorityValue.value,
              child: Icon(
                  bottomSheetSelectPriorityValue.value
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                  size: 22.px,
                  color: Col.inverseSecondary),
            )
          ],
        ),
      );
    });
  }

  Widget filterCardGridView() {
    if (getSubTaskFilterDataModal.value != null) {
      if (subTaskFilterListForPriority != null && subTaskFilterListForPriority!.isNotEmpty) {
        return Card(
          color: Col.gCardColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.px)),
          child: Padding(
            padding: EdgeInsets.all(4.px),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subTaskFilterListForPriority?.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2.6),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => clickOnPriorityStatusFilterCard(index: index),
                  borderRadius: BorderRadius.circular(6.px),
                  child: Container(
                    margin: EdgeInsets.all(4.px),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: selectPriorityValue.value == subTaskFilterListForPriority?[index].taskStatusName
                              ? CW.apiColorConverterMethod(colorString: '${subTaskFilterListForPriority?[index].taskStatusColor}')
                              : Colors.transparent,
                          width: 1.px),
                      borderRadius: BorderRadius.circular(6.px),
                      color: selectPriorityValue.value == subTaskFilterListForPriority?[index].taskStatusName
                          ? CW.apiColorConverterMethod(colorString: '${subTaskFilterListForPriority?[index].taskStatusColor}').withOpacity(.2)
                          : Col.gray.withOpacity(.2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(6.px),
                      child: Row(
                        children: [
                          Container(
                            height: 10.px,
                            width: 10.px,
                            decoration: BoxDecoration(
                                color: selectPriorityValue.value ==
                                        subTaskFilterListForPriority?[index].taskStatusName
                                    ? CW.apiColorConverterMethod(colorString: '${subTaskFilterListForPriority?[index].taskStatusColor}')
                                    : Col.gTextColor,
                                shape: BoxShape.circle),
                          ),
                          SizedBox(width: 4.px),
                          const SubTaskView().cardTitleTextView(
                              text: '${subTaskFilterListForPriority?[index].taskStatusName}',
                              color: Col.gTextColor),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    } else {
      return const SizedBox();
    }
  }

  void clickOnPriorityStatusFilterCard({required int index}) {
    selectPriorityId.value = subTaskFilterListForPriority?[index].taskActualStatus ?? '';
    selectPriorityValue.value = subTaskFilterListForPriority?[index].taskStatusName ?? '';
    count.value++;
  }

  Future<void> clickOnPriorityUpdateButton({required String taskId, required String taskStatus, required String description}) async {
    updatePriorityButtonValue.value = true;
    bodyParamsForDeleteSubTask.clear();
    bodyParamsForDeleteSubTask = {
      AK.action: ApiEndPointAction.changeTaskStatus,
      AK.taskId: taskId,
      AK.taskStatus: taskStatus,
      AK.taskTimelineDescription: description,
    };
    await callingTaskApi();
    updatePriorityButtonValue.value = false;
    Get.back();
  }

  Future<void> clickOnSubTaskEditButton({required int index}) async {
    CM.unFocusKeyBoard();
    await Get.toNamed(Routes.ADD_SUB_TASK, arguments: [
      'Update Task',
      taskCategoryId.value,
      subTaskList[index]
    ]);
    apiResValue.value = true;
    onInit();
    }

  void clickOnDeleteSubTaskButton({required int index}) {
    CM.unFocusKeyBoard();
    CD.commonIosDeleteConfirmationDialog(
      clickOnCancel: () => Get.back(),
      clickOnDelete: () async {
        bodyParamsForDeleteSubTask.clear();
        bodyParamsForDeleteSubTask = {
          AK.action: ApiEndPointAction.deleteTask,
          AK.taskCategoryId: taskCategoryId.value,
          AK.taskId: subTaskList[index].taskId ?? ''
        };
        await callingTaskApi();
        Get.back();
      },
    );
  }

  void clickOnTimeLineButton({required int index}) {
     Get.toNamed(Routes.TASK_TIME_LINE, arguments: [subTaskList[index]]);
    }

  Future<void> callingGetSubTaskFilterApi({bool forPriorityValue = false}) async {
    try {
      if (!forPriorityValue) {
        apiResValueForSubTaskFilter.value = true;
        getSubTaskFilterDataModal.value = null;
        subTaskFilterList?.clear();
        bodyParamsForGetSubTaskFilter = {
          AK.action: ApiEndPointAction.getTaskStatus,
        };
      }
      getSubTaskFilterDataModal.value = await CAI.getSubTaskFilterDataApi(bodyParams: bodyParamsForGetSubTaskFilter);
      if (getSubTaskFilterDataModal.value != null) {
        if (forPriorityValue) {
          subTaskFilterListForPriority?.clear();
          subTaskFilterListForPriority = getSubTaskFilterDataModal.value?.taskStatus;
        } else {
          subTaskFilterList = getSubTaskFilterDataModal.value?.taskStatus;
          subTaskFilterList?.forEach((element) {
            if (element.taskStatusName == 'Pending') {
              element.isSelected = true;
              selectedStatusFilterIds.add(element.taskActualStatus);
            } else if (element.taskStatusName == 'In Progress') {
              element.isSelected = true;
              selectedStatusFilterIds.add(element.taskActualStatus);
            } else if (element.taskStatusName == 'On Hold') {
              element.isSelected = true;
              selectedStatusFilterIds.add(element.taskActualStatus);
            }
          });
        }
      }
    } catch (e) {
      print('get sub task filter api error::::  $e');
      CM.error();
      apiResValueForSubTaskFilter.value = false;
    }
    apiResValueForSubTaskFilter.value = false;
  }

  Future<void> callingGetSubTaskApi({bool filterValue = false}) async {
    try {
      apiResValueForSubTask.value = true;
      getSubTaskDataModal.value = null;
      subTaskList.clear();
      if (!filterValue) {
        bodyParamsForGetSubTask = {
          AK.action: ApiEndPointAction.getTask,
          AK.taskCategoryId: taskCategoryId.value,
          AK.searchFilter: taskSearchController.text.trim().toString(),
          AK.limit: limit.toString(),
          AK.offset: offset.toString()
        };
      }
      getSubTaskDataModal.value = await CAI.getSubTaskDataApi(bodyParams: bodyParamsForGetSubTask);

      if (getSubTaskDataModal.value != null) {
        if (getSubTaskDataModal.value?.taskDetails != null && getSubTaskDataModal.value!.taskDetails!.isNotEmpty) {
          subTaskList.addAll(getSubTaskDataModal.value?.taskDetails ?? []);
        } else {
          isLastPage.value = true;
        }

        print('subTaskList:::::: ${subTaskList.length}');
      }
    } catch (e) {
      print('get sub task api error::::  $e');
      CM.error();
      apiResValueForSubTask.value = false;
    }
    apiResValueForSubTask.value = false;
  }

  Future<void> callingTaskApi() async {
    try {
      http.Response? response = await CAI.addTaskApi(bodyParams: bodyParamsForDeleteSubTask);
      if (response != null && response.statusCode == 200) {
        apiResValueForSubTask.value = true;
        subTaskList.clear();
        offset.value = 0;
        isLastPage.value = false;
        await callingGetSubTaskApi();
        updatePriorityButtonValue.value = false;
      } else {
        CM.error();
        updatePriorityButtonValue.value = false;
      }
    } catch (e) {
      print('add task error::: $e');
      CM.error();
      updatePriorityButtonValue.value = false;
    }
  }

  Future<void> clickOnAddNewSubTaskButton() async {
    CM.unFocusKeyBoard();
    await Get.toNamed(Routes.ADD_SUB_TASK,
        arguments: ['Add Task', taskCategoryId.value]);
    apiResValue.value = true;
    onInit();
  }

  Future<void> clickOnTaskAttachmentButton({required int index}) async {
    String attachmentType = CM.getDocumentType(filePath: '${subTaskList[index].taskAttachment}');
    print(':::::: $attachmentType');

    if (attachmentType == 'PDF') {
      await showGeneralDialog(
        context: Get.context!,
        pageBuilder: (context, animation, secondaryAnimation) => Material(
          child: InteractiveViewer(
            child: SafeArea(
              child: SfPdfViewer.network(
                '${AU.baseUrlAllApisImage}${subTaskList[index].taskAttachment}',
              ),
            ),
          ),
        ),
      );
    } else if (attachmentType == 'Image') {
      await showGeneralDialog(
        context: Get.context!,
        barrierColor: Col.inverseSecondary,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Material(
            child: Center(
              child: InteractiveViewer(
                child: SafeArea(
                  child: commonContainerForImage(
                    networkImage:
                        '${AU.baseUrlAllApisImage}${subTaskList[index].taskAttachment}',
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      if (!await launcher.launchUrl(
        '${AU.baseUrlAllApisImage}${subTaskList[index].taskAttachment}',
        const LaunchOptions(mode: PreferredLaunchMode.inAppBrowserView),
      )) {
        throw Exception(
            'Could not launch ${AU.baseUrlAllApisImage}${subTaskList[index].taskAttachment}');
      }
    }
  }

  Widget commonContainerForImage({required String networkImage}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.px, vertical: 4.px),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3.px),
        child: Image.network(
          networkImage,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: Padding(
                padding: EdgeInsets.all(8.px),
                child: CW.commonShimmerViewForImage(),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => CW.commonNetworkImageView(height: 150.px,width: 250.px, path: 'assets/images/default_image.jpg', isAssetImage: true),
        ),
      ),
    );
  }

  Future<void> onLoadMore() async {
    CM.unFocusKeyBoard();
    offset.value = offset.value + 1;
    try {
      if (int.parse(limit) <= subTaskList.length) {
        await callingGetSubTaskApi();
      }
    } catch (e) {
      CM.error();
    }
  }

}
