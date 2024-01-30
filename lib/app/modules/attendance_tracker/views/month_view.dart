import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/modules/attendance_tracker/controllers/attendance_tracker_controller.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

class MonthView extends GetView<AttendanceTrackerController> {
  const MonthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((){
      controller.count.value;
      return ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              commonDropDownView(dropDownView: monthDropDownView(),),
              SizedBox(width: 10.px),
              commonDropDownView(dropDownView: yearDropDownView(),),
            ],
          ),
          SizedBox(height: 20.px),
          getDayNames(),
          SizedBox(height: 20.px),
          buildDaysGrid(),
          SizedBox(height: 10.px),
          circularProgressBarView(),
          SizedBox(height: 10.px),
          cardGridView(),
        ],
      );
    });
  }

  Widget commonDropDownView({required Widget dropDownView}) => Expanded(
    child: Container(
      decoration: BoxDecoration(
          color: Col.gray.withOpacity(.3),
          borderRadius: BorderRadius.circular(6.px)
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: dropDownView,
            ),
            Icon(Icons.arrow_drop_down,color: Col.darkGray)
          ],
        ),
      ),
    ),
  );

  Widget monthDropDownView() => DropdownButton<String>(
    value: controller.monthNameValue.value,
    icon:  const Icon(Icons.arrow_drop_down,color: Colors.transparent),
    style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600,),
    underline: Container(
      height: 0,
      color: Colors.transparent,
    ),
    onChanged: (String? value) => controller.monthDropDownOnChanged(value:value??''),
    items: controller.monthNameList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value,style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600,),),
      );
    }).toList(),
  );

  Widget yearDropDownView() => DropdownButton<String>(
    value: controller.yearValue.value,
    icon:  const Icon(Icons.arrow_drop_down,color: Colors.transparent),
    style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600,),
    underline: Container(
      height: 0,
      color: Colors.transparent,
    ),
    onChanged: (String? value) => controller.yearDropDownOnChanged(value:value??''),
    items: controller.yearList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value,style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600,),),
      );
    }).toList(),
  );

  Widget commonCircularProgressBar({required double value}) {
    return CircularProgressIndicator(
      strokeWidth: 8.px,
      value: .5,
      backgroundColor: Col.primary.withOpacity(.2),
      strokeCap: StrokeCap.round,
    );
  }

  Widget circularProgressBarView() => Row(
    children: [
      SizedBox(
        height: 150.px,
        width: 150.px,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 130.px,
                width: 130.px,
                child: commonCircularProgressBar(value: 0.0),
              ),
            ),
            SizedBox(
              width: 120.px,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  titleTextView(text: 'Total time', color: Col.secondary),
                  SizedBox(height: 2.px),
                  subTitleTextView(text: '140 hr'),
                  SizedBox(height: 5.px),
                  titleTextView(
                      text: 'Monthly Hours Spent', color: Col.secondary),
                  SizedBox(height: 2.px),
                  subTitleTextView(text: '170 hr')
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(width: 15.px),
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleTextView(text: 'Total Productive Time'),
            SizedBox(height: 2.px),
            subTitleTextView(text: '50hr 50 min.'),
            SizedBox(height: 5.px),
            titleTextView(text: 'Total Extra Time'),
            SizedBox(height: 2.px),
            subTitleTextView(text: '50hr 50 min.'),
            SizedBox(height: 5.px),
            titleTextView(text: 'Total Remaining Time'),
            SizedBox(height: 2.px),
            subTitleTextView(text: '50 min.'),
          ],
        ),
      ),
    ],
  );

  Widget titleTextView({required String text, Color? color}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontSize: 10.px, color: color),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget subTitleTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600,),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget cardTitleTextView({required String text, Color? color}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontSize: 10.px,fontWeight: FontWeight.w600, color: color),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget cardGridView() => GridView.builder(
    itemCount: controller.cardColorList.length,
    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 4.px,crossAxisSpacing: 4.px,childAspectRatio: 1.2),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) => Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.px),
      ),
      color: controller.cardColorList[index],
      child: Padding(
        padding:  EdgeInsets.all(6.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CW.commonNetworkImageView(path: 'assets/icons/e_icon.png', isAssetImage: true,height: 20.px,width: 20.px,color: controller.cardTextColorList[index]),
            SizedBox(height: 5.px),
            cardTitleTextView(text: controller.cardTitleTextList[index],color: controller.cardTextColorList[index]),
            SizedBox(height: 2.px),
            subTitleTextView(text: '2')
          ],
        ),
      ),
    ),
  );

  Widget getDayNames() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (var day in controller.days)
          Text(
            day,
            style: Theme.of(Get.context!).textTheme.titleLarge,
          ),
      ],
    );
  }

  Widget buildDaysGrid() {

    var daysInMonth = DateTime(controller.currentMonth.value.year, controller.currentMonth.value.month + 1, 0).day;
    day(DateTime(controller.currentMonth.value.year, controller.currentMonth.value.month + 1, 1));

    var  t = '1-${controller.currentMonth.value.month}-${controller.currentMonth.value.year}';
    DateTime parsedDate = DateFormat("d-M-yyyy").parse(t);

    var extra = parsedDate.weekday==7?0:parsedDate.weekday;

    daysInMonth = daysInMonth+extra;

    controller.monthTotalDaysListDataAdd();

    for(var i=0; i < extra;i++){
      controller.monthTotalDaysList.insert(0, 0);
    }

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: daysInMonth,
      itemBuilder: (context, index) {
        final day = controller.monthTotalDaysList[index];
        final date = DateTime(controller.currentMonth.value.year, controller.currentMonth.value.month, day);
        return day == 0
            ? const SizedBox()
            : Container(
          height: 36.px,
          width: 36.px,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                day.toString(),
                style: Theme.of(Get.context!).textTheme.labelMedium,
              ),
              Text(
                getDayName(date),
                style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontSize: 10.px),
              ),
            ],
          ),
        );
      },
    );
  }

  String getDayName(DateTime date) {
    day(date);
    return controller.dayValue.value;
  }

   void day(DateTime date) {
    DateTime now = date;
    int currentDay = now.weekday;

    switch (currentDay) {
      case DateTime.monday:
        controller.dayValue.value = 'Mon';
        break;
      case DateTime.tuesday:
        controller.dayValue.value = 'Tue';
        break;
      case DateTime.wednesday:
        controller.dayValue.value = 'Wed';
        break;
      case DateTime.thursday:
        controller.dayValue.value = 'Thu';
        break;
      case DateTime.friday:
        controller.dayValue.value = 'Fri';
        break;
      case DateTime.saturday:
        controller.dayValue.value = 'Sat';
        break;
      case DateTime.sunday:
        controller.dayValue.value = 'Sun';
        break;
      default:
        print('Failed to determine the current day');
        break;
    }
  }

}
