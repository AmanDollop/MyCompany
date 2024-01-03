import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/social_info_controller.dart';

class SocialInfoView extends GetView<SocialInfoController> {
  const SocialInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CW.commonAppBarView(
            title: controller.profileMenuName.value,
            isLeading: true,
            onBackPressed: () => controller.clickOnBackButton()),
        body: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.title.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.px,
            mainAxisSpacing: 10.px,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8.px),
              child: commonCard(
                  imagePath: 'assets/images/shoping_dark.png',
                  isAssetImage: true,
                  text1: '${controller.title[index]}',
                  cardHeight: 100.px),
            );
          },
        ),
        floatingActionButton: controller.accessType.value != '1' && controller.isChangeable.value != '1'
            ? Padding(
                padding: EdgeInsets.only(bottom: 10.px),
                child: CW.commonOutlineButton(
                    onPressed: () => controller.clickOnEditViewButton(),
                    child: Icon(
                      Icons.edit,
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

  Widget commonCardForList({required Widget listWidget, required String titleText, bool viewAllButtonValue = false, VoidCallback? onPressedViewAllButton}) =>
      Card(
        margin: EdgeInsets.symmetric(horizontal: 12.px, vertical: 0.px),
        color: Col.inverseSecondary,
        shadowColor: Col.secondary.withOpacity(.1),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Col.gray.withOpacity(.5)),
            borderRadius: BorderRadius.circular(12.px)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (titleText != '')
              Padding(
                padding: EdgeInsets.only(
                    left: 12.px,
                    right: 12.px,
                    top: viewAllButtonValue ? 8.px : 16.px),
                child: Row(
                  mainAxisAlignment: viewAllButtonValue
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                      titleText,
                      style: Theme.of(Get.context!).textTheme.displayLarge,
                    ),
                  ],
                ),
              ),
            listWidget
          ],
        ),
      );

  Widget commonCard({required String imagePath, required String text1, String? text2, bool text2Value = false, bool isAssetImage = true, double? imageWidth, double? imageHeight, double? cardHeight, Gradient? gradient}) => Ink(
        height: cardHeight ?? 134.px,
        padding: EdgeInsets.only(left: 3.px),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 24.px,
              color: Col.secondary.withOpacity(.05),
            )
          ],
          color: Col.inverseSecondary,
          borderRadius: BorderRadius.circular(8.px),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // width: 44.px,
              // height: 44.px,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, gradient: gradient),
              child: Center(
                child: CW.commonNetworkImageView(
                  path: imagePath,
                  isAssetImage: isAssetImage,
                  width: imageWidth ?? 34.px,
                  height: imageHeight ?? 34.px,
                ),
              ),
            ),
            SizedBox(height: 6.px),
            Flexible(
              child: Text(
                text1,
                style: Theme.of(Get.context!)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontWeight: FontWeight.w700, fontSize: 10.px),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            // if (text2Value)
            // SizedBox(height: 4.px),
            if (text2Value)
              Flexible(
                child: Text(
                  text2 ?? "",
                  style: Theme.of(Get.context!)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      );

}
