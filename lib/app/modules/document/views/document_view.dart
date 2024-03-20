import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/gradient_image_convert.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../../../../api/api_constants/ac.dart';
import '../controllers/document_controller.dart';

class DocumentView extends GetView<DocumentController> {
  const DocumentView({Key? key}) : super(key: key);

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
                  return AC.isConnect.value
                      ? CW.commonRefreshIndicator(
                        onRefresh: () => controller.onRefresh(),
                        child: ModalProgress(
                        inAsyncCall: controller.apiResValue.value,
                        child: controller.apiResValue.value
                            ? shimmerView()
                            : Obx(() {
                                controller.count.value;
                                if (controller.documentModal.value != null) {
                                  if (controller.getDocumentDetails != null && controller.getDocumentDetails!.isNotEmpty) {
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: GridView.builder(
                                            padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
                                            itemCount: controller.getDocumentDetails?.length,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisExtent: 135.px,
                                                    crossAxisSpacing: 14.px,
                                                    mainAxisSpacing: 14.px),
                                            itemBuilder: (context, index) {
                                              controller.docType.value = CM.getDocumentType(filePath: '${controller.getDocumentDetails?[index].documentFile}');
                                              controller.docTypeLogo.value = CM.getDocumentTypeLogo(fileType: controller.docType.value);
                                              return InkWell(
                                                onTap: () => controller.clickOnDocument(index: index, context: context),
                                                borderRadius: BorderRadius.circular(6.px),
                                                child: Ink(
                                                  decoration: BoxDecoration(
                                                    color: Col.gCardColor,
                                                    borderRadius: BorderRadius.circular(6.px),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(6.px),
                                                          topLeft: Radius.circular(6.px),
                                                        ),
                                                        child: controller.docType.value == 'PDF'
                                                            ? SizedBox(
                                                                height: 84.px,
                                                                width: double.infinity,
                                                                child: SfPdfViewer.network(
                                                                  '${AU.baseUrlAllApisImage}${controller.getDocumentDetails?[index].documentFile}',
                                                                  enableDoubleTapZooming: false,
                                                                  canShowPageLoadingIndicator: false,
                                                                  canShowScrollStatus: false,
                                                                  controller: controller.pdfControllerList[controller.getDocumentDetails![index].documentFile],
                                                                  onPageChanged: (details) {
                                                                    if (!details.isFirstPage) {
                                                                      controller.pdfControllerList[controller.getDocumentDetails![index].documentFile]?.jumpToPage(1);
                                                                    }
                                                                  },
                                                                  canShowScrollHead: false,
                                                                ),
                                                              )
                                                            : controller.docType.value == 'Image'
                                                            ? CW.commonNetworkImageView(
                                                                path: '${AU.baseUrlAllApisImage}${controller.getDocumentDetails?[index].documentFile}',
                                                                isAssetImage: false,
                                                                height: 84.px,
                                                                width: double.infinity,
                                                                fit: BoxFit.contain)
                                                            : CW.commonNetworkImageView(
                                                                path: controller.docTypeLogo.value,
                                                                isAssetImage: true,height: 84.px,
                                                                width: double.infinity,
                                                                fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.px),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 6.px),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            GradientImageWidget(
                                                                assetPath: 'assets/icons/gallery_icon.png',
                                                                // isAssetImage: true,
                                                                width: 16.px,
                                                                height: 16.px),
                                                            SizedBox(width: 6.px),
                                                            Flexible(
                                                              child: Text(
                                                                controller.getDocumentDetails?[index].documentName != null && controller.getDocumentDetails![index].documentName!.isNotEmpty
                                                                    ? '${controller.getDocumentDetails?[index].documentName}'
                                                                    : 'No data found!',
                                                                style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500,color: Col.inverseSecondary),
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                            SizedBox(width: 6.px),
                                                            InkWell(
                                                              onTap: () => controller.clickOnMenuButton(context: context, index: index),
                                                              child: GradientImageWidget(
                                                                  assetPath: 'assets/icons/menu_icon.png',
                                                                  // isAssetImage: true,
                                                                  height: 16.px),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // SizedBox(height: 5.px),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 60.px)
                                      ],
                                    );
                                  } else {
                                    return CW.commonNoDataFoundText();
                                  }
                                } else {
                                  return CW.commonNoDataFoundText(text: 'No data found!');
                                }
                              },
                           ),
                        ),
                      ) : CW.commonNoNetworkView();
                }),
              ),
            ],
          ),
          floatingActionButton: controller.accessType.value != '1' && controller.isChangeable.value != '1'
              ? CW.commonFloatingActionButton(icon: Icons.add, onPressed: () => controller.clickOnAddViewButton())
              : const SizedBox(),
        ),
      ),
    );
  }
  
  Widget appBarView() => CW.myAppBarView(
    title: controller.profileMenuName.value,
    onLeadingPressed: () => controller.clickOnBackButton(),
    padding: EdgeInsets.only(left: 12.px,right: 6.px,top: 12.px,bottom: 6.px),
  );

  Widget shimmerView() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 130.px,
          crossAxisSpacing: 14.px,
          mainAxisSpacing: 14.px),
      itemBuilder: (context, index) {
        return Ink(
          decoration: BoxDecoration(
            color: Col.gCardColor,
            boxShadow: [BoxShadow(color: Col.gray, blurRadius: .5)],
            borderRadius: BorderRadius.circular(6.px),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6.px),
                  topLeft: Radius.circular(6.px),
                ),
                child: CW.commonShimmerViewForImage(
                    height: 84.px, width: double.infinity),
              ),
              SizedBox(height: 10.px),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CW.commonShimmerViewForImage(width: 16.px, height: 16.px),
                    SizedBox(width: 6.px),
                    CW.commonShimmerViewForImage(
                        width: 100.px, height: 16.px),
                    SizedBox(width: 6.px),
                    CW.commonShimmerViewForImage(width: 5.px, height: 16.px),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
