import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_packages/scroll_behavior/scroll_behavior.dart';
import 'package:task/theme/constants/constants.dart';
import 'package:task/theme/theme_data/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );
  late StreamSubscription streamSubscription;
  AC().getNetworkConnectionType();
  streamSubscription = AC().checkNetworkConnection();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {
    runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => ResponsiveSizer(
          builder: (
              buildContext,
              orientation,
              screenType,
              ) => GetMaterialApp(
            title: "Application",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            theme: AppThemeData.themeData(fontFamily: C.fontKumbhSans),
            defaultTransition: Transition.rightToLeftWithFade,
            debugShowCheckedModeBanner: false,
            scrollBehavior: ListScrollBehavior(),
            initialBinding: InitialBinding(),
          ),
        ),
      ),
    );
  });
}

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Custom Calendar Picker Example'),
//         ),
//         body: Center(
//           child: CustomCalendarPicker(
//             onDateSelected: (date) {
//               print('Selected date: $date');
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CustomCalendarPicker extends StatefulWidget {
//   final Function(DateTime) onDateSelected;
//
//   const CustomCalendarPicker({Key? key, required this.onDateSelected}) : super(key: key);
//
//   @override
//   _CustomCalendarPickerState createState() => _CustomCalendarPickerState();
// }
//
// class _CustomCalendarPickerState extends State<CustomCalendarPicker> {
//   DateTime _selectedDate = DateTime.now();
//   DateTime _currentMonth = DateTime.now();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _buildHeader(),
//          SizedBox(height: 20.px),
//         _buildDayNames(),
//          SizedBox(height: 50.px),
//         _buildDaysGrid(),
//       ],
//     );
//   }
//
//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             setState(() {
//               _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
//             });
//           },
//         ),
//         Text(
//           '${_currentMonth.month}/${_currentMonth.year}',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         IconButton(
//           icon: Icon(Icons.arrow_forward),
//           onPressed: () {
//             setState(() {
//               _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
//             });
//           },
//         ),
//       ],
//     );
//   }
//   final days1 = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
//   Widget _buildDayNames() {
//
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         for (var day in days1)
//           Text(
//             day,
//             style: TextStyle(fontSize: 16),
//           ),
//       ],
//     );
//   }
//
//   Widget _buildDaysGrid() {
//     final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
//
//     return GridView.builder(
//       shrinkWrap: true,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 7,
//         crossAxisSpacing: 8.0,
//         mainAxisSpacing: 8.0,
//       ),
//       itemCount: daysInMonth,
//       itemBuilder: (context, index) {
//         final day = index + 1;
//         final date = DateTime(_currentMonth.year, _currentMonth.month, day);
//         final isSelected = date.isAtSameMomentAs(_selectedDate);
//         return Column(
//           children: [
//             Text(
//               day.toString(),
//               style: TextStyle(
//                 color: isSelected ? Colors.white : null,
//                 fontWeight: isSelected ? FontWeight.bold : null,
//               ),
//             ),
//             Text(
//               _getDayName(date),
//               style: TextStyle(fontSize: 10),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   String _getDayName(DateTime date) {
//     final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
//     return days[date.weekday - 1];
//   }
// }

