import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:flutter/material.dart';

class ChatUserTile extends StatelessWidget {
  final String strUserName;

  const ChatUserTile({
    Key? key,
    required this.strUserName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(strUserName),
        ),
        Divider(
          height: h_05,
          color: cgrey_400,
        )
      ],
    );
  }
}
