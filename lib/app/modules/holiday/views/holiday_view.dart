import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/holiday_controller.dart';

class HolidayView extends GetView<HolidayController> {
  const HolidayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CW.commonAppBarView(
          title: controller.menuName.value,
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton(),
        ),
        body: Obx(() {
          controller.count.value;
          if(AC.isConnect.value){
            return ModalProgress(inAsyncCall: controller.apiResValue.value, child: Obx(() {
              controller.count.value;
              if(controller.getHolidayModal.value != null){
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.px),
                  child: Column(
                    children: [
                      SizedBox(height: 16.px),
                      Row(
                        children: [
                          commonDropDownView(
                            dropDownView: monthDropDownView(),
                          ),
                          SizedBox(width: 10.px),
                          commonDropDownView(
                            dropDownView: yearDropDownView(),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.px),
                      Expanded(
                        child: controller.holidayList != null && controller.holidayList!.isNotEmpty
                            ? ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: controller.holidayList?.length,
                          // Number of items in the list
                          itemBuilder: (BuildContext context, int index) {
                            return cardView(index:index);
                          },
                        )
                            : CW.commonNoDataFoundText(),
                      ),
                    ],
                  ),
                );
              }
              else{
                return CW.commonNoDataFoundText();
              }
            }),);
          }else{
            return CW.commonNetworkImageView(path: 'assets/images/no_internet_dialog.png', isAssetImage: true);
          }
        }),
    );
  }

  Widget commonDropDownView({required Widget dropDownView}) => Expanded(
        child: Container(
          height: 40.px,
          decoration: BoxDecoration(
              color: Col.gray.withOpacity(.3),
              borderRadius: BorderRadius.circular(6.px)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.px),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: dropDownView,
                ),
                Icon(Icons.arrow_drop_down, color: Col.darkGray)
              ],
            ),
          ),
        ),
      );

  Widget monthDropDownView() => DropdownButton<String>(
        value: controller.monthNameForMonthViewValue.value,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        onChanged: (String? value) =>
            controller.monthDropDownOnChanged(value: value ?? ''),
        items: controller.monthNameForMonthViewList
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          );
        }).toList(),
      );

  Widget yearDropDownView() => DropdownButton<String>(
        value: controller.yearForMonthViewValue.value,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        onChanged: (String? value) =>
            controller.yearDropDownOnChanged(value: value ?? ''),
        items: controller.yearForMonthViewList
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          );
        }).toList(),
      );

  Widget cardView({required int index}) => Container(
    margin: EdgeInsets.only(bottom: 12.px),
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(
      color: Col.inverseSecondary,
      borderRadius: BorderRadius.circular(6.px),
      boxShadow: [
        BoxShadow(
          color: Col.gray,
          blurRadius: .4,
        )
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dateAndMonthNameContainerView(index:index),
        holidayDetailView(index:index),
      ],
    ),
  );

  Widget dateAndMonthNameContainerView({required int index}) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 16.px),
        decoration: BoxDecoration(
          color: controller.randomColor[index],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.px),
            bottomLeft: Radius.circular(6.px),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            monthNameTextView(text: '1'),
            dateTextView(text: 'JAN'),
          ],
        ),
      ),
    );
  }

  Widget monthNameTextView({required String text}) => Text(
    text,
    style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
  );

  Widget dateTextView({required String text}) => Text(
    text,
    style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500),
  );

  Widget holidayDetailView({required int index}) => Expanded(
    flex: 7,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.px, vertical: 16.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          monthNameTextView(text: controller.holidayList?[index].holidayName!= null && controller.holidayList![index].holidayName!.isNotEmpty
              ? '${controller.holidayList?[index].holidayName}'
              : 'Not found!'),
          // SizedBox(height: 5.px),
          dateTextView(text: controller.holidayList?[index].holidayStartDate!= null && controller.holidayList![index].holidayStartDate!.isNotEmpty
              ? '${CMForDateTime.getDayNameFromDate(dateString: '${controller.holidayList?[index].holidayStartDate}')}   ${controller.holidayList?[index].holidayStartDate}'
              : 'Not found!'),
        ],
      ),
    ),
  );



}
