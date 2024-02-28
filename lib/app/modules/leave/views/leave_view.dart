import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/leave_controller.dart';

class LeaveView extends GetView<LeaveController> {
  const LeaveView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CW.commonAppBarView(title: controller.menuName.value,isLeading: true,onBackPressed: () => controller.clickOnBackButton()),
      body: Obx(() {
        controller.count.value;
        return ModalProgress(
          inAsyncCall: controller.apiResValue.value,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.px),
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Col.inverseSecondary,
                  borderRadius: BorderRadius.circular(10.px),
                  boxShadow: [
                    BoxShadow(
                        color: Col.primary.withOpacity(.2),
                        blurRadius: 1)
                  ],
                ),
                child: Column(
                  children: [
                    commonRowForCardView(),
                    commonRowForCardView(),
                    commonRowForCardView(),
                    commonRowForCardView(),
                  ],
                ),
              ),
            ],
          )
        );
      }),
      floatingActionButton: addFloatingActionButtonView(),
    );
  }

  Widget commonRowForCardView(){
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Text('data'),
      Text(':'),
      Text('data'),
      ],
    );
  }

  Widget addFloatingActionButtonView() => Padding(
    padding: EdgeInsets.only(bottom: 10.px),
    child: CW.commonOutlineButton(
        onPressed: () => controller.clickOnAddButton(),
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
  );

}
