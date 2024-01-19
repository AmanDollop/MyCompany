import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../../../../api/api_constants/ac.dart';
import '../controllers/document_controller.dart';

class DocumentView extends GetView<DocumentController> {
  const DocumentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: controller.profileMenuName.value,
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton()),
      body: Obx(() {
        controller.count.value;
        return ModalProgress(
            inAsyncCall: controller.apiResValue.value,
            child: Obx(() {
              controller.count.value;
              if (controller.documentModal.value != null) {
                if (controller.getDocumentDetails != null &&
                    controller.getDocumentDetails!.isNotEmpty) {
                  return GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
                    itemCount: controller.getDocumentDetails?.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 130.px,
                        crossAxisSpacing: 14.px,
                        mainAxisSpacing: 14.px),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => controller.clickOnDocument(index: index,context: context),
                        borderRadius: BorderRadius.circular(6.px),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Col.inverseSecondary,
                            boxShadow: [
                              BoxShadow(color: Col.gray, blurRadius: .5)
                            ],
                            borderRadius: BorderRadius.circular(6.px),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(6.px),
                                  topLeft: Radius.circular(6.px),
                                ),
                                child: controller.getDocumentDetails![index].documentFile!.contains('.pdf')
                                    ? SizedBox(
                                      height: 84.px,
                                      width: double.infinity,
                                      child: SfPdfViewer.network(
                                        '${AU.baseUrlAllApisImage}${controller.getDocumentDetails?[index].documentFile}',
                                        enableDoubleTapZooming: false,
                                        canShowPageLoadingIndicator:false,
                                        canShowScrollStatus:false,
                                        controller: controller.pdfControllerList[controller.getDocumentDetails![index].documentFile],
                                        onPageChanged: (details) {
                                          if (!details.isFirstPage) {
                                            controller.pdfControllerList[controller.getDocumentDetails![index].documentFile]?.jumpToPage(1);
                                          }
                                        },
                                        canShowScrollHead: false,
                                      ),
                                    )
                                    : CW.commonNetworkImageView(
                                        path: '${AU.baseUrlAllApisImage}${controller.getDocumentDetails?[index].documentFile}',
                                        isAssetImage: false,
                                        height: 84.px,
                                        width: double.infinity,
                                        fit: BoxFit.contain),
                              ),
                              SizedBox(height: 10.px),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.px),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CW.commonNetworkImageView(path: 'assets/icons/gallery_icon.png', isAssetImage: true,width: 16.px,height: 16.px),
                                    SizedBox(width: 6.px),
                                    Flexible(
                                      child: Text(
                                        controller.getDocumentDetails?[index].documentName != null &&
                                        controller.getDocumentDetails![index].documentName!.isNotEmpty
                                            ? '${controller.getDocumentDetails?[index].documentName}'
                                            : 'No data found!',
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(width: 6.px),
                                    InkWell(
                                      onTap: () => controller.clickOnMenuButton(context: context, index: index),
                                      child: CW.commonNetworkImageView(
                                          path: 'assets/icons/menu_icon.png',
                                          isAssetImage: true,
                                          height: 16.px),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.px),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return CW.commonNoDataFoundText();
                }
              } else {
                return CW.commonNoDataFoundText(
                    text: controller.apiResValue.value ? '' : 'No data found!');
              }
            }));
      }),
      floatingActionButton: controller.accessType.value != '1' &&
          controller.isChangeable.value != '1'
          ? Padding(
        padding: EdgeInsets.only(bottom: 10.px),
        child: CW.commonOutlineButton(
            onPressed: () => controller.clickOnAddViewButton(),
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
      )
          : const SizedBox(),
    );
  }
}
