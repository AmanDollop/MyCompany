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
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: Obx(() {
          controller.count.value;
          return Scaffold(
            body: Column(
              children: [
                appBarView(),
                Expanded(
                  child: AC.isConnect.value
                      ? controller.apiResValue.value
                          ? shimmerView()
                          : ModalProgress(
                              inAsyncCall: controller.apiResValue.value,
                              child: Obx(() {
                                controller.count.value;
                                if (controller.getHolidayModal.value != null) {
                                  return CW.commonRefreshIndicator(
                                    onRefresh: () => controller.onRefresh(),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.px),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 16.px),
                                          Expanded(
                                            child: controller.holidayList != null &&
                                                    controller.holidayList!.isNotEmpty
                                                ? ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    itemCount: controller.holidayList?.length,
                                                    // Number of items in the list
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return cardView(index: index);
                                                    },
                                                  )
                                                : controller.apiResValue.value
                                                    ? const SizedBox()
                                                    : CW.commonNoDataFoundText(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return controller.apiResValue.value
                                      ? const SizedBox()
                                      : CW.commonNoDataFoundText();
                                }
                              }),
                            )
                      : CW.commonNoNetworkView(),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
      title: controller.menuName.value,
      onLeadingPressed: () => controller.clickOnBackButton(),
      padding: EdgeInsets.only(left: 12.px, right: 6.px, top: 12.px, bottom: 6.px),
      actionValue: true,
      action: SizedBox(
        width: 120.px,
        child: commonDropDownView(
          onTap: () => controller.clickOnYear(),
          dropDownView: yearDropDownView(),
        ),
      ),
  );

  Widget commonDropDownView({required Widget dropDownView, required GestureTapCallback onTap}) => Container(
        height: 40.px,
        margin: EdgeInsets.only(right: 12.px),
        decoration: BoxDecoration(
            color: Col.inverseSecondary,
            borderRadius: BorderRadius.circular(6.px)),
        child: InkWell(
          onTap: onTap,
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

  Widget yearDropDownView() => Text(
        controller.yearForMonthViewValue.value,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      );

  /*Widget yearDropDownView() => DropdownButton<String>(
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
        items: controller.yearForMonthViewList.map<DropdownMenuItem<String>>((String value) {
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
      );*/

  Widget cardView({required int index}) => Container(
        margin: EdgeInsets.only(bottom: 12.px),
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Col.gCardColor,
          borderRadius: BorderRadius.circular(6.px),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dateAndMonthNameContainerView(index: index),
            holidayDetailView(index: index),
          ],
        ),
      );

  Widget dateAndMonthNameContainerView({required int index}) {
    Color? cardColor = controller.monthNameAndColors[controller.monthNameForCalender[index]];
    controller.isAfterDate.value = DateTime.now().isAfter(DateTime.parse('${controller.holidayList?[index].holidayStartDate}'));
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 16.px),
        decoration: BoxDecoration(
          color: controller.isAfterDate.value
              ? cardColor?.withOpacity(.2)
              : cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.px),
            bottomLeft: Radius.circular(6.px),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            monthNameTextView(
                text: controller.holidayList?[index].holidayStartDate != null && controller.holidayList![index].holidayStartDate!.isNotEmpty
                    ? CMForDateTime.formatWithLeadingZeros(DateTime.parse('${controller.holidayList?[index].holidayStartDate}').day)
                    : '?'),
            dateTextView(text: '${controller.monthNameForCalender[index]}'),
          ],
        ),
      ),
    );
  }

  Widget monthNameTextView({required String text, double? fontSize}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: controller.isAfterDate.value ? Col.gray : Col.inverseSecondary),
      );

  Widget dateTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 10.px,
            color: controller.isAfterDate.value ? Col.gray : Col.gTextColor),
      );

  Widget holidayDetailView({required int index}) => Expanded(
        flex: 7,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.px, vertical: 16.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              monthNameTextView(
                  text: controller.holidayList?[index].holidayName != null && controller.holidayList![index].holidayName!.isNotEmpty
                      ? '${controller.holidayList?[index].holidayName}'
                      : 'Not found!',
                  fontSize: 12.px),
              // SizedBox(height: 5.px),
              dateTextView(
                  text: controller.holidayList?[index].holidayStartDate != null && controller.holidayList![index].holidayStartDate!.isNotEmpty
                      ? CMForDateTime.getDayNameFromDate(
                          dateString: '${controller.holidayList?[index].holidayStartDate}')
                      : 'Not found!'),
            ],
          ),
        ),
      );

  Widget shimmerView() => ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
        itemBuilder: (context, index) {
          Color? cardColor = controller.getRandomColorForCards().withOpacity(.4);
          return Container(
            margin: EdgeInsets.only(bottom: 12.px),
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Col.gCardColor,
              borderRadius: BorderRadius.circular(6.px),
              boxShadow: [
                BoxShadow(
                  color: Col.gray,
                  blurRadius: .4,
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.px),
                      bottomLeft: Radius.circular(6.px),
                    ),
                  ),
                  child:
                      CW.commonShimmerViewForImage(height: 66.px, width: 66.px),
                ),
                SizedBox(width: 12.px),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CW.commonShimmerViewForImage(height: 22.px, width: 150.px),
                    SizedBox(height: 8.px),
                    CW.commonShimmerViewForImage(height: 16.px, width: 120.px),
                  ],
                ),
              ],
            ),
          );
        },
      );
}
