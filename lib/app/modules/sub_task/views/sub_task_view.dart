import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/app/modules/sub_task/views/sub_task_shimmer_view.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/sub_task_controller.dart';

class SubTaskView extends GetView<SubTaskController> {
  const SubTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CM.unFocusKeyBoard(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CW.commonAppBarView(
          title: controller.taskName.value,
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton(),
        ),
        body: Obx(() {
          controller.count.value;
          return AC.isConnect.value
              ? ModalProgress(
                  isLoader: false,
                  inAsyncCall: controller.apiResValue.value,
                  child: CW.commonRefreshIndicator(
                    onRefresh: () => controller.onRefresh(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.px, horizontal: 12.px),
                      child: Column(
                        children: [
                          subTaskSearchTextFieldView(),
                          SizedBox(height: 16.px),
                          controller.apiResValue.value
                              ? Expanded(
                                  child: SubTaskShimmerView.shimmerView(apiResValue: controller.apiResValue.value, apiResValueForSubTaskFilter: controller.apiResValueForSubTaskFilter.value, apiResValueForSubTask: controller.apiResValueForSubTask.value),
                                )
                              : Expanded(
                                  child: ListView(
                                    physics: const ScrollPhysics(),
                                    children: [
                                      controller.apiResValueForSubTaskFilter.value
                                          ? SubTaskShimmerView.shimmerView(apiResValue: controller.apiResValue.value, apiResValueForSubTaskFilter: controller.apiResValueForSubTaskFilter.value, apiResValueForSubTask: controller.apiResValueForSubTask.value)
                                          : filterCardGridView(),
                                      SizedBox(height: 16.px),
                                      controller.apiResValueForSubTask.value
                                          ? SubTaskShimmerView.shimmerView(apiResValue: controller.apiResValue.value, apiResValueForSubTaskFilter: controller.apiResValueForSubTaskFilter.value, apiResValueForSubTask: controller.apiResValueForSubTask.value)
                                          : subTaskCardListView(),
                                      SizedBox(height: 8.h)
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                )
              : CW.commonNoNetworkView();
        }),
        floatingActionButton: AC.isConnect.value
            ? addSubTaskFloatingActionButtonView()
            : const SizedBox(),
      ),
    );
  }

  Widget subTaskSearchTextFieldView() => CW.commonTextField(
        isBorder: true,
        isSearchLabelText: true,
        hintText: 'Search Task',
        controller: controller.taskSearchController,
        onChanged: (value) => controller.subTaskSearchOnChange(value: value),
        prefixIcon: SizedBox(
          width: 24.px,
          height: 24.px,
          child: Center(
            child: CW.commonNetworkImageView(
                path: 'assets/icons/search_icon.png',
                isAssetImage: true,
                width: 24.px,
                height: 24.px),
          ),
        ),
      );

  Widget subTitleTextView({required String text, double? fontSize,int? maxLines}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, fontSize: fontSize),
        maxLines: maxLines ?? 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget cardTitleTextView({required String text, Color? color, double? fontSize}) =>
      Text(
        text, style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
            fontSize: fontSize ?? 10.px,
            fontWeight: FontWeight.w600,
            color: color),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget filterCardGridView() {
    if (controller.getSubTaskFilterDataModal.value != null) {
      if (controller.subTaskFilterList != null && controller.subTaskFilterList!.isNotEmpty) {
        return Card(
          color: Col.inverseSecondary,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.px)),
          child: Padding(
            padding: EdgeInsets.all(4.px),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.subTaskFilterList?.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2.6),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => controller.clickOnSubTaskFilterCard(index: index),
                  borderRadius: BorderRadius.circular(6.px),
                  child: Container(
                    margin: EdgeInsets.all(4.px),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: controller.subTaskFilterList?[index].isSelected ?? false
                              ? CW.apiColorConverterMethod(colorString: '${controller.subTaskFilterList?[index].taskStatusColor}')
                              : Colors.transparent,
                          width: 1.px),
                      borderRadius: BorderRadius.circular(6.px),
                      color: controller.subTaskFilterList?[index].isSelected ?? false
                          ? CW.apiColorConverterMethod(colorString: '${controller.subTaskFilterList?[index].taskStatusColor}')
                              .withOpacity(.2)
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
                                color: controller.subTaskFilterList?[index].isSelected ?? false
                                    ? CW.apiColorConverterMethod(colorString: '${controller.subTaskFilterList?[index].taskStatusColor}')
                                    : Col.gray.withOpacity(.5),
                                shape: BoxShape.circle),
                          ),
                          SizedBox(width: 4.px),
                          cardTitleTextView(
                              text: '${controller.subTaskFilterList?[index].taskStatusName}',
                              color: Col.secondary),
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

  Widget subTaskCardListView() {
    if (controller.subTaskList != null && controller.subTaskList!.isNotEmpty) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.subTaskList?.length,
        itemBuilder: (context, index) {
          return Card(
            color: Col.inverseSecondary,
            margin: EdgeInsets.only(bottom: 10.px, left: 0.px, right: 0.px, top: 0.px),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.px)),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                taskNameContainerView(index: index),
                profileView(index: index),
                CW.commonDividerView(height: 0.px, color: Col.gray.withOpacity(.5)),
                dateView(index: index),
                if(controller.subTaskList?[index].taskNote != null && controller.subTaskList![index].taskNote!.isNotEmpty)
                  CW.commonDividerView(height: 0.px, color: Col.gray.withOpacity(.5)),
                if(controller.subTaskList?[index].taskNote != null && controller.subTaskList![index].taskNote!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.all(10.px),
                    child: Row(
                      children: [
                        cardTitleTextView(text: 'Task Note - ', color: Col.gray),
                        Flexible(
                            child: subTitleTextView(text: '${controller.subTaskList?[index].taskNote}',maxLines: 2),
                        ),
                      ],
                    ),
                  ),
                CW.commonDividerView(height: 0.px, color: Col.gray.withOpacity(.5)),

                statusView(index: index),
                editDeleteAndMoreView(index: index)
              ],
            ),
          );
        },
      );
    } else {
      return SizedBox(
        height: 50.h,
        child: CW.commonNoDataFoundText(),
      );
    }
  }

  Widget taskNameContainerView({required int index}) => Container(
        width: double.infinity,
        height: 44.px,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: CW
              .apiColorConverterMethod(
                  colorString:
                      '${controller.subTaskList?[index].taskStatusColor}')
              .withOpacity(.1),
          border: Border.all(
              color: CW.apiColorConverterMethod(
                  colorString:
                      '${controller.subTaskList?[index].taskStatusColor}'),
              width: 1.px),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(6.px),
            topLeft: Radius.circular(6.px),
          ),
        ),
        padding: EdgeInsets.only(left: 10.px),
        child: Row(
          children: [
            cardTitleTextView(
                text: controller.subTaskList?[index].taskName != null &&
                        controller.subTaskList![index].taskName!.isNotEmpty
                    ? '${controller.subTaskList?[index].taskName}'
                    : 'Not Found!',
                fontSize: 14.px),
          ],
        ),
      );

  Widget profileView({required int index}) => Padding(
        padding: EdgeInsets.all(10.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50.px,
              height: 50.px,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Col.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: controller.subTaskList?[index].userProfile != null && controller.subTaskList![index].userProfile!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(25.px),
                        child: CW.commonNetworkImageView(
                            path: '${AU.baseUrlAllApisImage}${controller.subTaskList?[index].userProfile}',
                            isAssetImage: false,
                            errorImage: 'assets/images/profile.png',
                          width: 50.px,
                          height: 50.px,
                        ),
                      )
                    : Text(
                        controller.subTaskList?[index].shortName != null && controller.subTaskList![index].shortName!.isNotEmpty
                            ? '${controller.subTaskList?[index].shortName}'
                            : '?',
                        style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: Col.inverseSecondary),
                      ),
              ),
            ),
            SizedBox(width: 10.px),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cardTitleTextView(
                          text: controller.subTaskList?[index].isSelfAddedTask != null &&
                                  controller.subTaskList![index].isSelfAddedTask!.isNotEmpty
                              ? '${controller.subTaskList?[index].isSelfAddedTask}'
                              : 'Not Found!',
                          color: Col.gray),
                      cardTitleTextView(
                          text: controller.subTaskList?[index].createdDate != null &&
                                  controller.subTaskList![index].createdDate!.isNotEmpty
                              ? DateFormat('hh:mm a, d MMM y').format(DateTime.parse('${controller.subTaskList?[index].createdDate}'))
                              : 'Not Found!',
                          color: Col.gray),
                    ],
                  ),
                  subTitleTextView(
                      text: controller.subTaskList?[index].userName != null &&
                              controller.subTaskList![index].userName!.isNotEmpty
                          ? '${controller.subTaskList?[index].userName}'
                          : 'Not found!'),
                ],
              ),
            )
          ],
        ),
      );

  Widget dateView({required int index}) => Padding(
        padding: EdgeInsets.all(10.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            controller.subTaskList?[index].subTaskPercentage != '0'
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        startDateView(index: index),
                        SizedBox(height: 10.px),
                        dueDateView(index: index),
                      ],
                    ),
                  )
                : Row(children: [
                    startDateView(index: index),
                    SizedBox(width: 10.px),
                    dueDateView(index: index),
                  ]),
            if (controller.subTaskList?[index].subTaskPercentage != '0')
              SizedBox(
                width: 40.px,
                height: 40.px,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CW.commonProgressBarView(
                        value: .5,
                        backgroundColor: Col.gray,
                        color: Col.primary),
                    cardTitleTextView(text: '50%', fontSize: 8.px)
                  ],
                ),
              )
          ],
        ),
      );

  Widget startDateView({required int index}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardTitleTextView(text: 'Start Date', color: Col.gray),
          subTitleTextView(text: controller.subTaskList?[index].taskStartDate != null && controller.subTaskList![index].taskStartDate!.isNotEmpty
                  ? DateFormat('d MMM y').format(DateTime.parse('${controller.subTaskList?[index].taskStartDate}'))
              : 'Not Found!',
          ),
        ],
      );

  Widget dueDateView({required int index}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardTitleTextView(text: 'Due Date', color: Col.gray),
          subTitleTextView(
              text: controller.subTaskList?[index].taskDueDate != null && controller.subTaskList![index].taskDueDate!.isNotEmpty
                  ? DateFormat('d MMM y').format(DateTime.parse('${controller.subTaskList?[index].taskDueDate}'))
                  : 'Not Found!'),
        ],
      );

  Widget statusView({required int index}) => Padding(
        padding: EdgeInsets.all(10.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cardTitleTextView(text: 'Priority', color: Col.gray),
                      Row(
                        children: [
                          Container(
                            height: 16.px,
                            width: 16.px,
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            child:  commonCardButtonView(
                              iconPath: 'assets/icons/priority_icon.png',
                            ),
                          ),
                          SizedBox(width: 4.px),
                          cardTitleTextView(
                              text: controller.subTaskList?[index].taskPriority != null && controller.subTaskList![index].taskPriority!.isNotEmpty
                                  ? '${controller.subTaskList?[index].taskPriority}'
                                  : 'Not Found!',
                              color: Col.secondary),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 10.px),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cardTitleTextView(text: 'Status', color: Col.gray),
                      Row(
                        children: [
                          Container(
                            height: 10.px,
                            width: 10.px,
                            decoration: BoxDecoration(
                                color: controller.subTaskList?[index].taskStatusColor != '' ||
                                        controller.subTaskList?[index].taskStatusColor != null && controller.subTaskList![index].taskStatusColor!.isNotEmpty
                                    ? CW.apiColorConverterMethod(
                                        colorString: '${controller.subTaskList?[index].taskStatusColor}')
                                    : Col.secondary,
                                shape: BoxShape.circle),
                          ),
                          SizedBox(width: 4.px),
                          cardTitleTextView(
                              text: controller.subTaskList?[index].taskStatusName != null && controller.subTaskList![index].taskStatusName!.isNotEmpty
                                  ? '${controller.subTaskList?[index].taskStatusName}'
                                  : 'Not Found!',
                              color: controller.subTaskList?[index].taskStatusColor != '' ||
                                      controller.subTaskList?[index].taskStatusColor != null && controller.subTaskList![index].taskStatusColor!.isNotEmpty
                                  ? CW.apiColorConverterMethod(
                                      colorString: '${controller.subTaskList?[index].taskStatusColor}')
                                  : Col.secondary),
                          if (controller.subTaskList?[index].taskStatus != '4' && controller.subTaskList?[index].taskStatus != '3')
                            SizedBox(width: 5.px),
                          if (controller.subTaskList?[index].taskStatus != '4' && controller.subTaskList?[index].taskStatus != '3')
                            InkWell(
                              onTap: () => controller.clickOnEditStatusButton(taskId: controller.subTaskList?[index].taskId ?? ''),
                              child: CW.commonNetworkImageView(
                                  path: 'assets/icons/edit_status_icon.png',
                                  isAssetImage: true,
                                  width: 12.px,
                                  height: 12.px,
                                  color: controller.subTaskList?[index].taskStatusColor != '' || controller.subTaskList?[index].taskStatusColor != null && controller.subTaskList![index].taskStatusColor!.isNotEmpty
                                      ? CW.apiColorConverterMethod(
                                          colorString: '${controller.subTaskList?[index].taskStatusColor}')
                                      : Col.secondary),
                            )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            /* Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          cardTitleTextView(text: 'My Day', color: Col.gray),
                          SizedBox(height: 4.px),
                          CW.commonSwitchButtonView(
                            onChange: () {
                              controller.switchValue.value =
                                  !controller.switchValue.value;
                              controller.count.value++;
                            },
                            value: controller.switchValue.value,
                            switchBackgroundColor: controller.switchValue.value
                                ? Col.primary
                                : Col.gray,
                          ),
                        ],
                      ),*/
          ],
        ),
      );

  Widget editDeleteAndMoreView({required int index}) => Padding(
        padding: EdgeInsets.all(10.px),
        child: Row(
          children: [
            if (controller.subTaskList?[index].isEditAllow ?? false)
              commonCardButtonView(
                iconPath: 'assets/icons/edit_pen2_icon.png',
                onTap: () => controller.clickOnSubTaskEditButton(index: index),
              ),
            if (controller.subTaskList?[index].isEditAllow ?? false)
              SizedBox(width: 10.px),
            if (controller.subTaskList?[index].isDeleteAllow ?? false)
              commonCardButtonView(
                iconPath: 'assets/icons/delete_icon.png',
                iconColor: Col.error,
                onTap: () => controller.clickOnDeleteSubTaskButton(index: index),
              ),
            if (controller.subTaskList?[index].isDeleteAllow ?? false)
              SizedBox(width: 10.px),
            commonCardButtonView(
              iconPath: 'assets/icons/time_line_icon.png',
              onTap: () => controller.clickOnTimeLineButton(index: index),
            ),
            SizedBox(width: 10.px),
            if (controller.subTaskList?[index].taskAttachment != null && controller.subTaskList![index].taskAttachment!.isNotEmpty)
            commonCardButtonView(
              iconPath: 'assets/icons/document_icon.png',
              onTap: () => controller.clickOnTaskAttachmentButton(index: index),
            ),
            SizedBox(width: 10.px),
          ],
        ),
      );

  Widget commonCardButtonView({GestureTapCallback? onTap, Color? iconColor, required String iconPath}) =>
      InkWell(
        borderRadius: BorderRadius.circular(6.px),
        onTap: onTap,
        child: Ink(
          width: 30.px,
          height: 30.px,
          decoration: BoxDecoration(
              color: Col.primary.withOpacity(.1),
              borderRadius: BorderRadius.circular(6.px)),
          child: Center(
            child: CW.commonNetworkImageView(
                path: iconPath,
                height: 12.px,
                width: 12.px,
                isAssetImage: true,
                color: iconColor),
          ),
        ),
      );

  Widget addSubTaskFloatingActionButtonView() => Padding(
        padding: EdgeInsets.only(bottom: 10.px),
        child: CW.commonOutlineButton(
            onPressed: () => controller.clickOnAddNewSubTaskButton(),
            child: Icon(
              Icons.add,
              color: Col.inverseSecondary,
              size: 22.px,
            ),
            height: 50.px,
            width: 50.px,
            backgroundColor: Col.primary,
            borderColor: Colors.transparent,
            borderRadius: 25.px),
      );
}
