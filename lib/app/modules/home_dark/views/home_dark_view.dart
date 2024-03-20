import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/home_dark_controller.dart';

class HomeDarkView extends GetView<HomeDarkController> {
  const HomeDarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.4],
          tileMode: TileMode.decal,
          // stops: [],
          // stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Col.gTop,
            Col.gBottom,
            // Colors.red,
            // Col.yellow
          ],
        ),
      ),
      child:  Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 12.px,vertical: 16.px),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CW.commonNetworkImageView(
                          path: 'assets/icons/drawer_menu_icon.png',
                          isAssetImage: true,
                          height: 24.px,
                          width: 24.px,
                        color: Col.inverseSecondary
                      ),
                      SizedBox(width: 10.px),
                      CW.commonNetworkImageView(
                          path: 'assets/images/logo.png',
                          isAssetImage: true,
                          height: 24.px,
                          width: 24.px),
                      SizedBox(width: 5.px),
                      Text(
                        'Hello, Rashmi',
                        style:Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 16.px),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 44.px,
                    width: 44.px,
                    child: Center(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(22.px),
                        child: Center(
                          child: CW.commonNetworkImageView(
                              path: 'assets/icons/notification_iocn.png',
                              isAssetImage: true,
                              width: 44.px,
                              height: 44.px),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
