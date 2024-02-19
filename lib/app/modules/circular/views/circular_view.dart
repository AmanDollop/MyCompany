import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_packages/load_more/lm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/circular_controller.dart';
import 'package:flutter_html/flutter_html.dart';


class CircularView extends GetView<CircularController> {
  const CircularView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return GestureDetector(
        onTap: () {
          CM.unFocusKeyBoard();
        },
        child: Scaffold(
          appBar: CW.commonAppBarView(
              title: controller.menuName.value,
              isLeading: true,
              onBackPressed: () => controller.clickOnBackButton(),
              actions: [
                CW.commonIconButton(onPressed: () {
                  controller.hideSearchFieldValue.value = !controller.hideSearchFieldValue.value;
                  controller.searchController.clear();
                }, isAssetImage: false,icon: controller.hideSearchFieldValue.value
                    ? Icons.search_off
                    : Icons.search,color: Col.inverseSecondary),
                SizedBox(width: 10.px)
              ]
          ),
          body: Obx(() {
            controller.count.value;
            return ModalProgress(
              inAsyncCall: controller.apiResValue.value,
              isLoader: false,
              child: controller.apiResValue.value
                  ? shimmerView()
                  : Obx(() {
                controller.count.value;
                if(controller.circularDetailModal.value != null){
                  return CW.commonRefreshIndicator(
                    onRefresh: () => controller.onRefresh(),
                    child: LM(
                      noMoreWidget: const SizedBox(),
                      isLastPage: controller.isLastPage.value,
                      onLoadMore: () => controller.onLoadMore(),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(left: 12.px,right: 12.px, top: 16.px),
                        children: [
                          AnimatedCrossFade(
                            firstChild: const SizedBox(),
                            secondChild: circularSearchTextFieldView(),
                            crossFadeState: controller.hideSearchFieldValue.value
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 500),
                          ),
                          if(controller.hideSearchFieldValue.value)
                            SizedBox(height: 16.px),
                          Row(
                            children: [
                              Expanded(child: startTextField()),
                              SizedBox(width: 24.px),
                              Expanded(child: endTextField())
                            ],
                          ),
                          controller.circularList.isNotEmpty
                              ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.circularList.length,
                            padding: EdgeInsets.only(top: 20.px),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: index!=controller.circularList.length-1?14.px:0),
                                child: cardView(index: index),
                              );
                            },
                          )
                              : SizedBox(
                            height: 60.h,
                            child: CW.commonNoDataFoundText(),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else {
                  return CW.commonNoDataFoundText(text: controller.apiResValue.value?'':'No Data Found!');
                }
              }),
            );
          }),
        ),
      );
    });
  }

  Widget commonIconImage({required String imagePath, double? height, double? width}) => SizedBox(
        width: height ?? 22.px,
        height: width ?? 22.px,
        child: Center(
          child: CW.commonNetworkImageView(
              path: imagePath,
              isAssetImage: true,
              width: width ?? 22.px,
              height: height ?? 22.px),
        ),
      );

  Widget circularSearchTextFieldView() => CW.commonTextField(
    isBorder: true,
    isSearchLabelText: true,
    hintText: 'Search Circular',
    controller: controller.searchController,
    onChanged: (value) => controller.searchOnChange(value: value),
    suffixIcon: controller.searchController.text.isNotEmpty
        ? SizedBox(
      width: 24.px,
      height: 24.px,
      child: InkWell(
        onTap: () {
          controller.searchController.clear();
          controller.count.value++;
        },
        child: Center(
          child: CW.commonNetworkImageView(
              path: 'assets/icons/cancel_white_icon.png',
              color: Col.text,
              isAssetImage: true,
              width: 12.px,
              height: 12.px),
        ),
      ),
    )
        : const SizedBox(),
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

  Widget startTextField() => SizedBox(
        height: 40.px,
        child: CW.commonTextField(
          borderRadius: 6.px,
          fillColor: Colors.transparent,
          controller: controller.startController,
          labelText: 'Start Date',
          hintText: 'Start Date',
          prefixIcon: commonIconImage(imagePath: 'assets/icons/dob_icon.png'),
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
          fillColor: Colors.transparent,
          controller: controller.endController,
          labelText: 'End Date',
          hintText: 'End Date',
          prefixIcon: commonIconImage(imagePath: 'assets/icons/dob_icon.png'),
          onChanged: (value) {
            controller.count.value++;
          },
          onTap: () => controller.clickOnEndTextField(),
          readOnly: true,
        ),
      );

  Widget cardView({required int index}) {
    return Container(
      decoration: BoxDecoration(
          color: Col.inverseSecondary,
          borderRadius: BorderRadius.circular(6.px),
          boxShadow: [BoxShadow(color: Col.gray, blurRadius: 2.px)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.px, right: 12.px),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cardTitleTextView(text: '${controller.circularList[index].title}'),
                viewMoreButtonView(index: index),
              ],
            ),
          ),
          CW.commonDividerView(color: Col.gray),
          SizedBox(height: 6.px),
          Padding(
            padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 12.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cardDetailTextView(
                  text: '${controller.circularList[index].description}',
                ),
                SizedBox(height: 12.px),
                imageView(index:index),
                SizedBox(height: 12.px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          cardTitleTextView(text: '${controller.circularList[index].createdByName}'),
                          SizedBox(height: 6.px),
                          cardDateTextView(text: '${controller.circularList[index].createdDate}')
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardTitleTextView({required String text, TextAlign? textAlign}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleLarge,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
      );

  Widget viewMoreButtonView({required int index}) => CW.commonTextButton(
        onPressed: () => controller.clickOnViewMoreButton(index: index),
        child: Text(
          'View More',
          style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
                color: Col.primary,
                fontWeight: FontWeight.w600,
              ),
        ),
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
            color: Col.secondary,
            maxLines: 2,
          textOverflow: TextOverflow.ellipsis
        ),
      },
    );
  }

  Widget imageView({required int index}) {
    controller.docType.value = CM.getDocumentTypeLogo(fileType: CM.getDocumentType(filePath: '${controller.circularList[index].attachment}'));
    print('controller.docType.value:::: ${controller.docType.value}');
    return InkWell(
      onTap: () => controller.clickOnImageView(index:index),
      child: CW.commonNetworkImageView(
          path: controller.docType.value == 'Image'?'${AU.baseUrlAllApisImage}${controller.circularList[index].attachment}':controller.docType.value,
          isAssetImage: controller.docType.value == 'Image'?false:true,
          height: 40.px,
          width: 40.px),
    );
  }



  Widget cardDateTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontSize: 10.px),
      );

  Widget shimmerView()=> ListView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: EdgeInsets.only(left: 12.px,right: 12.px, top: 12.px),
    children: [
     CW.commonShimmerViewForImage(height: 44.px),
      SizedBox(height: 16.px),
      Row(
        children: [
          Expanded(child: CW.commonShimmerViewForImage(height: 44.px),),
          SizedBox(width: 24.px),
          Expanded(child: CW.commonShimmerViewForImage(height: 44.px),),
        ],
      ),
      SizedBox(height: 16.px),
      ListView.builder(padding: EdgeInsets.zero,physics: const NeverScrollableScrollPhysics(),itemCount: 3,shrinkWrap: true,itemBuilder: (context, index) => Container(
        margin: EdgeInsets.only(bottom: 14.px),
        decoration: BoxDecoration(
            color: Col.inverseSecondary,
            borderRadius: BorderRadius.circular(6.px),
            boxShadow: [BoxShadow(color: Col.gray, blurRadius: 2.px)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12.px, right: 12.px,top: 10.px),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CW.commonShimmerViewForImage(height: 25.px,width: 200.px),
                  CW.commonShimmerViewForImage(height: 20.px,width: 80.px),
                ],
              ),
            ),
            CW.commonDividerView(color: Col.gray),
            SizedBox(height: 6.px),
            Padding(
              padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 12.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CW.commonShimmerViewForImage(height: 16.px,width: double.infinity.px),
                  SizedBox(height: 5.px),
                  CW.commonShimmerViewForImage(height: 16.px,width: 250.px),
                  SizedBox(height: 12.px),
                  CW.commonShimmerViewForImage(height: 40.px,width: 40.px),
                  SizedBox(height: 12.px),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CW.commonShimmerViewForImage(height: 20.px,width: 100.px),
                            SizedBox(height: 6.px),
                            CW.commonShimmerViewForImage(height: 20.px,width: 150.px)
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),)
    ],
  );

}
