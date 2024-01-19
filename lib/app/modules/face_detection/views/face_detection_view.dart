import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/face_detection_controller.dart';

class FaceDetectionView extends GetView<FaceDetectionController> {
  const FaceDetectionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FaceDetectionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FaceDetectionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
