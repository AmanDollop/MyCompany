import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_face_api/face_api.dart' as regula;
import 'package:image/image.dart' as img;
import 'package:task/common/common_methods/cm.dart';

/* Dependencies required */
/* image_picker, google_mlkit_face_detection, flutter_face_api, FlutterToast */

class CustomFaceDetector extends GetxController {
  ///Capture face
  final FaceDetector faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  final image = ''.obs;
  final faceFeatures = Rxn<FaceFeatures>();
  final userFaceData = Rxn<UserFaceData>();

  /* Dispose method needs to be called for memory cleanup */
  @override
  void dispose() {
    faceDetector.close();
    super.dispose();
  }

  File mirrorImage(String inputImagePath) {
    // Read the image from file
    List<int> imageBytes = File(inputImagePath).readAsBytesSync();
    img.Image image = img.decodeImage(Uint8List.fromList(imageBytes))!;

    // Mirror the image horizontally
    img.Image mirroredImage =
    img.flip(image, direction: img.FlipDirection.horizontal);

    // Save the mirrored image to a new file
    File mirroredFile = File('${Directory.systemTemp.path}/mirrored_image.jpg');

    // Save the mirrored image to the temporary file
    mirroredFile.writeAsBytesSync(img.encodePng(mirroredImage));

    return mirroredFile;
  }

  Future<UserFaceData?> getFaceFeatures({File? fileImage}) async {
    if (fileImage != null) {
      if (Platform.isIOS) {
        await setPickedFile(mirrorImage(fileImage.path));
      } else {
        await setPickedFile(File(fileImage.path));
      }
    } else {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        maxHeight: 400,
        maxWidth: 400,
        imageQuality: 40,
      );

      if (pickedFile != null) {
        if (Platform.isIOS) {
          await setPickedFile(mirrorImage(pickedFile.path));
        } else {
          await setPickedFile(File(pickedFile.path));
        }
      }
    }

    if (faceFeatures.value != null) {
      userFaceData.value = UserFaceData(faceFeatures: faceFeatures.value, image: image.value);
      return userFaceData.value;
    } else {
      CM.showToast("Face not found");
      return null;
    }
  }

  Future<void> setPickedFile(File pickedFile) async {
    final path = pickedFile.path;
    if (path.isEmpty) {
      CM.showToast('Error in capturing image');
      return;
    }

    Uint8List imageBytes = File(path).readAsBytesSync();

    //Gives Unit8List of the image
    image.value = base64Encode(imageBytes);
    InputImage inputImage = InputImage.fromFilePath(path);
    faceFeatures.value = await extractFaceFeatures(
      inputImage,
      faceDetector,
    );
  }

  //Return true if Face is matched
  Future<bool> matchFaces(
      {regula.MatchFacesImage? image1, regula.MatchFacesImage? image2}) async {
    try {
      String similarity = '';
      bool faceMatched = false;

      //Face comparing logic.
      var request = regula.MatchFacesRequest();
      request.images = [image1, image2];
      dynamic value = await regula.FaceSDK.matchFaces(jsonEncode(request));

      var response = regula.MatchFacesResponse.fromJson(json.decode(value));
      dynamic str = await regula.FaceSDK.matchFacesSimilarityThresholdSplit(
          jsonEncode(response!.results), 0.75);

      var split =
      regula.MatchFacesSimilarityThresholdSplit.fromJson(json.decode(str));

      similarity = split!.matchedFaces.isNotEmpty
          ? (split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2)
          : "error";
      log("similarity: $similarity");
      CM.showToast('similarity: $similarity');

      if (similarity != "error" && double.parse(similarity) > 88.00) {
        faceMatched = true;
      } else {
        faceMatched = false;
      }

      if (faceMatched) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      CM.showToast(e.toString());
      return false;
    }
  }
}

// Extract Face Features
Future<FaceFeatures?> extractFaceFeatures(
    InputImage inputImage, FaceDetector faceDetector) async {
  List<Face> faceList = await faceDetector.processImage(inputImage);
  if (faceList.isNotEmpty) {
    Face face = faceList.first;

    FaceFeatures faceFeatures = FaceFeatures(
      rightEar: Points(
          x: (face.landmarks[FaceLandmarkType.rightEar])?.position.x,
          y: (face.landmarks[FaceLandmarkType.rightEar])?.position.y),
      leftEar: Points(
          x: (face.landmarks[FaceLandmarkType.leftEar])?.position.x,
          y: (face.landmarks[FaceLandmarkType.leftEar])?.position.y),
      rightMouth: Points(
          x: (face.landmarks[FaceLandmarkType.rightMouth])?.position.x,
          y: (face.landmarks[FaceLandmarkType.rightMouth])?.position.y),
      leftMouth: Points(
          x: (face.landmarks[FaceLandmarkType.leftMouth])?.position.x,
          y: (face.landmarks[FaceLandmarkType.leftMouth])?.position.y),
      rightEye: Points(
          x: (face.landmarks[FaceLandmarkType.rightEye])?.position.x,
          y: (face.landmarks[FaceLandmarkType.rightEye])?.position.y),
      leftEye: Points(
          x: (face.landmarks[FaceLandmarkType.leftEye])?.position.x,
          y: (face.landmarks[FaceLandmarkType.leftEye])?.position.y),
      rightCheek: Points(
          x: (face.landmarks[FaceLandmarkType.rightCheek])?.position.x,
          y: (face.landmarks[FaceLandmarkType.rightCheek])?.position.y),
      leftCheek: Points(
          x: (face.landmarks[FaceLandmarkType.leftCheek])?.position.x,
          y: (face.landmarks[FaceLandmarkType.leftCheek])?.position.y),
      noseBase: Points(
          x: (face.landmarks[FaceLandmarkType.noseBase])?.position.x,
          y: (face.landmarks[FaceLandmarkType.noseBase])?.position.y),
      bottomMouth: Points(
          x: (face.landmarks[FaceLandmarkType.bottomMouth])?.position.x,
          y: (face.landmarks[FaceLandmarkType.bottomMouth])?.position.y),
    );

    return faceFeatures;
  }
  return null;
}

// Comparing Face Data
double compareFaces(FaceFeatures face1, FaceFeatures face2) {
  double distEar1 = euclideanDistance(face1.rightEar!, face1.leftEar!);
  double distEar2 = euclideanDistance(face2.rightEar!, face2.leftEar!);

  double ratioEar = distEar1 / distEar2;

  double distEye1 = euclideanDistance(face1.rightEye!, face1.leftEye!);
  double distEye2 = euclideanDistance(face2.rightEye!, face2.leftEye!);

  double ratioEye = distEye1 / distEye2;

  double distCheek1 = euclideanDistance(face1.rightCheek!, face1.leftCheek!);
  double distCheek2 = euclideanDistance(face2.rightCheek!, face2.leftCheek!);

  double ratioCheek = distCheek1 / distCheek2;

  double distMouth1 = euclideanDistance(face1.rightMouth!, face1.leftMouth!);
  double distMouth2 = euclideanDistance(face2.rightMouth!, face2.leftMouth!);

  double ratioMouth = distMouth1 / distMouth2;

  double distNoseToMouth1 =
  euclideanDistance(face1.noseBase!, face1.bottomMouth!);
  double distNoseToMouth2 =
  euclideanDistance(face2.noseBase!, face2.bottomMouth!);

  double ratioNoseToMouth = distNoseToMouth1 / distNoseToMouth2;

  double ratio =
      (ratioEye + ratioEar + ratioCheek + ratioMouth + ratioNoseToMouth) / 5;
  log(ratio.toString(), name: "Ratio");

  return ratio;
}

double euclideanDistance(Points p1, Points p2) {
  final sqr = math.sqrt(math.pow((p1.x! - p2.x!), 2) + math.pow((p1.y! - p2.y!), 2));
  return sqr;
}

//User Face Data Model
class UserFaceData {
  String? name;
  String? image;
  FaceFeatures? faceFeatures;

  UserFaceData({
    this.name,
    this.image,
    this.faceFeatures,
  });

  factory UserFaceData.fromJson(Map<String, dynamic> json) {
    return UserFaceData(
      name: json['name'],
      image: json['image'],
      faceFeatures: FaceFeatures.fromJson(json["faceFeatures"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'faceFeatures': faceFeatures?.toJson() ?? {},
    };
  }
}

class FaceFeatures {
  Points? rightEar;
  Points? leftEar;
  Points? rightEye;
  Points? leftEye;
  Points? rightCheek;
  Points? leftCheek;
  Points? rightMouth;
  Points? leftMouth;
  Points? noseBase;
  Points? bottomMouth;

  FaceFeatures({
    this.rightMouth,
    this.leftMouth,
    this.leftCheek,
    this.rightCheek,
    this.leftEye,
    this.rightEar,
    this.leftEar,
    this.rightEye,
    this.noseBase,
    this.bottomMouth,
  });

  factory FaceFeatures.fromJson(Map<String, dynamic> json) => FaceFeatures(
    rightMouth: Points.fromJson(json["rightMouth"]),
    leftMouth: Points.fromJson(json["leftMouth"]),
    leftCheek: Points.fromJson(json["leftCheek"]),
    rightCheek: Points.fromJson(json["rightCheek"]),
    leftEye: Points.fromJson(json["leftEye"]),
    rightEar: Points.fromJson(json["rightEar"]),
    leftEar: Points.fromJson(json["leftEar"]),
    rightEye: Points.fromJson(json["rightEye"]),
    noseBase: Points.fromJson(json["noseBase"]),
    bottomMouth: Points.fromJson(json["bottomMouth"]),
  );

  Map<String, dynamic> toJson() => {
    "rightMouth": rightMouth?.toJson() ?? {},
    "leftMouth": leftMouth?.toJson() ?? {},
    "leftCheek": leftCheek?.toJson() ?? {},
    "rightCheek": rightCheek?.toJson() ?? {},
    "leftEye": leftEye?.toJson() ?? {},
    "rightEar": rightEar?.toJson() ?? {},
    "leftEar": leftEar?.toJson() ?? {},
    "rightEye": rightEye?.toJson() ?? {},
    "noseBase": noseBase?.toJson() ?? {},
    "bottomMouth": bottomMouth?.toJson() ?? {},
  };
}

class Points {
  int? x;
  int? y;

  Points({
    required this.x,
    required this.y,
  });

  factory Points.fromJson(Map<String, dynamic> json) => Points(
    x: (json['x'] ?? 0) as int,
    y: (json['y'] ?? 0) as int,
  );

  Map<String, dynamic> toJson() => {'x': x, 'y': y};
}
