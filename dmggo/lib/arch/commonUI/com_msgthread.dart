import 'package:dmggo/arch/commonUI/chatUI/left_chat_bubble.dart';
import 'package:dmggo/arch/commonUI/chatUI/right_chat_bubble.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quickblox_sdk/models/qb_message.dart';

class CommonMessageThread extends StatelessWidget {
  final bool isMsgReceived;
  final bool isGroup;
  final bool isSameId;
  final bool isSameDay;
  final QBMessage? message;
  final int intNoOfMembers;
  CommonMessageThread({
    Key? key,
    required this.message,
    required this.isGroup,
    required this.isSameId,
    required this.isSameDay,
    required this.isMsgReceived,
    required this.intNoOfMembers,
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
            if (isMsgReceived) LeftChatBubble(message: message!, widgetOf: decision(ctDecision: context), strMsgTime: d12),
            if (!isMsgReceived)
              RightChatBubble(
                message: message!,
                widgetOf: decision(ctDecision: context),
                strMsgTime: d12,
                isGroup: isGroup,
                intGroupCount: intNoOfMembers,
              )
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
    return message!.attachments != null && message!.attachments!.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [attchmentsHandle(ctattach: ctDecision), if (message!.body != null) textHandle(message!.body!)],
          )
        : textHandle(message!.body!);
  }

  Widget textHandle(String strMessage) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 15),
      child: Container(
        constraints: BoxConstraints(minWidth: 60),
        child: Text(
          strMessage,
          softWrap: true,
          style: tscwnsn_14b,
        ),
      ),
    );
  }

  Widget attchmentsHandle({required BuildContext ctattach}) {
    return message!.attachments!.length > 2
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 2 / 2, crossAxisSpacing: 15, mainAxisSpacing: 5),
            itemCount: message!.attachments!.length < 4 ? message!.attachments!.length : 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext ctx, index) {
              return Stack(
                children: [
                  message!.attachments![index]!.type == 'Attachment'
                      ? file(bottom: h_15, ctImage: ctattach, strFile: message!.attachments![index]!.contentType!.split('/')[1])
                      : imageLoad(urlImage: message!.attachments![index]!.url!, ctImage: ctattach, bottom: h_15),
                  if (message!.attachments!.length > 4 && index == 3)
                    Container(
                      color: cgrey_200.withOpacity(0.4),
                      width: MediaQuery.of(ctattach).size.width * 0.60,
                      height: MediaQuery.of(ctattach).size.height * 0.25,
                      child: Center(
                        child: Text(
                          '+ ${message!.attachments!.length - 4}',
                          style: tscw400sn_25b,
                        ),
                      ),
                    )
                ],
              );
            })
        : ListView.builder(
            shrinkWrap: true,
            itemCount: message!.attachments!.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return message!.attachments![index]!.type == 'Attachment'
                  ? file(bottom: h_15, ctImage: ctattach, strFile: message!.attachments![index]!.contentType!.split('/')[1])
                  : imageLoad(urlImage: message!.attachments![index]!.url!, ctImage: ctattach, bottom: h_15);
            });
  }

  Widget imageLoad({String? urlImage, required BuildContext ctImage, double? bottom}) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom!),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Image.network(
          urlImage!,

          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
              ),
            );
          },
          // CircularPercentIndicator(
          //   radius: 30,
          //   progressColor: cgreen,
          //   backgroundColor: cgrey_100,
          //   percent: loadingProgress!.cumulativeBytesLoaded / 100,
          // ),
          width: MediaQuery.of(ctImage).size.width * 0.60,
          height: MediaQuery.of(ctImage).size.height * 0.25,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget file({
    double? bottom,
    String? strFile,
    required BuildContext ctImage,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom!),
      child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Container(
            color: appColor.withOpacity(0.3),
            width: MediaQuery.of(ctImage).size.width * 0.60,
            height: MediaQuery.of(ctImage).size.width * 0.20,
            child: Row(
              children: [
                Image.asset(imgFile),
                Text(
                  strFile!,
                  style: tscwbsn_14b,
                )
              ],
            ),
          )),
    );
  }
}
