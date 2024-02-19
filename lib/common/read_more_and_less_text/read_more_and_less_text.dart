// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/theme/colors/colors.dart';

class MyReadMoreText extends StatefulWidget {
  final String text;
  final int maxLines;

   const MyReadMoreText({
    Key? key,
    required this.text,
    required this.maxLines,
  }) : super(key: key);

  @override
  _MyReadMoreTextState createState() => _MyReadMoreTextState();
}

class _MyReadMoreTextState extends State<MyReadMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: widget.text, style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),),
          // maxLines: widget.maxLines,
          textDirection: ui.TextDirection.ltr,
          textAlign: TextAlign.left,
        );
        textPainter.layout(maxWidth: constraints.maxWidth);
        final textLines = textPainter.computeLineMetrics().length;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                widget.text,
                style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                maxLines: _isExpanded ? null : widget.maxLines,
              ),
            ),
            if (textLines > widget.maxLines)
              InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? 'Read less' : 'Read more',
                  style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600,color: Col.primary,fontSize: 10.px),
                ),
              ),
          ],
        );
      },
    );
  }
}