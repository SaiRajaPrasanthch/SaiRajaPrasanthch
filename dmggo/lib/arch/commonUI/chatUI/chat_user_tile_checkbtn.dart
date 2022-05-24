import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:flutter/material.dart';

class ChatUserTileCheckBtn extends StatelessWidget {
  final String strUserName;
  final bool isChecked;
  const ChatUserTileCheckBtn({Key? key, required this.strUserName, required this.isChecked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(strUserName),
          trailing: Checkbox(
            value: isChecked,
            activeColor: cgreen,
            onChanged: (v) {},
            shape: rrbr_10,
          ),
        ),
        Divider(
          height: h_05,
          color: cgrey_400,
        )
      ],
    );
  }
}
