import 'package:dmggo/arch/commonUI/chatUI/chat_time_ui.dart';
import 'package:dmggo/arch/commonUI/chatUI/clip.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:flutter/material.dart';
import 'package:quickblox_sdk/models/qb_message.dart';

class LeftChatBubble extends StatelessWidget {
  final String strMsgTime;
  final Widget? widgetOf;
  final QBMessage message;

  LeftChatBubble({
    Key? key,
    required this.message,
    required this.strMsgTime,
    this.widgetOf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: h_10,
        top: h_2 + h_05,
        bottom: h_2 + h_05,
      ),
      child: ClipPath(
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
            padding: EdgeInsets.fromLTRB(h_8 + h_2 * h_4, h_8, h_8, h_5),
            color: cgrey_300,
            child: Stack(
              children: [
                widgetOf!,
                Positioned(
                  bottom: -h_3,
                  right: h_1,
                  child: ChatTimeUI(
                    strMsgTime: strMsgTime,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
