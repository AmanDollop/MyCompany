import 'package:get/get_rx/get_rx.dart';

class CommonCalendarMethods{

  static final monthNameId = ''.obs;
  static final dayValue = ''.obs;

  static String getMonth({required String monthNameValue}) {

    if (monthNameValue == 'January') {
      monthNameId.value = '1';
    } else if (monthNameValue == 'February') {
      monthNameId.value = '2';
    } else if (monthNameValue == 'March') {
      monthNameId.value = '3';
    } else if (monthNameValue == 'April') {
      monthNameId.value = '4';
    } else if (monthNameValue == 'May') {
      monthNameId.value = '5';
    } else if (monthNameValue == 'June') {
      monthNameId.value = '6';
    } else if (monthNameValue == 'July') {
      monthNameId.value = '7';
    } else if (monthNameValue == 'August') {
      monthNameId.value = '8';
    } else if (monthNameValue == 'September') {
      monthNameId.value = '9';
    } else if (monthNameValue == 'October') {
      monthNameId.value = '10';
    } else if (monthNameValue == 'November') {
      monthNameId.value = '11';
    } else if (monthNameValue == 'December') {
      monthNameId.value = '12';
    } else {
      monthNameId.value = '0';
    }

    return monthNameId.value;

  }

  static DateTime getPreviousMonday(DateTime currentDate) {
    // Calculate the difference in days to the previous Monday
    int daysDifference = currentDate.weekday - DateTime.monday;
    print('currentDate.weekday::::: ${currentDate.weekday}');

    if (daysDifference < 0) {
      // If currentDate is already a Monday, set the difference to 0
      daysDifference = 0;
    }

    // Subtract the difference to get the DateTime for the previous Monday
    DateTime previousMonday = currentDate.subtract(Duration(days: daysDifference));

    return previousMonday;
  }

  static String day({required DateTime date}) {
    DateTime now = date;
    int currentDay = now.weekday;
    switch (currentDay) {
      case DateTime.monday:
        dayValue.value = 'Mon';
        break;
      case DateTime.tuesday:
        dayValue.value = 'Tue';
        break;
      case DateTime.wednesday:
        dayValue.value = 'Wed';
        break;
      case DateTime.thursday:
        dayValue.value = 'Thu';
        break;
      case DateTime.friday:
        dayValue.value = 'Fri';
        break;
      case DateTime.saturday:
        dayValue.value = 'Sat';
        break;
      case DateTime.sunday:
        dayValue.value = 'Sun';
        break;
      default:
        print('Failed to determine the current day');
        break;
    }
    return dayValue.value;
  }

}