import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/promotion_controller.dart';

class PromotionView extends GetView<PromotionController> {
  const PromotionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: 'Promotion',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton()),
      body: ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.symmetric(vertical: 20.px),
        itemBuilder: (context, index) {
          return Padding(
            padding:  EdgeInsets.only(bottom: 16.px),
            child: cardView(),
          );
        },
      ),
    );
  }

  Widget cardView() => Container(
        margin: EdgeInsets.symmetric(horizontal: 12.px),
        decoration: BoxDecoration(
            color: Col.inverseSecondary,
            boxShadow: [BoxShadow(color: Col.gray, blurRadius: .08)],
            borderRadius: BorderRadius.circular(6.px)),
        child: Padding(
          padding: EdgeInsets.all(12.px),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cardImageView(),
                  borderView(),
                ],
              ),
              SizedBox(width: 6.px),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 6.px),
                    Text(
                      'Dollop Infotech',
                      style: Theme.of(Get.context!).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 16.px),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Ui/Ux Designer',
                            style: Theme.of(Get.context!)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 6.px),
                        Icon(
                          Icons.verified,
                          color: Col.success,
                          size: 14.px,
                        )
                      ],
                    ),
                    Text(
                      'Aug 2023 - Present (3 m)',
                      style: Theme.of(Get.context!)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                              color: Col.textGrayColor,
                              fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Indore, India',
                      style: Theme.of(Get.context!)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 12.px),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Full time',
                      style: Theme.of(Get.context!)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 12.px),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget cardImageView() => Container(
        width: 34.px,
        height: 34.px,
        decoration: BoxDecoration(color: Col.orange, shape: BoxShape.circle),
        child: Center(
          child: CW.commonNetworkImageView(
              path: 'assets/images/achievements_image.png',
              isAssetImage: true,
              width: 22.px,
              height: 22.px),
        ),
      );

  Widget borderView() => Padding(
        padding: EdgeInsets.only(left: 18.px, top: 2.px),
        child: Container(
          width: 24.px,
          height: 16.px,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              left: BorderSide(color: Col.success, width: 3.px),
              bottom: BorderSide(color: Col.success, width: 3.px),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.px),
            ),
          ),
        ),
      );
}
