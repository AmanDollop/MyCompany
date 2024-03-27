import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/app/modules/all_task/controllers/all_task_controller.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_packages/load_more/lm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';

class AllTaskView extends GetView<AllTaskController> {
  const AllTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: Obx(() {
          controller.count.value;
          return GestureDetector(
            onTap: () => CM.unFocusKeyBoard(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Column(
                children: [
                  appBarView(),
                  Expanded(
                    child: Obx(() {
                      controller.count.value;
                      return AC.isConnect.value
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.px, horizontal: 12.px),
                              child: Column(
                                children: [
                                  AnimatedCrossFade(
                                    firstChild: const SizedBox(),
                                    secondChild: taskSearchTextFieldView(),
                                    crossFadeState: controller.hideSearchFieldValue.value
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                    duration: const Duration(milliseconds: 500),
                                    reverseDuration: const Duration(microseconds: 0),
                                  ),
                                  if (controller.hideSearchFieldValue.value)
                                    SizedBox(height: 16.px),
                                  controller.apiResValue.value
                                      ? Expanded(
                                          child: shimmerView(),
                                        )
                                      : Expanded(
                                          child: ModalProgress(
                                            inAsyncCall: controller.apiResValue.value,
                                            child: CW.commonRefreshIndicator(
                                              onRefresh: () => controller.onRefresh(),
                                              child: LM(
                                                noMoreWidget: const SizedBox(),
                                                isLastPage: controller.isLastPage.value,
                                                onLoadMore: () => controller.onLoadMore(),
                                                child: ListView(
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  children: [
                                                    topCardGridView(),
                                                    SizedBox(height: 10.px),
                                                    taskCardListView(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            )
                          : CW.commonNoNetworkView();
                    }),
                  ),
                ],
              ),
              floatingActionButton: addTaskFloatingActionButtonView(),
            ),
          );
        }),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
        title: controller.menuName.value,
        onLeadingPressed: () => controller.clickOnBackButton(),
        padding: EdgeInsets.only(left: 12.px, right: 6.px, top: 12.px, bottom: 6.px),
        actionValue: true,
        action: CW.commonIconButton(
            onPressed: () async {
              controller.hideSearchFieldValue.value =
                  !controller.hideSearchFieldValue.value;
              controller.taskSearchController.clear();
              controller.count.value++;
              controller.taskCategoryList.clear();
              controller.offset.value = 0;
              controller.apiResValue.value = true;
              await controller.callingGetTaskDataApi();
            },
            isAssetImage: false,
            icon: controller.hideSearchFieldValue.value
                ? Icons.search_off
                : Icons.search,
            color: Col.inverseSecondary),
      );

  Widget taskSearchTextFieldView() => CW.commonTextField(
        isBorder: true,
        isSearchLabelText: true,
        hintText: 'Search Task Category',
        controller: controller.taskSearchController,
        onChanged: (value) => controller.taskSearchOnChange(value: value),
        focusNode: controller.focusNodeTaskSearch,
        suffixIcon: controller.taskSearchController.text.isNotEmpty
            ? SizedBox(
                width: 24.px,
                height: 24.px,
                child: InkWell(
                  onTap: () async {
                    controller.taskSearchController.clear();
                    controller.count.value++;
                    controller.taskCategoryList.clear();
                    controller.offset.value = 0;
                    controller.apiResValue.value = true;
                    await controller.callingGetTaskDataApi();
                  },
                  child: Center(
                    child: CW.commonNetworkImageView(
                        path: 'assets/icons/cancel_white_icon.png',
                        color: Col.primary,
                        isAssetImage: true,
                        width: 12.px,
                        height: 12.px),
                  ),
                ),
              )
            : const SizedBox(),
        prefixIconPath: 'assets/icons/search_icon.png',
      );

  Widget subTitleTextView({required String text, double? fontSize}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, fontSize: fontSize,color: Col.inverseSecondary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget cardTitleTextView({required String text, Color? color, double? fontSize}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontSize: fontSize ?? 10.px, fontWeight: FontWeight.w600, color: color),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget topCardGridView() => GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.topGridCardColorList.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.3),
        itemBuilder: (context, index) {
          controller.topGridCardSubTitleTextList.clear();
          controller.topGridCardSubTitleTextList.insert(
              0, controller.getTaskDataModal.value?.totalCompleteTask != null && controller.getTaskDataModal.value!.totalCompleteTask!.isNotEmpty
                  ? '${controller.getTaskDataModal.value?.totalCompleteTask}'
                  : '0');
          controller.topGridCardSubTitleTextList.insert(
              1, controller.getTaskDataModal.value?.totalDueTask != null && controller.getTaskDataModal.value!.totalDueTask!.isNotEmpty
                  ? '${controller.getTaskDataModal.value?.totalDueTask}'
                  : '0');
          controller.topGridCardSubTitleTextList.insert(
              2, controller.getTaskDataModal.value?.totalTodayDueTask != null && controller.getTaskDataModal.value!.totalTodayDueTask!.isNotEmpty
                  ? '${controller.getTaskDataModal.value?.totalTodayDueTask}'
                  : '0');
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.px),
            ),
            color: controller.topGridCardColorList[index],
            child: Padding(
              padding: EdgeInsets.all(6.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CW.commonNetworkImageView(
                    path: controller.cardIconsList[index],
                    isAssetImage: true,
                    color: controller.topGridCardTextColorList[index],
                    height: 20.px,
                    width: 20.px,
                  ),
                  SizedBox(height: 5.px),
                  cardTitleTextView(
                      text: controller.topGridCardTitleTextList[index],
                      color: controller.topGridCardTextColorList[index]),
                  SizedBox(height: 2.px),
                  subTitleTextView(
                      text: controller.topGridCardSubTitleTextList[index],
                      fontSize: 14.px)
                ],
              ),
            ),
          );
        },
      );

  Widget taskCardListView() {
    if (controller.taskCategoryList.isNotEmpty) {
      double commonLinearProgressBarValue = 0.0;
      return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.taskCategoryList.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, taskCardListViewIndex) {
          if (controller.taskCategoryList[taskCardListViewIndex].taskPercentage != null && controller.taskCategoryList[taskCardListViewIndex].taskPercentage!.isNotEmpty) {
            commonLinearProgressBarValue = double.parse('${controller.taskCategoryList[taskCardListViewIndex].taskPercentage}') / 100;
          }
          return InkWell(
            onTap: () => controller.clickOnTaskCard(taskCardListViewIndex: taskCardListViewIndex),
            borderRadius: BorderRadius.circular(6.px),
            child: Card(
              color: Col.gCardColor,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.px)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 12.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    subTitleTextView(
                        text: controller.taskCategoryList[taskCardListViewIndex].taskCategoryName != null && controller.taskCategoryList[taskCardListViewIndex].taskCategoryName!.isNotEmpty
                            ? '${controller.taskCategoryList[taskCardListViewIndex].taskCategoryName}'
                            : 'Task Name Not Found!',
                        fontSize: 14.px),
                    SizedBox(height: 10.px),
                    Row(
                      children: [
                        Expanded(
                          child: CW.commonLinearProgressBar(
                              value: commonLinearProgressBarValue,
                              height: 5.px),
                        ),
                        SizedBox(width: 10.px),
                        cardTitleTextView(
                          text: controller.taskCategoryList[taskCardListViewIndex].taskPercentage != null && controller.taskCategoryList[taskCardListViewIndex].taskPercentage!.isNotEmpty
                              ? '${controller.taskCategoryList[taskCardListViewIndex].taskPercentage}%'
                              : '0%',
                          color: Col.primary,
                        )
                      ],
                    ),
                    SizedBox(height: 10.px),
                    taskCardGridView(taskCardListViewIndex: taskCardListViewIndex),
                    if (controller.taskCategoryList[taskCardListViewIndex].isEditAllow == true || controller.taskCategoryList[taskCardListViewIndex].isDeleteAllow == true)
                      SizedBox(height: 10.px),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (controller.taskCategoryList[taskCardListViewIndex].isEditAllow ?? false)
                          commonCardButtonView(
                            iconPath: 'assets/icons/edit_pen2_icon.png',
                            onTap: () => controller.clickOnAddNewTaskButton(taskCardListViewIndex: taskCardListViewIndex),
                            iconColor: Col.primary
                          ),
                        SizedBox(width: 10.px),
                        if (controller.taskCategoryList[taskCardListViewIndex].isDeleteAllow ?? false)
                          commonCardButtonView(
                            iconPath: 'assets/icons/delete_icon.png',
                            iconColor: Col.error,
                            onTap: () => controller.clickOnTaskDeleteButton(taskCardListViewIndex: taskCardListViewIndex),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return CW.commonNoDataFoundText();
    }
  }

  Widget commonCardButtonView({GestureTapCallback? onTap, Color? iconColor, required String iconPath}) => InkWell(
        borderRadius: BorderRadius.circular(6.px),
        onTap: onTap,
        child: Ink(
          width: 26.px,
          height: 26.px,
          decoration: BoxDecoration(
              color: Col.primary.withOpacity(.1),
              borderRadius: BorderRadius.circular(4.px)),
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

  Widget taskCardGridView({required int taskCardListViewIndex}) {
    controller.taskCountList = controller.taskCategoryList[taskCardListViewIndex].taskCount ?? [];
    if (controller.taskCountList != null && controller.taskCountList!.isNotEmpty) {
      return GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.taskCountList?.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 3.2,mainAxisSpacing: 8.px,crossAxisSpacing: 8.px),
        itemBuilder: (context, gridViewIndex) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.px),
              color: controller.taskCountList?[gridViewIndex].color == '' || controller.taskCountList?[gridViewIndex].color == null && controller.taskCountList![gridViewIndex].color!.isNotEmpty
                  ? Col.primaryWithOpacity
                  : CW.apiColorConverterMethod(colorString: controller.taskCountList?[gridViewIndex].color ?? '',colorCodeWithHundredPerValue: false),
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cardTitleTextView(
                  text: '${controller.taskCountList?[gridViewIndex].name}: ${controller.taskCountList?[gridViewIndex].count}',
                  color: controller.taskCountList?[gridViewIndex].color == '' || controller.taskCountList?[gridViewIndex].color == null && controller.taskCountList![gridViewIndex].color!.isNotEmpty
                      ? Col.primary
                      : CW.apiColorConverterMethod(colorString: controller.taskCountList?[gridViewIndex].color ?? ''),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget shimmerView() => ListView(
        physics: const ScrollPhysics(),
        children: [
          GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.2,
                crossAxisSpacing: 10.px,
                mainAxisSpacing: 10.px),
            itemBuilder: (context, index) => CW.commonShimmerViewForImage(),
          ),
          SizedBox(height: 16.px),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, taskCardListViewIndex) {
              return Card(
                color: Col.gCardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.px)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.px, vertical: 12.px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CW.commonShimmerViewForImage(height: 24.px, width: 150.px),
                      SizedBox(height: 10.px),
                      Row(
                        children: [
                          CW.commonShimmerViewForImage(height: 2.5.px, width: 280.px),
                          SizedBox(width: 10.px),
                          CW.commonShimmerViewForImage(height: 10.px, width: 20.px, radius: 2.px)
                        ],
                      ),
                      SizedBox(height: 10.px),
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2.8,
                            mainAxisSpacing: 10.px,
                            crossAxisSpacing: 10.px),
                        itemBuilder: (context, taskCardGridViewIndex) => CW.commonShimmerViewForImage(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );

  Widget addTaskFloatingActionButtonView() => CW.commonFloatingActionButton(icon: Icons.add, onPressed: () => controller.clickOnAddNewTaskButton());

}
