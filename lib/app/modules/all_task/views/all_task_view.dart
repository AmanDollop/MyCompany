import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/modules/all_task/controllers/all_task_controller.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';

class AllTaskView extends GetView<AllTaskController> {
  const AllTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CM.unFocusKeyBoard();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CW.commonAppBarView(
          title: controller.menuName.value,
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton(),
        ),
        body: Obx(() {
          controller.count.value;
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.px, horizontal: 12.px),
            child: Column(
              children: [
                taskSearchTextFieldView(),
                SizedBox(height: 16.px),
                controller.apiResValue.value
                    ? Expanded(
                        child: shimmerView(),
                      )
                    : Expanded(
                        child: ModalProgress(
                          inAsyncCall: controller.apiResValue.value,
                          child: ListView(
                            physics: const ScrollPhysics(),
                            children: [
                              topCardGridView(),
                              SizedBox(height: 16.px),
                              taskCardListView(),
                              SizedBox(height: 8.h)
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          );
        }),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 10.px),
          child: CW.commonOutlineButton(
              onPressed: () => controller.clickOnAddNewTaskButton(),
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
        ),
      ),
    );
  }

  Widget taskSearchTextFieldView() => CW.commonTextField(
        isBorder: true,
        isSearchLabelText: true,
        hintText: 'Search Task',
        controller: controller.taskSearchController,
        onChanged: (value) => controller.taskSearchOnChange(value: value),
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

  Widget subTitleTextView({required String text, double? fontSize}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .labelSmall
            ?.copyWith(fontWeight: FontWeight.w600, fontSize: fontSize),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget cardTitleTextView({required String text, Color? color, double? fontSize}) =>
      Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
            fontSize: fontSize ?? 10.px,
            fontWeight: FontWeight.w600,
            color: color),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget topCardGridView() => GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.topGridCardColorList.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.2),
        itemBuilder: (context, index) {
          controller.topGridCardSubTitleTextList.clear();
          controller.topGridCardSubTitleTextList.insert(0, controller.getTaskDataModal.value?.totalCompleteTask!=null&&controller.getTaskDataModal.value!.totalCompleteTask!.isNotEmpty?'${controller.getTaskDataModal.value?.totalCompleteTask}':'0');
          controller.topGridCardSubTitleTextList.insert(1, controller.getTaskDataModal.value?.totalDueTask!=null&&controller.getTaskDataModal.value!.totalDueTask!.isNotEmpty?'${controller.getTaskDataModal.value?.totalDueTask}':'0');
          controller.topGridCardSubTitleTextList.insert(2, controller.getTaskDataModal.value?.totalTodayDueTask!=null&&controller.getTaskDataModal.value!.totalTodayDueTask!.isNotEmpty?'${controller.getTaskDataModal.value?.totalTodayDueTask}':'0');
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
                  subTitleTextView(text: controller.topGridCardSubTitleTextList[index], fontSize: 14.px)
                ],
              ),
            ),
          );
        },
      );

  Widget taskCardListView() {
    if (controller.taskDataList != null && controller.taskDataList!.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.taskDataList?.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, taskCardListViewIndex) {
          return Card(
            color: Col.inverseSecondary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.px)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 12.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subTitleTextView(
                      text: controller.taskDataList?[taskCardListViewIndex].taskCategoryName != null &&
                              controller.taskDataList![taskCardListViewIndex].taskCategoryName!.isNotEmpty
                          ? '${controller.taskDataList?[taskCardListViewIndex].taskCategoryName}'
                          : 'Task Name Not Found!',
                      fontSize: 14.px),
                  SizedBox(height: 10.px),
                  Row(
                    children: [
                      Expanded(
                        child: CW.commonLinearProgressBar(value: .5, height: 5.px),
                      ),
                      SizedBox(width: 10.px),
                      cardTitleTextView(text: '40%', color: Col.primary)
                    ],
                  ),
                  SizedBox(height: 10.px),
                  taskCardGridView(taskCardListViewIndex:taskCardListViewIndex),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return CW.commonNoDataFoundText();
    }
  }

  Widget taskCardGridView({required int taskCardListViewIndex}) {
    controller.cardGridTitleTextList.clear();
    controller.cardGridTitleTextList.insert(0, 'Total Task : ${controller.taskDataList?[taskCardListViewIndex].totalTaskCount}');
    controller.cardGridTitleTextList.insert(1, 'Completed : ${controller.taskDataList?[taskCardListViewIndex].completeTaskCount}');
    controller.cardGridTitleTextList.insert(2, 'Pending : ${controller.taskDataList?[taskCardListViewIndex].pendingTaskCount}');
    controller.cardGridTitleTextList.insert(3, 'In Progress : ${controller.taskDataList?[taskCardListViewIndex].inprogressTaskCount}');
    controller.cardGridTitleTextList.insert(4, 'On Hold : ${controller.taskDataList?[taskCardListViewIndex].onholdTaskCount}');
    controller.cardGridTitleTextList.insert(5, 'Cancelled : ${controller.taskDataList?[taskCardListViewIndex].cancelTaskCount}');
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.cardGridTitleTextList.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2.8),
      itemBuilder: (context, gridViewIndex) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.px),
          ),
          color: Col.gray.withOpacity(.2.px),
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.all(6.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cardTitleTextView(
                    text: controller.cardGridTitleTextList[gridViewIndex],
                    color: controller.cardGridTextColorList[gridViewIndex]),
              ],
            ),
          ),
        );
      },
    );
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
                color: Col.inverseSecondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.px)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.px, vertical: 12.px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CW.commonShimmerViewForImage(
                          height: 24.px, width: 150.px),
                      SizedBox(height: 10.px),
                      Row(
                        children: [
                          CW.commonShimmerViewForImage(
                              height: 2.5.px, width: 280.px),
                          SizedBox(width: 10.px),
                          CW.commonShimmerViewForImage(
                              height: 10.px, width: 20.px, radius: 2.px)
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
                        itemBuilder: (context, taskCardGridViewIndex) =>
                            CW.commonShimmerViewForImage(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
}
