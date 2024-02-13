import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/task_time_line_controller.dart';

class TaskTimeLineView extends GetView<TaskTimeLineController> {
  const TaskTimeLineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CM.unFocusKeyBoard(),
      child: Scaffold(
        appBar: CW.commonAppBarView(
          title: 'Task Timeline',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton(),
        ),
        body: Obx(() {
          controller.count.value;
          return ModalProgress(
            isLoader: true,
            inAsyncCall: controller.apiResValue.value,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                controller.getTaskTimeLineModal.value != null
                    ? controller.timeLineList != null && controller.timeLineList!.isNotEmpty
                        ? Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: controller.timeLineList?.length,
                                  physics: const ScrollPhysics(),
                                  reverse: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.px,
                                          right: 8.px,
                                          top: 8.px,
                                          bottom: index == 0 ? 90.px : 8.px),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment:controller.timeLineList?[index].isSender== false? MainAxisAlignment.start : MainAxisAlignment.end,
                                        children: [
                                          if (controller.timeLineList?[index].isSender== false)
                                            senderProfileView(index: index),
                                          ChatContainerView(
                                            onLongPress:controller.timeLineList?[index].isDeleteAllow ?? false
                                                ? () => controller.clickOnMessageView(index:index)
                                                : () => null,
                                            widget: Column(
                                              crossAxisAlignment: controller.timeLineList?[index].isSender == true
                                                  ? CrossAxisAlignment.end
                                                  : CrossAxisAlignment.start,
                                              children: [
                                                if (controller.timeLineList?[index].isSender == false)
                                                  senderNameTextView(index: index),
                                                if (controller.timeLineList?[index].isSender == false)
                                                SizedBox(height: 5.px),
                                                commonTextForMessageView(index: index),
                                                SizedBox(height: 2.px),
                                                commonTimeTextView(index: index),
                                              ],
                                            ),
                                            color: controller.timeLineList?[index].isSender ?? false
                                                ? Col.gray.withOpacity(.2.px)
                                                : Col.primary.withOpacity(.1.px),
                                            isSender: controller.timeLineList?[index].isSender ?? false,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                            ),
                          ],
                        )
                        : controller.apiResValue.value
                            ? const SizedBox()
                            : CW.commonNoDataFoundText()
                    : controller.apiResValue.value
                        ? const SizedBox()
                        : CW.commonNoDataFoundText(),
                controller.apiResValue.value
                    ? const SizedBox()
                    : controller.getTaskTimeLineModal.value?.isTaskTimeLineActive ?? false
                    ? sendMessageContainerView()
                    : const SizedBox()
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget senderProfileView({required int index}) => Container(
        height: 36.px,
        width: 36.px,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: Col.primary.withOpacity(.2.px), shape: BoxShape.circle),
        child: Center(
          child: controller.timeLineList?[index].userProfile != null && controller.timeLineList![index].userProfile!.isNotEmpty
              ? ClipRRect(
              borderRadius: BorderRadius.circular(18.px),
                child: CW.commonNetworkImageView(
                    path: '${AU.baseUrlAllApisImage}${controller.timeLineList?[index].userProfile}',
                    isAssetImage: false,
                    errorImage: 'assets/images/profile.png',
                    height: 36.px,
                    width: 36.px),
              )
              : Text('${controller.timeLineList?[index].shortName}',
                  style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600,color: Col.primary),
          ),
        ),
      );

  Widget senderNameTextView({required int index}) => Text(
    controller.timeLineList?[index].userName != null && controller.timeLineList![index].userName!.isNotEmpty
        ? '${controller.timeLineList?[index].userName}'
        : 'Not found!',
        style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontSize: 10.px),
      );

  Widget commonTextForMessageView({required int index,int? maxLine,Color, color}) => Text(
        controller.timeLineList?[index].taskTimelineDescription != null && controller.timeLineList![index].taskTimelineDescription!.isNotEmpty
            ? '${controller.timeLineList?[index].taskTimelineDescription}'
            : 'Status : ${controller.timeLineList?[index].taskTimelineDescription}',
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color:color ?? controller.timeLineList?[index].taskTimelineDescription != null && controller.timeLineList![index].taskTimelineDescription!.isNotEmpty
                  ? Col.secondary
                  : CW.apiColorConverterMethod(colorString: '${controller.timeLineList?[index].taskStatusColor}'),
            ),
       maxLines: maxLine,
      );

  Widget commonTimeTextView({required int index}) => Text(
    controller.timeLineList?[index].taskTimelineDate != null && controller.timeLineList![index].taskTimelineDate!.isNotEmpty
        ? DateFormat('hh:mm a').format(DateTime.parse('${controller.timeLineList?[index].taskTimelineDate}'))
        :'?',
        style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: 8.px),
        textAlign: TextAlign.end,
      );

  Widget sendMessageContainerView() => Container(
        height: 82.px,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.px),
        decoration: BoxDecoration(
            color: Col.inverseSecondary,
            boxShadow: [BoxShadow(color: Col.gray, blurRadius: 1.px)]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: sendMessageTextFieldView(),
            ),
            SizedBox(width: 10.px),
            sendButtonView(),
          ],
        ),
      );

  Widget sendMessageTextFieldView() => CW.commonTextField(
      isSearchLabelText: false,
      hintText: 'Write Your Message...',
      borderRadius: 16.px,
      controller: controller.sendMessageController);

  Widget sendButtonView() => InkWell(
        onTap: () => controller.clickOnSendMessageButton(),
        borderRadius: BorderRadius.circular(20.px),
        child: Container(
          width: 40.px,
          height: 40.px,
          decoration: BoxDecoration(color: Col.primary, shape: BoxShape.circle),
          child: Center(
            child: CW.commonNetworkImageView(
                path: 'assets/icons/send_icon.png',
                isAssetImage: true,
                height: 18.px,
                width: 18.px),
          ),
        ),
      );
}

class ChatContainerView extends StatelessWidget {
  final bool isSender;
  final Widget widget;
  final bool tail;
  final Color color;
  final bool sent;
  final bool delivered;
  final bool seen;
  final TextStyle textStyle;
  final BoxConstraints? constraints;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;

  const ChatContainerView({
    Key? key,
    this.isSender = true,
    this.constraints,
    this.onTap,
    this.onLongPress,
    required this.widget,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
  }) : super(key: key);

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Icon? stateIcon;
    if (sent) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done,
        size: 18.px,
        color: const Color(0xFF97AD8E),
      );
    }
    if (delivered) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done_all,
        size: 18.px,
        color: const Color(0xFF97AD8E),
      );
    }
    if (seen) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done_all,
        size: 18.px,
        color: const Color(0xFF92DEDA),
      );
    }

    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isSender ? 8.px : 0.px, vertical: 2.px),
        child: CustomPaint(
          painter: SpecialChatBubbleOne(
              color: color,
              alignment: isSender ? Alignment.topRight : Alignment.topLeft,
              tail: tail),
          child: GestureDetector(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Container(
              constraints: constraints ??
                  BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .7,
                  ),
              margin: isSender
                  ? stateTick
                      ? EdgeInsets.fromLTRB(7.px, 7.px, 14.px, 7.px)
                      : EdgeInsets.fromLTRB(7.px, 7.px, 17.px, 7.px)
                  : EdgeInsets.fromLTRB(17.px, 7.px, 7.px, 7.px),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: stateTick
                        ? EdgeInsets.only(right: 20.px)
                        : EdgeInsets.symmetric(vertical: 0.px, horizontal: 4.px),
                    child: widget,
                  ),
                  stateIcon != null && stateTick
                      ? Positioned(
                          bottom: 0,
                          right: 0,
                          child: stateIcon,
                        )
                      : SizedBox(width: 1.px),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SpecialChatBubbleOne extends CustomPainter {
  final Color color;
  final Alignment alignment;
  final bool tail;

  SpecialChatBubbleOne({
    required this.color,
    required this.alignment,
    required this.tail,
  });

  final double _radius = 8.px;
  final double _x = 8.px;

  @override
  void paint(Canvas canvas, Size size) {
    if (alignment == Alignment.topRight) {
      if (tail) {
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              0,
              0,
              size.width - _x,
              size.height,
              bottomLeft: Radius.circular(_radius),
              bottomRight: Radius.circular(_radius),
              topLeft: Radius.circular(_radius),
            ),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
        var path = Path();
        path.moveTo(size.width - _x, 0);
        path.lineTo(size.width - _x, 10);
        path.lineTo(size.width, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              size.width - _x,
              0.0,
              size.width,
              size.height,
              topRight: Radius.circular(3.px),
            ),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      } else {
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              0,
              0,
              size.width - _x,
              size.height,
              bottomLeft: Radius.circular(_radius),
              bottomRight: Radius.circular(_radius),
              topLeft: Radius.circular(_radius),
              topRight: Radius.circular(_radius),
            ),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      }
    } else {
      if (tail) {
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              _x,
              0,
              size.width,
              size.height,
              bottomRight: Radius.circular(_radius),
              topRight: Radius.circular(_radius),
              bottomLeft: Radius.circular(_radius),
            ),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
        var path = Path();
        path.moveTo(_x, 0);
        path.lineTo(_x, 10);
        path.lineTo(0, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              0,
              0.0,
              _x,
              size.height,
              topLeft: Radius.circular(3.px),
            ),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      } else {
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              _x,
              0,
              size.width,
              size.height,
              bottomRight: Radius.circular(_radius),
              topRight: Radius.circular(_radius),
              bottomLeft: Radius.circular(_radius),
              topLeft: Radius.circular(_radius),
            ),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
