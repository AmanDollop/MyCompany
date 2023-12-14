import 'package:get/get.dart';
import 'package:task/app/modules/bottom_navigation/views/bottom_navigation_view.dart';

class MenuViewController extends GetxController {

  final count = 0.obs;

  final titleList = [
    'Meetings',
    'Attendance',
    'Idea Box',
    'LMS',
    'Escalation',
    'WFH',
    'Holiday',
    'Purchase',
    'Bring your Buddy',
    'Appointment',
    'PMS',
    'Tax Exemption',
    'Employee',
    'Events',
    'Gallery',
    'Games',
    'Survey',
    'SOS',
    'Polls',
    'Complaint',

    'Events',
    'Gallery',
    'Games',
    'Survey',
    'SOS',
    'Polls',
    'Complaint',
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  willPop() {
    selectedBottomNavigationIndex.value=0;
  }

}
