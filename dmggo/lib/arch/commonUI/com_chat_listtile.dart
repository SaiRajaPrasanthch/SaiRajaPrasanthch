import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/view/chat_screen.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';

class CommonChatListTile extends StatelessWidget {
  final QBDialog value;
  CommonChatListTile({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(backgroundColor: cgrey_200, child: value.occupantsIds!.length > i_2 ? Icon(Icons.groups_rounded) : Icon(Icons.person)
              //  Image.asset(
              //   carrierLogo,
              //   height: h_30,
              //   width: h_30,
              // ),
              ),
          title: Text(
            value.name!,
            style: grfwnsn_18b,
          ),
          subtitle: Text(value.lastMessage != null ? value.lastMessage! : "", style: grfwnsn_14gy, maxLines: i_2),
          trailing: value.unreadMessagesCount != null && value.unreadMessagesCount! != 0
              ? Badge(
                  badgeColor: cgreen,
                  shape: BadgeShape.circle,
                  elevation: h_0,
                  padding: EdgeInsets.all(h_5),
                  badgeContent: Text(
                    value.unreadMessagesCount.toString(),
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
                        bIsGroup: value.occupantsIds!.length > i_2 ? true : false,
                        strName: value.name!,
                        strDialogId: value.id!,
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
