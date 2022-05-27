import 'package:dmggo/arch/commonUI/chatUI/left_chat_bubble.dart';
import 'package:dmggo/arch/commonUI/chatUI/right_chat_bubble.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickblox_sdk/models/qb_message.dart';

class CommonMessageThread extends StatelessWidget {
  final bool isMsgReceived;
  final bool isGroup;
  final bool isSameId;
  final bool isSameDay;
  final QBMessage? message;
  CommonMessageThread({
    Key? key,
    required this.message,
    required this.isGroup,
    required this.isSameId,
    required this.isSameDay,
    required this.isMsgReceived,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(message!.dateSent!);
    var d12 = DateFormat('hh:mm a').format(dt); // 12/31/2000, 10:00 PM
    var d1 = DateFormat('dd/MM/yyyy').format(dt); // 12/31/2000, 10:00 PM

    return Column(
      crossAxisAlignment: isMsgReceived ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        if (!isSameDay)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                d1,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
          ),
        if (!isSameId && isGroup && message!.properties!['sendername'] != null)
          Padding(
            padding: EdgeInsets.only(left: 5, top: 5, right: 5),
            child: Text(
              message!.properties!['sendername']!,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isMsgReceived) LeftChatBubble(message: message!.body!, widgetOf: decision(ctDecision: context), strMsgTime: d12),
            if (!isMsgReceived) RightChatBubble(message: message!.body!, widgetOf: decision(ctDecision: context), strMsgTime: d12)
            // Container(
            //   constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / hp_12),
            //   child: Stack(
            //     children: [
            //       Card(
            //         color: cgrey_200,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             Padding(
            //               padding: EdgeInsets.all(h_5),
            //               child: Text(
            //                 strMessage,
            //                 style: tscwnsn_16b,
            //                 textAlign: TextAlign.justify,
            //               ),
            //             ),
            //             Padding(
            //               padding: EdgeInsets.only(right: !isMsgReceived ? h_20 : h_2, left: h_5),
            //               child: Text(
            //                 d12,
            //                 style: tscwnsn_12gy,
            //                 textAlign: TextAlign.right,
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //       if (!isMsgReceived)
            //         Positioned(
            //             right: h_5,
            //             bottom: h_5,
            //             child: Icon(
            //               strStatus == status.await.toString()
            //                   ? Icons.access_time_rounded
            //                   : strStatus == status.delivered.toString()
            //                       ? Icons.check
            //                       : Icons.check,
            //               size: h_15,
            //               color: strStatus == status.read.toString() ? cblue_300 : cgrey_400,
            //             ))
            //     ],
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  Widget decision({required BuildContext ctDecision}) {
    return message!.attachments != null && message!.attachments![0]!.url != null
        ? imageLoad(urlImage: message!.attachments![0]!.url!, ctImage: ctDecision)
        : Padding(
            padding: const EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 15),
            child: Container(
              constraints: BoxConstraints(minWidth: 60),
              child: Text(
                message!.body!,
                softWrap: true,
                style: tscwnsn_14b,
              ),
            ),
          );
  }

  Widget imageLoad({String? urlImage, required BuildContext ctImage}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Image.network(
          urlImage!,
          width: MediaQuery.of(ctImage).size.width * 0.60,
          height: MediaQuery.of(ctImage).size.width * 0.60,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
