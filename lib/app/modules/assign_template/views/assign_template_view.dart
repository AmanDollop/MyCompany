import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';

import '../controllers/assign_template_controller.dart';

class AssignTemplateView extends GetView<AssignTemplateController> {
  const AssignTemplateView({Key? key}) : super(key: key);

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
                  if (AC.isConnect.value) {
                    return ModalProgress(
                        inAsyncCall: false,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
                          child: controller.getAssignTemplateModal.value != null
                              ? Column(
                                  children: [
                                    dateTextFormFiled(context: context),
                                    SizedBox(height: 14.px),
                                    controller.templateAssignList != null && controller.templateAssignList!.isNotEmpty
                                        ? Expanded(
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: controller.templateAssignList?.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 12.px),
                                                  margin: EdgeInsets.only(bottom: 10.px),
                                                  decoration: BoxDecoration(
                                                    color: Col.gCardColor,
                                                    borderRadius: BorderRadius.circular(6.px),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              controller.templateAssignList?[index].templateName != null && controller.templateAssignList![index].templateName!.isNotEmpty
                                                                  ? '${controller.templateAssignList?[index].templateName}'
                                                                  : 'No data found!',
                                                              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600,fontSize: 16.px),
                                                            ),
                                                          ),
                                                          Row(
                                                           children: [
                                                             SizedBox(width: 10.px),
                                                             if((controller.templateAssignList?[index].isSubmitted == true))
                                                             Container(
                                                               height: 20.px,
                                                               width: 20.px,
                                                               decoration: BoxDecoration(
                                                                 shape: BoxShape.circle,
                                                                 gradient: CW.commonLinearGradientForButtonsView()
                                                               ),
                                                               child: Center(
                                                                 child: Icon(Icons.check,color: Col.gBottom,size: 16.px),
                                                               ),
                                                             ),
                                                             if(controller.templateAssignList?[index].isSubmitted == false || (controller.templateAssignList?[index].isTemplateRequired == '1' && controller.templateAssignList?[index].isSubmitted == true))
                                                             SizedBox(width: 5.px),
                                                             if(controller.templateAssignList?[index].isSubmitted == false || (controller.templateAssignList?[index].isTemplateRequired == '1' && controller.templateAssignList?[index].isSubmitted == true))
                                                             InkWell(
                                                               onTap: () => controller.clickOnRightArrowButton(index:index),
                                                               child: CW.commonNetworkImageView(
                                                                 path: 'assets/icons/right_arrow_icon.png',
                                                                 isAssetImage: true,width: 24.px,height: 24.px,
                                                               ),
                                                             )
                                                           ],
                                                         )
                                                        ],
                                                      ),
                                                      if(controller.templateAssignList?[index].templateDescription != null && controller.templateAssignList![index].templateDescription!.isNotEmpty)
                                                      SizedBox(height: 4.px),
                                                      if(controller.templateAssignList?[index].templateDescription != null && controller.templateAssignList![index].templateDescription!.isNotEmpty)
                                                       CW.commonReadMoreText(value: '${controller.templateAssignList?[index].templateDescription}'),
                                                      if(controller.templateAssignList?[index].templateType != null && controller.templateAssignList![index].templateType!.isNotEmpty)
                                                      Container(
                                                        padding: EdgeInsets.all(6.px),
                                                        margin: EdgeInsets.only(top: 4.px),
                                                        decoration: BoxDecoration(
                                                          color: Col.primary.withOpacity(.2),
                                                          borderRadius: BorderRadius.circular(4.px)
                                                        ),
                                                        child: Text(
                                                          controller.templateAssignList?[index].templateType == '0'
                                                              ? 'Punch In'
                                                              : 'Punch Out',
                                                          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Col.primary,fontSize: 10.px),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : CW.commonNoDataFoundText()
                                  ],
                                )
                              : CW.commonNoDataFoundText(),
                        ),
                    );
                  } else {
                    return CW.commonNoNetworkView();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
        title: 'Assign Template',
        onLeadingPressed: () => controller.clickOnBackButton(),
        padding:
            EdgeInsets.only(left: 12.px, right: 6.px, top: 12.px, bottom: 6.px),
      );

  Widget dateTextFormFiled({required BuildContext context}) =>
      CW.commonTextField(
        labelText: 'Date',
        hintText: 'Date',
        controller: controller.dateController,
        focusNode: controller.focusNodeDate,
        validator: (value) =>
            V.isValid(value: value, title: 'Please select date'),
        suffixIcon: SizedBox(
          height: 22.px,
          width: 22.px,
          child: Center(
            child: CW.commonNetworkImageView(
                path: 'assets/icons/working_days_icon.png',
                isAssetImage: true,
                height: 22.px,
                width: 22.px,
                color: Col.gTextColor),
          ),
        ),
        readOnly: true,
        onTap: () => controller.clickOnDateTextFormFiled(context: context),
      );
}
