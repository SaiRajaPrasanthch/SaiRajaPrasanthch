import 'package:dmggo/arch/commonUI/chatUI/chat_user_tile_checkbtn.dart';
import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:flutter/material.dart';

class ChatUsersGroupSelection extends StatefulWidget {
  const ChatUsersGroupSelection({Key? key}) : super(key: key);

  @override
  State<ChatUsersGroupSelection> createState() => _ChatUsersGroupSelectionState();
}

class _ChatUsersGroupSelectionState extends State<ChatUsersGroupSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: false,
        elevation: h_0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '',
              style: tscwbsn_18wh,
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: listUsers(context: context)),
            Padding(
              padding: EdgeInsets.all(h_5),
              child: CommonButton(
                onPressed: () {
                  if (listUsersSelected.isEmpty) {
                    return;
                  }
                  listUsersSelected.add(qbUser!.id!);
                  openGroupCreation(context);
                },
                color: listUsersSelected.isNotEmpty ? appColor : cgrey_300,
                dWidth: screenWidth!,
                strBtnText: strNext,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listUsers({required BuildContext context}) {
    return ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          bool isChecked = listUsersSelected.contains(userList[index]!.id!);
          return GestureDetector(
            onTap: () {
              setState(() {
                ChatListViewModel().selectUsersForGroupCreation(index: index);
              });
            },
            child: ChatUserTileCheckBtn(
              strUserName: userList[index]!.fullName!,
              isChecked: isChecked,
            ),
          );
        });
  }
}
