import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_model/get_task_time_line_modal.dart';
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
            isLoader: false,
            inAsyncCall: controller.apiResValue.value,
            child: StreamBuilder<Map<DateTime, List<TimeLine>>>(
              stream: controller.counterStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if(controller.getTaskTimeLineModal.value != null){
                    if(controller.timeLineList.isNotEmpty) {
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  controller: controller.scrollController,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: controller.timeLineList.length,
                                  physics: const ScrollPhysics(),
                                  reverse: true,
                                  itemBuilder: (context, index) {
                                    final date = snapshot.data?.keys.toList()[index];
                                    final dateMessages = controller.timeLineList[date] ?? [];

                                    return Padding(
                                      padding: EdgeInsets.only(left: 8.px, right: 8.px, top: 8.px, bottom: index == 0 ? 90.px : 8.px),
                                      child: Column(
                                        children: [
                                          dateContainerView(index: index, date: date ?? DateTime.now()),
                                          SizedBox(height: 10.px),
                                          ...dateMessages.map((messageDetail) {
                                            return Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: messageDetail.isSender == false
                                                  ? MainAxisAlignment.start
                                                  : MainAxisAlignment.end,
                                              children: [
                                                if (messageDetail.isSender == false)
                                                  senderProfileView(index: index, messageDetail: messageDetail),
                                                ChatContainerView(
                                                  delivered: messageDetail.isSender == false?true:false,
                                                  onLongPress: messageDetail.isDeleteAllow ?? false
                                                      ? () => controller.clickOnMessageView(messageId: messageDetail.taskTimelineId ?? '')
                                                      : () => null,
                                                  widget: Column(
                                                    crossAxisAlignment:
                                                    messageDetail.isSender == true
                                                        ? CrossAxisAlignment.end
                                                        : CrossAxisAlignment.start,
                                                    children: [
                                                      if (messageDetail.isSender == false)
                                                        senderNameTextView(index: index, messageDetail: messageDetail),
                                                      if (messageDetail.isSender == false)
                                                        SizedBox(height: 5.px),
                                                      if (messageDetail.taskTimelineStatus != '5')
                                                        commonTextForStatusMessageView(index: index, messageDetail: messageDetail),
                                                      if (messageDetail.taskTimelineStatus != '5')
                                                        SizedBox(height: 5.px),
                                                      if (messageDetail.taskTimelineDescription != null && messageDetail.taskTimelineDescription!.isNotEmpty)
                                                        commonTextForMessageView(index: index, messageDetail: messageDetail),
                                                      SizedBox(height: 2.px),
                                                      commonTimeTextView(index: index, messageDetail: messageDetail),
                                                    ],
                                                  ),
                                                  color: messageDetail.isSender ?? false
                                                      ? Col.gray.withOpacity(.2.px)
                                                      : Col.primary.withOpacity(.1.px),
                                                  isSender: messageDetail.isSender ?? false,
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          controller.apiResValue.value
                              ? const SizedBox()
                              : sendMessageContainerView()
                        ],
                      );
                    }else{
                      return controller.apiResValue.value
                          ? const SizedBox()
                          : CW.commonNoDataFoundText();
                    }
                  }else{
                    return controller.apiResValue.value
                        ? const SizedBox()
                        : CW.commonNoDataFoundText();
                  }
                } else {
                  return  Center(child: Text('Loading...',style: Theme.of(Get.context!).textTheme.titleLarge,),);
                }
              },
            ),
          );
        }),
      ),
    );
  }

  Widget dateContainerView({required int index, required DateTime date}) => Container(
        padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 4.px),
        decoration: BoxDecoration(
            color: Col.primary.withOpacity(.2),
            borderRadius: BorderRadius.circular(4.px)),
        child: Text(DateFormat('d MMM y').format(DateTime.parse('$date')),
            style: Theme.of(Get.context!)
                .textTheme
                .labelSmall
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 10.px)),
      );

  Widget senderProfileView({required int index, required TimeLine messageDetail}) => Container(
        height: 36.px,
        width: 36.px,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            color: Col.primary.withOpacity(.2.px), shape: BoxShape.circle),
        child: Center(
          child: messageDetail.userProfile != null &&
                  messageDetail.userProfile!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(18.px),
                  child: CW.commonNetworkImageView(
                      path:
                          '${AU.baseUrlAllApisImage}${messageDetail.userProfile}',
                      isAssetImage: false,
                      errorImage: 'assets/images/profile.png',
                      height: 36.px,
                      width: 36.px),
                )
              : Text(
                  '${messageDetail.shortName}',
                  style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600, color: Col.primary),
                ),
        ),
      );

  Widget senderNameTextView({required int index, required TimeLine messageDetail}) => Text(
        messageDetail.userName != null && messageDetail.userName!.isNotEmpty
            ? '${messageDetail.userName}'
            : 'Not found!',
        style: Theme.of(Get.context!)
            .textTheme
            .labelMedium
            ?.copyWith(fontSize: 10.px),
      );

  Widget commonTextForStatusMessageView({required int index, int? maxLine, required TimeLine messageDetail}) => Text(
        messageDetail.taskStatusName != null &&
                messageDetail.taskStatusName!.isNotEmpty
            ? 'Status : ${messageDetail.taskStatusName}'
            : 'Not found!',
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: messageDetail.taskStatusColor != null &&
                      messageDetail.taskStatusColor!.isNotEmpty
                  ? CW.apiColorConverterMethod(
                      colorString: '${messageDetail.taskStatusColor}')
                  : Col.secondary,
            ),
        maxLines: maxLine,
      );

  // Widget commonTextForMessageView({required int index, int? maxLine, required TimeLine messageDetail}) => Text(
  //       '${messageDetail.taskTimelineDescription}',
  //       style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600,),
  //       maxLines: maxLine,
  //     );

  Widget commonTextForMessageView({required int index, int? maxLine, required TimeLine messageDetail}) => CW.commonReadMoreText(value: '${messageDetail.taskTimelineDescription}',maxLine: 10);

  Widget commonTimeTextView({required int index, required TimeLine messageDetail}) => Text(messageDetail.taskTimelineDate != null && messageDetail.taskTimelineDate!.isNotEmpty
            ? DateFormat('hh:mm a').format(DateTime.parse('${messageDetail.taskTimelineDate}'))
            : '?',
        style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: 8.px),
        textAlign: TextAlign.end,
      );

  Widget sendMessageContainerView() => Container(
        height: 82.px,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.px),
        decoration: BoxDecoration(color: Col.inverseSecondary, boxShadow: [BoxShadow(color: Col.gray, blurRadius: 1.px)]),
        child: controller.getTaskTimeLineModal.value?.isTaskTimeLineActive ?? false
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: sendMessageTextFieldView(),
            ),
            SizedBox(width: 10.px),
            sendButtonView(),
          ],
        )
            : Center(child: Text('${controller.getTaskTimeLineModal.value?.timelineMsg}',style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),),),
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
        padding: EdgeInsets.symmetric(horizontal: isSender ? 8.px : 0.px, vertical: 2.px),
        child: CustomPaint(
          painter: SpecialChatBubbleOne(color: color, alignment: isSender ? Alignment.topRight : Alignment.topLeft, tail: tail),
          child: GestureDetector(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Container(
              constraints: constraints ??
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .7,
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
