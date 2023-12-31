import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CUB extends StatelessWidget {
  final GradientPainter painter;
  final Widget _child;
  final VoidCallback _callback;
  final double _radius;
  final double _elevation;
  final EdgeInsetsGeometry _padding;

  CUB({super.key,
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    required Widget child,
    required VoidCallback onPressed,
    EdgeInsetsGeometry? padding,
    double? elevation,
  })
      : painter = GradientPainter(
    strokeWidth: strokeWidth, radius: radius, gradient: gradient,),
        _child = child,
        _callback = onPressed,
        _radius = radius,
        _elevation=elevation??0.px,
        _padding=padding ?? EdgeInsets.all(3.5.px);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: painter,
      child: OutlinedButton(style: OutlinedButton.styleFrom(
          elevation:_elevation,

          foregroundColor: Theme
              .of(context)
              .colorScheme
              .onSecondary,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: _padding), onPressed: _callback, child: _child,),
    );
  }
}


class GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  GradientPainter({required double strokeWidth,
    required double radius,
    required Gradient gradient})
  // ignore: prefer_initializing_formals
      : strokeWidth = strokeWidth,
  // ignore: prefer_initializing_formals
        radius = radius,
  // ignore: prefer_initializing_formals
        gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
    RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()
      ..addRRect(outerRRect);
    Path path2 = Path()
      ..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}