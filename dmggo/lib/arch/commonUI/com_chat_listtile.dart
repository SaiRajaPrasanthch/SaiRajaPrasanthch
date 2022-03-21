import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/models/chatlist_model.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/view/chat_screen.dart';

class CommonChatListTile extends StatelessWidget {
  final ChatList value;
  CommonChatListTile({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
              backgroundColor: cgrey_200,
              child: value.isGroup
                  ? Icon(Icons.groups_rounded)
                  : Icon(Icons.person)
              //  Image.asset(
              //   carrierLogo,
              //   height: h_30,
              //   width: h_30,
              // ),
              ),
          title: Text(
            value.strName,
            style: grfwnsn_18b,
          ),
          subtitle: value.strText != null
              ? Text(
                  value.strText!,
                  style: grfwnsn_14gy,
                )
              : sbh_5w_0,
          trailing: value.intUnreadMsg != null
              ? Badge(
                  badgeColor: cgreen,
                  shape: BadgeShape.circle,
                  elevation: h_0,
                  padding: EdgeInsets.all(h_5),
                  badgeContent: Text(
                    value.intUnreadMsg.toString(),
                    textAlign: TextAlign.center,
                    style: grfwnsn_14wh,
                  ),
                )
              : sbh_5w_0,
          //// onTap START ////
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        bIsGroup: value.isGroup,
                        strName: value.strName,
                      ))),
          //// onTap END ////
        ),
        Divider(
          height: h_05,
          color: cgrey_500,
        )
      ],
    );
  }
}
