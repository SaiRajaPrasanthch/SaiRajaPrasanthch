import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatTimeUI extends StatelessWidget {
  final String strMsgTime;
  final Object? strStatus;
  ChatTimeUI({Key? key, required this.strMsgTime, this.strStatus}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2, left: 3),
      child: SizedBox(
        height: 15,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              strMsgTime,
              softWrap: true,
              style: tscwnsn_10gy600,
            ), //TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.grey.shade600)
            if (strStatus != null)
              SvgPicture.asset(
                  strStatus == status.sent || strStatus == status.await
                      ? imgChatSent
                      : strStatus == status.delivered || strStatus == status.read
                          ? imgChatDelivered
                          : imgChatSent,
                  color: strStatus == status.read ? cblue : cgrey_600)
          ],
        ),
      ),
    );
  }
}
