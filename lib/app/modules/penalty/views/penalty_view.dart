import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_packages/load_more/lm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/penalty_controller.dart';

class PenaltyView extends GetView<PenaltyController> {
  const PenaltyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
        title: controller.menuName.value,
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
      ),
      body: CW.commonRefreshIndicator(
        onRefresh: () => controller.onRefresh(),
        child: Obx(
          () {
            controller.count.value;
            if (AC.isConnect.value) {
              return ModalProgress(
                inAsyncCall: controller.apiResValue.value,
                child: controller.apiResValue.value
                    ? shimmerView()
                    : controller.getPenaltyModal.value != null
                        ? controller.penaltyList.isNotEmpty
                            ? LM(
                                noMoreWidget: const SizedBox(),
                                isLastPage: controller.isLastPage.value,
                                onLoadMore: () => controller.onLoadMore(),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
                                  itemCount: controller.penaltyList.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: Col.inverseSecondary,
                                      margin: EdgeInsets.only(bottom: 10.px, left: 0.px, right: 0.px, top: 0.px),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6.px),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.px),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                dateTextView(index: index),
                                                paidAndUnPaidTextView(index: index),
                                              ],
                                            ),
                                            SizedBox(height: 2.px),
                                            penaltyDetailTextView(index: index),
                                            SizedBox(height: 5.px),
                                            penaltyAmountTextView(index: index),
                                            SizedBox(height: 5.px),
                                            if (controller.penaltyList[index].penaltyAttachment != null && controller.penaltyList[index].penaltyAttachment!.isNotEmpty)
                                              SizedBox(
                                                height: 50.px,
                                                child: penaltyImageListViewBuilder(index: index),
                                              )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: CW.commonNoDataFoundText(),
                              )
                        : Center(
                            child: CW.commonNoDataFoundText(),
                          ),
              );
            } else {
              return CW.commonNoNetworkView();
            }
          },
        ),
      ),
    );
  }

  Widget dateTextView({required int index}) => Text(
        'Date : ${CMForDateTime.dateFormatForDateMonthYear(date: '${DateTime.parse('${controller.penaltyList[index].penaltyDate}')}')}',
        style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontSize: 10.px),
      );

  Widget paidAndUnPaidTextView({required int index}) => Container(
        padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
        decoration: BoxDecoration(
            color: controller.penaltyList[index].paidStatus == '1'
                ? Col.success.withOpacity(.1)
                : Col.error.withOpacity(.1),
            borderRadius: BorderRadius.circular(4.px)),
        child: Text(
          '${controller.penaltyList[index].paidStatusView}',
          style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(
              color: controller.penaltyList[index].paidStatus == '1'
                  ? Col.success
                  : Col.error,
              fontSize: 10.px,
              fontWeight: FontWeight.w500),
        ),
      );

  Widget penaltyDetailTextView({required int index}) => CW.commonReadMoreText(value: '${controller.penaltyList[index].penaltyDescription}',maxLine: 4,);

  Widget penaltyAmountTextView({required int index}) => Text(
        controller.penaltyList[index].penaltyAmount != '0'
            ? 'Amount - ${controller.getCompanyDetails?.currency}${controller.penaltyList[index].penaltyAmount}'
            : '${controller.penaltyList[index].penaltyPercentage}%',
        style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      );

  Widget penaltyImageListViewBuilder({required int index}) {
    List<String> penaltyAttachment = controller.penaltyList[index].penaltyAttachment ?? [];
    return ListView.builder(
      itemCount: penaltyAttachment.length,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) => Padding(
        padding: EdgeInsets.only(right: 8.px),
        child: CW.commonNetworkImageView(
          path: '${AU.baseUrlAllApisImage}${penaltyAttachment[i]}',
          isAssetImage: false,
          height: 50.px,
          width: 50.px,
        ),
      ),
    );
  }

  Widget shimmerView() => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            color: Col.inverseSecondary,
            margin: EdgeInsets.only(bottom: 10.px, left: 0.px, right: 0.px, top: 0.px),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.px),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CW.commonShimmerViewForImage(width: 100.px, height: 14.px),
                      CW.commonShimmerViewForImage(width: 50.px, height: 18.px),
                    ],
                  ),
                  SizedBox(height: 5.px),
                  CW.commonShimmerViewForImage(width: double.infinity, height: 20.px),
                  SizedBox(height: 5.px),
                  CW.commonShimmerViewForImage(width: 160.px, height: 16.px),
                  SizedBox(height: 5.px),
                  SizedBox(
                    height: 50.px,
                    child: ListView.builder(
                      itemCount: 10,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) => Padding(
                        padding: EdgeInsets.only(right: 8.px),
                        child: CW.commonShimmerViewForImage(
                          height: 50.px,
                          width: 50.px,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
}
