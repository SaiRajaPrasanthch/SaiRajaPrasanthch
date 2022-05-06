import 'package:dmggo/arch/commonUI/chatUI/chat_time_ui.dart';
import 'package:dmggo/arch/commonUI/chatUI/clip.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:flutter/material.dart';

class RightChatBubble extends StatelessWidget {
  final String message;
  final String strMsgTime;
  final Widget? widgetOf;
  final double r;

  RightChatBubble({Key? key, required this.message, required this.strMsgTime, this.widgetOf, this.r = 4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clipped = ClipPath(
      clipper: ClipRThread(h_2),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(r),
          topRight: rCir_5,
          bottomLeft: rCir_5,
          bottomRight: rCir_5,
        ),
        child: Container(
          constraints: BoxConstraints.loose(MediaQuery.of(context).size * 0.8),
          padding: EdgeInsets.fromLTRB(h_12 + h_2 * r, h_10, h_10, h_5),
          color: cblue_200,
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
                    strStatus: '',
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
