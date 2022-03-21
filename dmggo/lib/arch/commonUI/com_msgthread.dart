import 'package:flutter/material.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';

class CommonMessageThread extends StatelessWidget {
  final String strMessage;
  final bool isMsgReceived;
  final String strTime;
  final String? strStatus;
  CommonMessageThread(
      {Key? key,
      required this.strMessage,
      required this.isMsgReceived,
      required this.strTime,
      required this.strStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          isMsgReceived ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / hp_12),
          child: Stack(
            children: [
              Card(
                color: cgrey_200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(h_5),
                      child: Text(
                        strMessage,
                        style: grfwnsn_16b,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: !isMsgReceived ? h_20 : h_2, left: h_5),
                      child: Text(
                        strTime,
                        style: grfwnsn_12gy,
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              ),
              if (!isMsgReceived)
                Positioned(
                    right: h_5,
                    bottom: h_5,
                    child: Icon(
                      strStatus == status.await.toString()
                          ? Icons.access_time_rounded
                          : strStatus == status.delivered.toString()
                              ? Icons.check
                              : Icons.check,
                      size: h_15,
                      color: strStatus == status.read.toString()
                          ? cblue_300
                          : cgrey_400,
                    ))
            ],
          ),
        ),
      ],
    );
  }
}
