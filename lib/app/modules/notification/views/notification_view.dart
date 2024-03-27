import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              appBarView(),
              Obx(() {
                controller.count.value;
                return Expanded(
                  child: CW.commonRefreshIndicator(
                    onRefresh: () => controller.onRefresh(),
                    child: AC.isConnect.value
                        ? ModalProgress(
                            inAsyncCall: controller.apiResValue.value,
                            child: controller.apiResValue.value
                                ? shimmerView()
                                : controller.getNotificationModal.value != null
                                    ? controller.notificationList != null &&
                                            controller.notificationList!.isNotEmpty
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            padding: EdgeInsets.symmetric(vertical: 16.px, horizontal: 0.px),
                                            itemCount: controller.notificationList?.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () => controller.clickOnNotification(index: index),
                                                onLongPress: () => controller.clickOnDeleteNotificationButton(index: index),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Col.gCardColor,
                                                          border: Border.all(
                                                            width: .5.px,
                                                            color: Col.gray.withOpacity(.5),
                                                          ),
                                                          borderRadius: BorderRadius.circular(8.px),
                                                      ),
                                                      margin: EdgeInsets.symmetric(horizontal: 12.px),
                                                      child: ListTile(
                                                        leading: Container(
                                                          height: 45,
                                                          width: 42,
                                                          decoration: BoxDecoration(
                                                            color: Col.primaryWithOpacity,
                                                            borderRadius: BorderRadius.circular(8.px),
                                                          ),
                                                          child: Center(
                                                              child: CW.commonNetworkImageView(
                                                                  path: controller.notificationList?[index].notificationImage ?? '',
                                                                  isAssetImage: false,
                                                                  height: 30.px,
                                                                  width: 24.px),
                                                          ),
                                                        ),
                                                        horizontalTitleGap: 10.px,
                                                        dense: true,
                                                        title: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              flex: 4,
                                                              child: Text(
                                                                controller.notificationList?[index].notificationTitle != null && controller.notificationList![index].notificationTitle!.isNotEmpty
                                                                    ? '${controller.notificationList?[index].notificationTitle}'
                                                                    : '?',
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(
                                                                        fontWeight: FontWeight.w600,
                                                                        color: Col.inverseSecondary),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                  controller.notificationList?[index].notificationDate != null && controller.notificationList![index].notificationDate!.isNotEmpty
                                                                      ? CMForDateTime.dateFormatForDateMonthYearHourMinSec(
                                                                          dateAndTime: '${controller.notificationList?[index].notificationDate}')
                                                                      : '?',
                                                                  style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
                                                                          fontSize: 10.px,
                                                                          fontWeight: FontWeight.w500),
                                                                  maxLines: 1,
                                                                  textAlign: TextAlign.end),
                                                            ),
                                                          ],
                                                        ),
                                                        subtitle: Text(
                                                          controller.notificationList?[index].notificationDescription != null && controller.notificationList![index].notificationDescription!.isNotEmpty
                                                              ? '${controller.notificationList?[index].notificationDescription}'
                                                              : '?',
                                                          maxLines: 15,
                                                          style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
                                                                  fontSize: 10.px,
                                                                  fontWeight: FontWeight.w500),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 8.px),
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        : CW.commonNoDataFoundText()
                                    : CW.commonNoDataFoundText(),
                          )
                        : CW.commonNoNetworkView(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
        title: 'Notification',
        onLeadingPressed: () => controller.clickOnBackButton(),
        padding: EdgeInsets.only(left: 12.px, right: 6.px, top: 12.px, bottom: 6.px),
      );

  Widget shimmerView() => ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 16.px, horizontal: 0.px),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Col.gCardColor,
                    border: Border.all(
                      width: .5.px,
                      color: Col.gray.withOpacity(.5),
                    ),
                    borderRadius: BorderRadius.circular(8.px)),
                margin: EdgeInsets.symmetric(horizontal: 12.px),
                child: ListTile(
                  leading: Container(
                    height: 45,
                    width: 42,
                    decoration: BoxDecoration(
                      color: Col.primary.withOpacity(.2),
                      borderRadius: BorderRadius.circular(8.px),
                    ),
                    child: Center(
                      child: CW.commonShimmerViewForImage(
                          height: 20.px, width: 20.px),
                    ),
                  ),
                  horizontalTitleGap: 10.px,
                  dense: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: CW.commonShimmerViewForImage(
                            height: 16.px, radius: 2.px),
                      ),
                      SizedBox(width: 10.px),
                      Expanded(
                        flex: 2,
                        child: CW.commonShimmerViewForImage(
                            height: 16.px, radius: 2.px),
                      ),
                    ],
                  ),
                  subtitle: CW.commonShimmerViewForImage(
                      height: 10.px, width: double.infinity, radius: 2.px),
                ),
              ),
              SizedBox(height: 8.px),
            ],
          );
        },
      );
}
