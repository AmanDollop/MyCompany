import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:ui' as ui;

import 'package:task/common/common_widgets/cw.dart';

class GradientImageWidget extends StatelessWidget {
  final String assetPath;
  double? width = 24.px;
  double? height = 24.px;

   GradientImageWidget({super.key, required this.assetPath,this.height,this.width});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: loadImage(assetPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ShaderMask(
            shaderCallback: (Rect bounds) => createShader(bounds, Image(image: AssetImage(assetPath),width: width,height: height)),
            blendMode: BlendMode.srcATop,
            child: SizedBox(height: height,width: width,child: Image(image: AssetImage(assetPath),width: width,height: height)),
          );
        } else {
          return /*CW.commonShimmerViewForImage(height: height,width: width,radius: 4.px)*/Image(image: AssetImage(assetPath),width: width,height: height); // Show a loading indicator while the image is loading
        }
      },
    );
  }
}

Shader createShader(Rect bounds, Image image) {
  return CW.commonLinearGradientForButtonsView().createShader(bounds);
}

Future<ui.Image> loadImage(String assetPath) async {
  ByteData data = await rootBundle.load(assetPath);
  Uint8List bytes = Uint8List.view(data.buffer);
  ui.Codec codec = await ui.instantiateImageCodec(bytes);
  ui.FrameInfo frameInfo = await codec.getNextFrame();
  return frameInfo.image;
}