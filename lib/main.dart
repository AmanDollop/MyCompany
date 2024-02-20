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


///Todo Device Info code
// DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
// AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
// print('Running on::::: ${androidInfo.id}');

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


/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FaceDetectionScreen(),
    );
  }
}

class FaceDetectionScreen extends StatefulWidget {
  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  late final CameraController _controller;
  late final FaceDetector _faceDetector;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    _faceDetector.close();
    super.dispose();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    await _controller.initialize();

    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        // mode: FaceDetectorMode.accurate,
        // enableLandmarks: true,
        performanceMode: FaceDetectorMode.accurate,
        // enableTracking: true,
      ),
    );
  }

  void _startFaceDetection() {
    _controller.startImageStream((CameraImage image) async {
      final inputImage = InputImage.fromBytes(
        metadata: InputImageMetadata(size: Size(image.width.toDouble(), image.height.toDouble()), rotation: InputImageRotation.rotation0deg, format: InputImageFormat.yuv420, bytesPerRow: 2),
        bytes: _concatenatePlanes(image.planes),

      );

      final faces = await _faceDetector.processImage(inputImage);
      if (faces.isNotEmpty) {
        _captureImage();
      }
    });
  }
  Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  void _captureImage() async {
    try {
      final image = await _controller.takePicture();
      // Process captured image here
      print('Image captured: ${image.path}');
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auto Capture with Face Detection'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _controller.value.isInitialized
                ? CameraPreview(_controller)
                : CircularProgressIndicator(),
          ),
          ElevatedButton(
            onPressed: _startFaceDetection,
            child: Text('Start Face Detection'),
          ),
        ],
      ),
    );
  }
}*/

/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FaceDetectionScreen(),
    );
  }
}

class FaceDetectionScreen extends StatefulWidget {
  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  late final CameraController _controller;
  late final FaceDetector _faceDetector;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    _faceDetector.close();
    super.dispose();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    await _controller.initialize();

    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
      ),
    );
  }

  void _startFaceDetection() {
    _controller.startImageStream((CameraImage image) async {
      final inputImage = InputImage.fromBytes(
        bytes: _concatenatePlanes(image.planes),

        metadata: InputImageMetadata(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: InputImageRotation.rotation0deg,
            format: InputImageFormat.yuv_420_888, bytesPerRow: 10),
      );

      final faces = await _faceDetector.processImage(inputImage);
      if (faces.isNotEmpty) {
        _captureImage();
      }
    });
  }


  Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  void _captureImage() async {
    try {
      final image = await _controller.takePicture();
      // Process captured image here
      print('Image captured: ${image.path}');
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auto Capture with Face Detection'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _controller.value.isInitialized
                ? CameraPreview(_controller)
                : CircularProgressIndicator(),
          ),
          ElevatedButton(
            onPressed: _startFaceDetection,
            child: Text('Start Face Detection'),
          ),
        ],
      ),
    );
  }
}*/

/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FaceDetectionScreen(),
    );
  }
}

class FaceDetectionScreen extends StatefulWidget {
  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  late final CameraController _controller;
  late final FaceDetector _faceDetector;
  bool _imageCaptured = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    _faceDetector.close();
    super.dispose();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    await _controller.initialize();

    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        enableLandmarks: true,
      ),
    );
  }

  void _startFaceDetection() {
    _controller.startImageStream((CameraImage image) async {
      final inputImage = InputImage.fromBytes(
        bytes: _concatenatePlanes(image.planes),

        metadata: InputImageMetadata(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: InputImageRotation.rotation0deg,
            format: InputImageFormat.yuv_420_888, bytesPerRow: 10),
      );

      final faces = await _faceDetector.processImage(inputImage);
      if (faces.isNotEmpty) {
        _captureImage();
      }
    });
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  void _captureImage() async {
    try {
      final image = await _controller.takePicture();
      // Process captured image here
      print('Image captured: ${image.path}');
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auto Capture with Face Detection'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _controller.value.isInitialized
                ? CameraPreview(_controller)
                : CircularProgressIndicator(),
          ),
          ElevatedButton(
            onPressed: _startFaceDetection,
            child: Text('Start Face Detection'),
          ),
        ],
      ),
    );
  }
}*/
