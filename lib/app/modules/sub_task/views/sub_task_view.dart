import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
      onTap: () {
        CM.unFocusKeyBoard();
      },
      child: Scaffold(
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
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.px, horizontal: 12.px),
                    child: Column(
                      children: [
                        subTaskSearchTextFieldView(),
                        SizedBox(height: 16.px),
                        controller.apiResValue.value
                            ? Expanded(
                                child: SubTaskShimmerView.shimmerView(),
                              )
                            : Expanded(
                                child: ListView(
                                  physics: const ScrollPhysics(),
                                  children: [
                                    Card(
                                      color: Col.inverseSecondary,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.px)),
                                      child: Padding(
                                        padding: EdgeInsets.all(4.px),
                                        child: filterCardGridView(),
                                      ),
                                    ),
                                    SizedBox(height: 16.px),
                                    subTaskCardListView(),
                                    SizedBox(height: 8.h)
                                  ],
                                ),
                              ),
                      ],
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
        hintText: 'Search Sub Task',
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

  Widget subTitleTextView({required String text, double? fontSize}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .labelSmall
            ?.copyWith(fontWeight: FontWeight.w600, fontSize: fontSize),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget cardTitleTextView({required String text, Color? color, double? fontSize}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
            fontSize: fontSize ?? 10.px,
            fontWeight: FontWeight.w600,
            color: color),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget filterCardGridView() {
    if(controller.getSubTaskFilterDataModal.value != null){
      if(controller.subTaskFilterList != null && controller.subTaskFilterList!.isNotEmpty){
        return GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.subTaskFilterList?.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 2.6),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => controller.clickOnSubTaskFilterCard(index:index),
              borderRadius: BorderRadius.circular(6.px),
              child: Container(
                margin: EdgeInsets.all(4.px),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: controller.filterValueList[index] == controller.subTaskFilterList?[index].taskStatusName
                          ? CW.apiColorConverterMethod(colorString: '${controller.subTaskFilterList?[index].taskStatusColor}')
                          : Colors.transparent,
                      width: 1.px),
                  borderRadius: BorderRadius.circular(6.px),
                  color: controller.filterValueList[index] == controller.subTaskFilterList?[index].taskStatusName
                      ? CW.apiColorConverterMethod(colorString: '${controller.subTaskFilterList?[index].taskStatusColor}').withOpacity(.2)
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
                            color: controller.filterValueList[index] == controller.subTaskFilterList?[index].taskStatusName
                                ? CW.apiColorConverterMethod(colorString: '${controller.subTaskFilterList?[index].taskStatusColor}')
                                : Col.gray.withOpacity(.5),
                            shape: BoxShape.circle),
                      ),
                      SizedBox(width: 4.px),
                      cardTitleTextView(
                          text: '${controller.subTaskFilterList?[index].taskStatusName}',
                          color: controller.filterValueList.value == controller.subTaskFilterList?[index].taskStatusName
                              ? Col.primary
                              : Col.secondary),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }else{
        return const SizedBox();
      }
    }else{
      return const SizedBox();
    }
  }

  Widget subTaskCardListView() => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => Card(
          color: Col.inverseSecondary,
          margin: EdgeInsets.only(bottom: 10.px, left: 0.px, right: 0.px, top: 0.px),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.px)),
          child: InkWell(
            onTap: () => controller.clickOnCard(index:index),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 44.px,
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Col.primary.withOpacity(.1),
                    border: Border.all(color: Col.primary, width: 1.px),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6.px),
                      topLeft: Radius.circular(6.px),
                    ),
                  ),
                  padding: EdgeInsets.only(left: 10.px),
                  child: Row(
                    children: [
                      cardTitleTextView(text: 'Sub Task Name', fontSize: 14.px),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.px),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50.px,
                        height: 50.px,
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: Col.primary.withOpacity(.1),
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                                image: AssetImage('assets/images/profile.png'),
                                fit: BoxFit.cover)),
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
                                    text: 'Assign By', color: Col.gray),
                                cardTitleTextView(
                                    text: '05:38, 31st Jan 2024',
                                    color: Col.gray),
                              ],
                            ),
                            subTitleTextView(text: 'Rashmi Rajput'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                CW.commonDividerView(
                    height: 0.px, color: Col.gray.withOpacity(.5)),
                Padding(
                  padding: EdgeInsets.all(10.px),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                cardTitleTextView(
                                    text: 'Start Date', color: Col.gray),
                                subTitleTextView(text: '05:38 AM, 31 Jan 2024'),
                              ],
                            ),
                            SizedBox(height: 10.px),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                cardTitleTextView(
                                    text: 'Due Date', color: Col.gray),
                                subTitleTextView(text: '05:38 AM, 31 Jan 2024'),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                ),
                CW.commonDividerView(
                    height: 0.px, color: Col.gray.withOpacity(.5)),
                Padding(
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
                                cardTitleTextView(
                                    text: 'Priority', color: Col.gray),
                                Row(
                                  children: [
                                    Container(
                                      height: 10.px,
                                      width: 10.px,
                                      decoration: BoxDecoration(
                                          color: Col.gray.withOpacity(.5),
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(width: 4.px),
                                    cardTitleTextView(
                                        text: 'High', color: Col.secondary),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 10.px),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                cardTitleTextView(
                                    text: 'Status', color: Col.gray),
                                Row(
                                  children: [
                                    Container(
                                      height: 10.px,
                                      width: 10.px,
                                      decoration: BoxDecoration(
                                          color: Col.gray.withOpacity(.5),
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(width: 4.px),
                                    cardTitleTextView(
                                        text: 'Pending', color: Col.secondary),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.px),
                  child: Row(
                    children: [
                      commonCardButtonView(
                          iconPath: 'assets/icons/edit_pen2_icon.png'),
                      SizedBox(width: 10.px),
                      commonCardButtonView(
                          iconPath: 'assets/icons/delete_icon.png',
                          iconColor: Col.error),
                      SizedBox(width: 10.px),
                      commonCardButtonView(
                          iconPath: 'assets/icons/time_line_icon.png'),
                      SizedBox(width: 10.px),
                      commonCardButtonView(
                          iconPath: 'assets/icons/document_icon.png'),
                      SizedBox(width: 10.px),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget commonCardButtonView({GestureTapCallback? onTap, Color? iconColor, required String iconPath}) => InkWell(
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
