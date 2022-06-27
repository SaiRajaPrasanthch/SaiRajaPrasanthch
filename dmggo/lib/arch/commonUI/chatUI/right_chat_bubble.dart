import 'package:dmggo/arch/commonUI/chatUI/chat_time_ui.dart';
import 'package:dmggo/arch/commonUI/chatUI/clip.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:flutter/material.dart';
import 'package:quickblox_sdk/models/qb_message.dart';

class RightChatBubble extends StatelessWidget {
  final QBMessage message;
  final String strMsgTime;
  final Widget? widgetOf;
  final bool isGroup;
  final int? intGroupCount;

  RightChatBubble({
    Key? key,
    required this.message,
    required this.strMsgTime,
    this.widgetOf,
    this.intGroupCount,
    required this.isGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clipped = ClipPath(
      clipper: ClipRThread(h_2),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(h_4),
          topRight: rCir_5,
          bottomLeft: rCir_5,
          bottomRight: rCir_5,
        ),
        child: Container(
          constraints: BoxConstraints.loose(MediaQuery.of(context).size * h_07),
          padding: EdgeInsets.fromLTRB(h_12 + h_2 * h_4, h_10, h_10, h_5),
          color: cblue_100,
          child: Transform(
            transform: Matrix4.diagonal3Values(-h_1, h_1, h_1),
            child: Stack(
              children: [
                widgetOf!,
                Positioned(
                  bottom: -h_3,
                  right: -h_5,
                  child: ChatTimeUI(
                    strMsgTime: strMsgTime,
                    strStatus: isGroup
                        ? message.deliveredIds!.length == intGroupCount && message.readIds!.length == intGroupCount
                            ? status.read
                            : message.deliveredIds!.length == intGroupCount
                                ? status.delivered
                                : message.deliveredIds!.length == i_1 && message.readIds!.length == i_1
                                    ? status.sent
                                    : status.await
                        : message.deliveredIds!.length == i_1 && message.readIds!.length == i_1
                            ? status.sent
                            : message.deliveredIds!.length == i_2 && message.readIds!.length == i_1
                                ? status.delivered
                                : message.deliveredIds!.length == i_2 && message.readIds!.length == i_2
                                    ? status.read
                                    : status.await,
                  ),
                )
              ],
            ),
            alignment: Alignment.center,
          ),
        ),
      ),
    );
    return Padding(
      padding: EdgeInsets.only(
        right: h_2,
        top: h_2 + h_05,
        bottom: h_2 + h_05,
      ),
      child: Transform(
        transform: Matrix4.diagonal3Values(-h_1, h_1, h_1),
        child: clipped,
        alignment: Alignment.center,
      ),
    );
  }
}
