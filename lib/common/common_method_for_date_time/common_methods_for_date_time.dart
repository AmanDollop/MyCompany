import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CMForDateTime {

  static String dateFormatForDateMonthYear({required String date}) {
    return DateFormat('dd MMM yyyy').format(DateTime.parse(date)); ///Todo output => 03 May 2002
  }

  static String timeFormatForHourMinuetAmPm({required String dateAndTime}) {
    return DateFormat('hh:mm a').format(DateTime.parse(dateAndTime)); ///Todo output => 05:40 PM
  }

  static String timeFormatForHourMinuetSecond({required String dateAndTime}) {
    return DateFormat('hh:mm:ss a').format(DateTime.parse(dateAndTime)); ///Todo output => 05:40:30 PM
  }

  static String timeFormatForDayNameMonthNameDate({required String dateAndTime}) {
    return DateFormat('EE, MMM dd').format(DateTime.parse(dateAndTime)); ///Todo output => 05:40:30 PM
  }

  static TimeOfDay convertToTimeOfDay({required String timeOfDay}) {
    List<String> parts = timeOfDay.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute); ///Todo output => TimeOfDay(18:49)
  }

  static String formatWithLeadingZeros(int value) {
    // Use padLeft to add leading zeros
    return value.toString().padLeft(2, '0');
  }

  static String formatTime(DateTime dateTime) {
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);
    return formattedTime;
  }

  static String dateTimeFormatForApi({required String dateTime}) {
    String formattedTime = DateFormat('yyyy-MM-dd').format(DateFormat('d MMM y').parse(dateTime));
    return formattedTime;
  }

  static String calculateTimeForHourAndMin({required String minute}) {
    String time = '0';
    if(int.parse(minute) ~/ 60 != 0 ){
      time = '${formatWithLeadingZeros(int.parse(minute) ~/ 60)} hr ${formatWithLeadingZeros(int.parse(minute) % 60)} min';
    }else if(int.parse(minute) % 60 != 0 ){
      time = '${formatWithLeadingZeros(int.parse(minute) % 60)} min';
    }else{
      time = '00 min';
    }
    return time; ///Todo output => { 0 hr 00 min || 00 min || NIL }
  }

  static String calculateTimeForHourAndMinFromDateTime({required String startDateTimeString,required String endDateTimeString}){
    DateTime startTime = DateTime.parse(startDateTimeString);
    DateTime endTime = DateTime.parse(endDateTimeString);

    if (endTime.isBefore(startTime)) {
      endTime = endTime.add(const Duration(days: 1)); // Add 24 hours
    }

    Duration difference = endTime.difference(startTime);

    int totalHours = difference.inHours;
    int totalMinutes = (difference.inMinutes % 60);
    int totalSeconds = (difference.inSeconds % 60);

    int formattedHours = totalHours % 12;
    String amPm = totalHours >= 12 ? 'pm' : 'am';
    // return '$formattedHours hr $totalMinutes min $totalSeconds sec $amPm';
    return '${formattedHours}hr ${totalMinutes}min'; ///Todo output => { 0 hr 00 min }
  }

  static String getDayNameFromDate({required String dateString}) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(dateString);
    String dayName = DateFormat('EEEE').format(date); ///Todo output => { Monday }
    return dayName;
  }

  static String getTimeFromDateFor24Hours({required String dateAndTimeString}) {
    DateTime dateTime = DateFormat("dd MMM yyyy hh:mm a").parse(dateAndTimeString);
    String outputDateTimeString = DateFormat("HH:mm:ss").format(dateTime);
    print('dateTime:::: $outputDateTimeString'); ///Todo output => { 14:04:00 }
    return outputDateTimeString;
  }

}
