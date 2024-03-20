import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_packages/load_more/lm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/work_report_controller.dart';

class WorkReportView extends GetView<WorkReportController> {
  const WorkReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              appBarView(),
              Expanded(
                child: Obx(() {
                  controller.count.value;
                  if (AC.isConnect.value) {
                    return CW.commonRefreshIndicator(
                      onRefresh: () => controller.onRefresh(),
                      child: ModalProgress(
                        inAsyncCall: controller.apiResValue.value,
                        child: controller.apiResValue.value
                            ? shimmerView()
                            : LM(
                              noMoreWidget: const SizedBox(),
                              isLastPage: controller.isLastPage.value,
                              onLoadMore: () => controller.onLoadMore(),
                              child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(child: startTextField()),
                                        SizedBox(width: 24.px),
                                        Expanded(child: endTextField())
                                      ],
                                    ),
                                    SizedBox(height: 12.px),
                                    controller.getWorkReportModal.value != null
                                        ? controller.workReportList.isNotEmpty
                                            ? ListView.builder(
                                                itemCount: controller.workReportList.length,
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    margin: EdgeInsets.only(bottom: 10.px),
                                                    decoration: BoxDecoration(
                                                    color: Col.gCardColor,
                                                       borderRadius: BorderRadius.circular(6.px)
                                                     ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(10.px),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                controller.workReportList[index].workReportDate != null && controller.workReportList[index].workReportDate!.isNotEmpty
                                                                    ? CMForDateTime.dateFormatForDateMonthYear(date: '${controller.workReportList[index].workReportDate}')
                                                                    : 'Data not found!',
                                                                style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600,color: Col.inverseSecondary),
                                                              ),
                                                              InkWell(
                                                                onTap: () => controller.clickOnViewMoreButton(index: index),
                                                                child: Text(
                                                                  'View More',
                                                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: Col.primary),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 8.px),
                                                          Text(
                                                            controller.workReportList[index].workReport != null && controller.workReportList[index].workReport!.isNotEmpty
                                                                ? '${controller.workReportList[index].workReport}'
                                                                : 'Data not found!',
                                                            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 10.px,color: Col.gTextColor),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          if(controller.workReportList[index].workReportDate != null && controller.workReportList[index].workReportDate!.isNotEmpty)
                                                          SizedBox(height: 2.px),
                                                          if(controller.workReportList[index].workReportDate != null && controller.workReportList[index].workReportDate!.isNotEmpty)
                                                          Text(
                                                            'Submitted Date : ${CMForDateTime.dateFormatForDateMonthYear(date: '${controller.workReportList[index].workReportDate}')}',
                                                            style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 10.px,color: Col.gTextColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            : CW.commonNoDataFoundText()
                                        : CW.commonNoDataFoundText()
                                  ],
                                ),
                            ),
                      ),
                    );
                  } else {
                    return CW.commonNoNetworkView();
                  }
                }),
              ),
            ],
          ),
          floatingActionButton: addWorkReportFloatingActionButtonView(),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
    title: controller.menuName.value,
    onLeadingPressed: () => controller.clickOnBackButton(),
    padding: EdgeInsets.only(left: 12.px,right: 6.px,top: 12.px,bottom: 6.px),
  );

  Widget startTextField() => SizedBox(
        height: 40.px,
        child: CW.commonTextField(
          borderRadius: 6.px,
          controller: controller.startController,
          focusNode: controller.focusNodeStart,
          labelText: 'Start Date',
          hintText: 'Start Date',
          prefixIconPath: 'assets/icons/dob_icon.png',
          onChanged: (value) {
            controller.count.value++;
          },
          onTap: () => controller.clickOnStartTextField(),
          readOnly: true,
        ),
      );

  Widget endTextField() => SizedBox(
        height: 40.px,
        child: CW.commonTextField(
          borderRadius: 6.px,
          controller: controller.endController,
          focusNode: controller.focusNodeEnd,
          labelText: 'End Date',
          hintText: 'End Date',
          prefixIconPath:  'assets/icons/dob_icon.png',
          onChanged: (value) {
            controller.count.value++;
          },
          onTap: () => controller.clickOnEndTextField(),
          readOnly: true,
        ),
      );

  Widget addWorkReportFloatingActionButtonView() => CW.commonFloatingActionButton(icon: Icons.add, onPressed: () => controller.clickOnAddWorkReportButton());

  Widget shimmerView() => ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
        children: [
          Row(
            children: [
              Expanded(child: CW.commonShimmerViewForImage(height: 40.px)),
              SizedBox(width: 24.px),
              Expanded(child: CW.commonShimmerViewForImage(height: 40.px))
            ],
          ),
          SizedBox(height: 12.px),
          ListView.builder(
            itemCount: 20,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                color: Col.gCardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.px)),
                child: Padding(
                  padding: EdgeInsets.all(8.px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CW.commonShimmerViewForImage(height: 16.px, width: 100.px, radius: 2.px),
                          CW.commonShimmerViewForImage(height: 16.px, width: 60.px, radius: 2.px),
                        ],
                      ),
                      SizedBox(height: 5.px),
                      CW.commonShimmerViewForImage(height: 12.px, width: 80.px, radius: 2.px),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      );
}
