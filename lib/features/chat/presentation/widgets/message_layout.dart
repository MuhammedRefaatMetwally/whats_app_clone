
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../cores/app/const/message_type_const.dart';
import '../../../../cores/app/theme/style.dart';
import '../../domain/entities/message_reply_entity.dart';
import 'message_widgets/message_replay_type_widget.dart';
import 'message_widgets/message_type_widget.dart';

class MessageLayout extends StatelessWidget {
  final Color? messageBgColor;
  final    Alignment? alignment;
  final Timestamp? createAt;
  final   Function(DragUpdateDetails)?  onSwipe;
  final  String? message;
  final String? messageType;
  final bool? isShowTick;
  final bool? isSeen;
  final VoidCallback? onLongPress;
  final MessageReplayEntity? reply;
  final double? rightPadding;
  final String reciepentName;
  const MessageLayout({super.key, this.messageBgColor, this.alignment, this.createAt, this.onSwipe, this.message, this.messageType, this.isShowTick, this.isSeen, this.onLongPress, this.reply, this.rightPadding, required this.reciepentName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: SwipeTo(
        onRightSwipe: onSwipe,
        child: GestureDetector(
          onLongPress: onLongPress,
          child: Container(
            alignment: alignment,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 5, right: messageType == MessageTypeConst.textMessage ? rightPadding! : 5, top: 5, bottom: 5),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.80),
                        decoration: BoxDecoration(color: messageBgColor, borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            reply?.message == null || reply?.message == ""
                                ? const SizedBox() :Container(
                              height: reply!.messageType ==
                                  MessageTypeConst.textMessage ? 70 : 80,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: double.infinity,
                                    width: 4.5,
                                    decoration: BoxDecoration(
                                        color: reply?.username == reciepentName ? Colors.deepPurpleAccent
                                            : tabColor,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomLeft:
                                            Radius.circular(15))),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${reply?.username == reciepentName ? reply?.username : "You"}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: reply?.username == reciepentName
                                                    ? Colors.deepPurpleAccent
                                                    : tabColor
                                            ),
                                          ),
                                          MessageReplayTypeWidget(
                                            message: reply?.message,
                                            type: reply?.messageType,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),

                            MessageTypeWidget(
                              message: message,
                              type: messageType,
                            ),
                          ],
                        )
                    ),
                    const SizedBox(height: 3),
                  ],
                ),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      Text(DateFormat.jm().format(createAt!.toDate()),
                          style: const TextStyle(fontSize: 12, color: greyColor)),
                      const SizedBox(
                        width: 5,
                      ),
                      isShowTick == true
                          ? Icon(
                        isSeen == true ? Icons.done_all : Icons.done,
                        size: 16,
                        color: isSeen == true ? Colors.blue : greyColor,
                      )
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
