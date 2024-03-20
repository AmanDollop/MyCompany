import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/circular_detail_controller.dart';

class CircularDetailView extends GetView<CircularDetailController> {
  const CircularDetailView({Key? key}) : super(key: key);
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
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 24.px),
                    children: [
                      cardView(),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
    title: 'Circulars Detail',
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
          padding: EdgeInsets.symmetric(horizontal: 12.px,vertical: 6.px),
          child: cardTitleTextView(text: '${controller.circularList?.title}'),
        ),
        CW.commonDividerView(color: Col.gray),
        SizedBox(height: 6.px),
        Padding(
          padding: EdgeInsets.only(left: 12.px,right: 12.px,bottom: 12.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cardDetailTextView(text:'${controller.circularList?.description}',),
              SizedBox(height: 12.px),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        cardTitleTextView(text: '${controller.circularList?.createdByName}'),
                        SizedBox(height: 6.px),
                        cardDateTextView(text:'${controller.circularList?.createdDate}'),
                      ],
                    ),
                  )
                ],
              )
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
            color: Col.inverseSecondary,
        ),
      },
    );
  }

  Widget cardDateTextView({required String text}) => Text(
    text,
    style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontSize: 10.px,color: Col.inverseSecondary),
  );

}
