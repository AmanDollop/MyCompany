import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CMForDateTime {

  static String dateFormatForDateMonthYearHourMinSec({required String dateAndTime}) {
    return DateFormat('dd MMM yyyy h:mm a').format(DateTime.parse(dateAndTime)); ///Todo Output: 27 Mar 2024 1:45 PM
  }

  static String dateFormatForDateMonthYear({required String date}) {
    return DateFormat('dd MMM yyyy').format(DateTime.parse(date)); ///Todo output => 03 Feb 2002
  }

  static String dateFormatForMonthYear({required String date}) {
    return DateFormat('MMMM yyyy').format(DateTime.parse(date)); ///Todo output => February 2002
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
    return outputDateTimeString; ///Todo output => { 14:04:00 }
  }

  static DateTime subtractMonths({required DateTime date, required int months}) {
    int year = date.year;
    int month = date.month - months;

    if (month <= 0) {
      year -= 1;
      month += 12;
    }

    return DateTime(year, month, date.day);
  }

  static  DateTime addMonths({required DateTime date, required int months}) {
    int year = date.year;
    int month = date.month + months;

    if (month > 12) {
      year += (month - 1) ~/ 12;
      month = (month - 1) % 12 + 1;
    }

    return DateTime(year, month, date.day);
  }

  static String formatDate(String originalDateString) {
    // Split the original string into day, month, and year parts
    List<String> parts = originalDateString.split(' ');
    int day = int.parse(parts[0]);
    String month = parts[1];
    String year = parts[2];

    // Convert month name to abbreviation
    String monthAbbreviation = getMonthAbbreviation(month);

    // Format day with ordinal indicator
    String formattedDay = getFormattedDay(day);

    // Return formatted date
    return '$formattedDay $monthAbbreviation $year';
  }

  static String getMonthAbbreviation(String month) {
    switch (month) {
      case 'January':
        return 'Jan';
      case 'February':
        return 'Feb';
      case 'March':
        return 'Mar';
      case 'April':
        return 'Apr';
      case 'May':
        return 'May';
      case 'June':
        return 'Jun';
      case 'July':
        return 'Jul';
      case 'August':
        return 'Aug';
      case 'September':
        return 'Sep';
      case 'October':
        return 'Oct';
      case 'November':
        return 'Nov';
      case 'December':
        return 'Dec';
      default:
        return '';
    }
  }

  static String getFormattedDay(int day) {
    if (day >= 11 && day <= 13) {
      return '$day' 'th';
    }
    switch (day % 10) {
      case 1:
        return '$day' 'st';
      case 2:
        return '$day' 'nd';
      case 3:
        return '$day' 'rd';
      default:
        return '$day' 'th';
    }
}

  static int monthToNumber(String month) {
    switch (month) {
      case "January":
        return 1;
      case "February":
        return 2;
      case "March":
        return 3;
      case "April":
        return 4;
      case "May":
        return 5;
      case "June":
        return 6;
      case "July":
        return 7;
      case "August":
        return 8;
      case "September":
        return 9;
      case "October":
        return 10;
      case "November":
        return 11;
      case "December":
        return 12;
      default:
        return 1; // Default to January if month name is unrecognized
    }
  }

}
