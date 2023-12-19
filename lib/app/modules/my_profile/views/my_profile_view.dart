import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';

import '../controllers/my_profile_controller.dart';

class MyProfileView extends GetView<MyProfileController> {
  const MyProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CW.commonAppBarView(
            title: 'My Profile',
            isLeading: true,
            onBackPressed: () => controller.clickOnBackButton()),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
              child: Column(
                children: [
                  Row(
                    children: [
                      profileImageView(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            nameTextView(),
                            SizedBox(height: 2.px),
                            userDetailTextView(),
                          ],
                        ),
                      ),
                      editButtonView()
                    ],
                  ),
                  SizedBox(height: 20.px),
                  commonRowForEmailAndNumber(title: 'Mobile Number', name: '+91 1234567890'),
                  SizedBox(height: 6.px),
                  commonRowForEmailAndNumber(title: 'Email', name: 'testing.dollop@gmai.com'),
                ],
              ),
            ),
            reportingPersonListView(),
            SizedBox(height: 20.px),
            listView(),
            SizedBox(height: 30.px),
          ],
        ),
    );
  }

  Widget profileImageView() => Container(
        width: 66.px,
        height: 66.px,
        margin: EdgeInsets.only(right: 12.px),
        decoration: BoxDecoration(color: Col.primary, shape: BoxShape.circle),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(31.px),
            child: CW.commonNetworkImageView(
                path: 'assets/images/profile.png',
                isAssetImage: true,
                width: 62.px,
                height: 62.px),
          ),
        ),
      );

  Widget nameTextView() => Text('Testing Dollop',
      style: Theme.of(Get.context!).textTheme.displayLarge,
      maxLines: 1,
      overflow: TextOverflow.ellipsis);

  Widget userDetailTextView() => Text('Ui/Ux Designer',
      style: Theme.of(Get.context!).textTheme.titleMedium,
      maxLines: 1,
      overflow: TextOverflow.ellipsis);

  Widget editButtonView() => CW.commonIconButton(
      onPressed: () => controller.clickOnEditButton(),
      isAssetImage: true,
      imagePath: 'assets/icons/edit_icon.png',
      width: 40.px,
      size: 40.px);

  Widget commonRowForEmailAndNumber({required String title, required String name}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            child: Text(
              title,
              style: Theme.of(Get.context!)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
          ),
          Flexible(
            flex: 7,
            child: Text(
              name,
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      );

  Widget commonCardForList({required Widget listWidget, required String titleText, bool viewAllButtonValue = false, VoidCallback? onPressedViewAllButton}) => Card(
        margin: EdgeInsets.symmetric(horizontal: 12.px, vertical: 0.px),
        color: Col.inverseSecondary,
        shadowColor: Col.secondary.withOpacity(.1),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Col.gray.withOpacity(.5)),
            borderRadius: BorderRadius.circular(12.px)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(titleText != '')
            Padding(
              padding: EdgeInsets.only(left: 12.px, right: 12.px, top: viewAllButtonValue ? 8.px : 16.px),
              child: Row(
                mainAxisAlignment: viewAllButtonValue ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
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

  Widget commonCard({required String imagePath,required String text1,String? text2,bool text2Value = false,double? imageWidth, double? imageHeight,double? cardHeight}) => Ink(
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
            ClipRRect(
              borderRadius: BorderRadius.circular(27.px),
              child: Image.asset(
                imagePath,
                width: imageWidth??54.px,
                height: imageHeight??54.px,
              ),
            ),
            SizedBox(height: 6.px),
            Flexible(
              child: Text(
                 text1,
                style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(fontSize: 14.px),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            if(text2Value)
            SizedBox(height: 2.px),
            if(text2Value)
            Flexible(
              child: Text(
                text2 ??"",
                style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );

  Widget reportingPersonListView() => commonCardForList(
        titleText: 'Reporting Person',
        listWidget: CW.commonGridView(
          height: 124.px,
          externalPadding: EdgeInsets.only(top: C.margin, bottom: 0.px),
          length: controller.titleList.length,
          child: (index) {
            final cellWidth = MediaQuery.of(Get.context!).size.width / 2;
            return SizedBox(
              width: cellWidth - 14.px,
              child: Padding(
                padding: EdgeInsets.only(
                    left: index % 2 == 0 ? C.margin : C.margin / 2,
                    right: index % 2 == 0 ? C.margin / 2 : C.margin ,
                    top: 0,
                    bottom: C.margin),
                child: commonCard(imagePath: 'assets/images/profile.png',text2Value: true,text1: 'Testing Dollop',text2: 'Ui/Ux Designer',cardHeight: 124.px),
              ),
            );
          },
        ),
      );

  Widget listView() => commonCardForList(
        titleText: '',
        listWidget: CW.commonGridView(
          height: 124.px,
          externalPadding: EdgeInsets.only(top: C.margin, bottom: 0.px),
          length: controller.titleList.length,
          child: (index) {
            final cellWidth = MediaQuery.of(Get.context!).size.width / 3;
            return SizedBox(
              width: cellWidth - 8.px,
              child: Padding(
                padding: EdgeInsets.only(
                    left: index % 3 == 0 ? C.margin : C.margin / 3,
                    right: index % 3 == 3 - 1 ? C.margin : C.margin / 3,
                    top: 0,
                    bottom: C.margin),
                child: commonCard(imageHeight: 30.px,imageWidth: 30.px,imagePath: 'assets/images/shoping_dark.png',text1: 'Testing Dollop',cardHeight: 100.px),
              ),
            );
          },
        ),
      );

}
