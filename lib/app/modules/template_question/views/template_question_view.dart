import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/template_question_controller.dart';

class TemplateQuestionView extends GetView<TemplateQuestionController> {
  const TemplateQuestionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
        title: 'Template Question',
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
      ),
      body: Obx(() {
        controller.count.value;
        if (AC.isConnect.value) {
          return ModalProgress(
            inAsyncCall: false,
            child:  Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ListView(
                  padding: EdgeInsets.symmetric(horizontal: 12.px,vertical: 16.px),
                  children: const [

                  ],
                ),
                submitButtonView(),
              ],
            ),
          );
        } else {
          return CW.commonNoNetworkView();
        }
      }),
    );
  }

  Widget submitButtonView() {
    return Container(
      height: 80.px,
      padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
      color: Col.inverseSecondary,
      child: Center(
        child: CW.commonElevatedButton(
            onPressed:   controller.submitButtonValue.value
                ? () => null
                : () => controller.clickOnSubmitButton(),
            buttonColor:  Col.primary,
            buttonText: 'Submit',
            borderRadius: 10.px,
            isLoading: controller.submitButtonValue.value),
      ),
    );
  }

}
