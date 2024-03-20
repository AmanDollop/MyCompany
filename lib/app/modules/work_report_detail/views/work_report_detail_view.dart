import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/work_report_detail_controller.dart';

class WorkReportDetailView extends GetView<WorkReportDetailController> {
  const WorkReportDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              appBarView(),
              Expanded(
                child: Obx(
                  () {
                    controller.count.value;
                    if (AC.isConnect.value) {
                      return ModalProgress(
                        inAsyncCall: false,
                        child: controller.getWorkReportDetailModal.value != null
                            ? controller.workDetails != null
                                ? ListView(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.px, vertical: 16.px),
                                    children: [
                                      cardView(),
                                    ],
                                  )
                                : CW.commonNoDataFoundText()
                            : CW.commonNoDataFoundText(),
                      );
                    } else {
                      return CW.commonNoNetworkView();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
    title: 'Work Report Detail',
    onLeadingPressed: () => controller.clickOnBackButton(),
    padding: EdgeInsets.only(left: 12.px,right: 6.px,top: 12.px,bottom: 6.px),
  );

  Widget cardView() => Container(
        decoration: BoxDecoration(
             color: Col.gCardColor,
             borderRadius: BorderRadius.circular(6.px),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 6.px),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: cardTitleTextView(text: '${controller.workDetails?.workReportDateView}'),
                  ),
                  Flexible(
                    child: cardDateTextView(text: '${controller.workDetails?.workReportDate}'),
                  ),
                ],
              ),
            ),
            CW.commonDividerView(),
            SizedBox(height: 6.px),
            Padding(
              padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 12.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cardDetailTextView(text: '${controller.workDetails?.workReport}'),
                  if(controller.workDetails?.workReportFile != null && controller.workDetails!.workReportFile!.isNotEmpty)
                  SizedBox(height: 12.px),
                  if(controller.workDetails?.workReportFile != null && controller.workDetails!.workReportFile!.isNotEmpty)
                  filesList()
                ],
              ),
            ),
          ],
        ),
      );

  Widget cardTitleTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: Col.inverseSecondary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget cardDetailTextView({required String text}) {
    return Html(
      data: text.trim(),
      shrinkWrap: false,
      style: {
        "body": Style(
            padding: HtmlPaddings.zero,
            margin: Margins.zero,
            fontFamily: "KumbhSans",
            fontSize: FontSize(10.px),
            fontWeight: FontWeight.w500,
            color: Col.inverseSecondary),
      },
    );
  }

  Widget cardDateTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontSize: 10.px,color: Col.gTextColor),
      );

  Widget filesList() {
    return SizedBox(
      height: 60.px,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.workDetails?.workReportFile?.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          print('controller.workDetails?.workReportFile::::: ${controller.workDetails?.workReportFile?[index]}');
          return Container(
            width: 60.px,
            padding: EdgeInsets.all(2.px),
            margin: EdgeInsets.only(right: 10.px),
            decoration: BoxDecoration(
                color: Col.primary.withOpacity(.05),
                borderRadius: BorderRadius.circular(4.px),
                border: Border.all(color: Col.primary,width: .5.px),
            ),
            child: imageView(index: index),
          );
        },
      ),
    );
  }

  Widget imageView({required int index}) {
    controller.docType.value = CM.getDocumentTypeLogo(fileType: CM.getDocumentType(filePath: '${controller.workDetails?.workReportFile?[index]}'));
    return InkWell(
      onTap: () => controller.clickOnImageView(index: index),
      child: CW.commonNetworkImageView(
          path: controller.docType.value == 'Image'
              ? '${AU.baseUrlAllApisImage}${controller.workDetails?.workReportFile?[index]}'
              :  controller.docType.value,
          isAssetImage: controller.docType.value == 'Image' ? false : true,
          height: 40.px,
          width: 40.px),
    );
  }

}
