import 'package:dmggo/arch/commonUI/chatUI/chat_user_tile.dart';
import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view/chat_screen.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:flutter/material.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';

class ChatUsersScreen extends StatefulWidget {
  const ChatUsersScreen({Key? key}) : super(key: key);

  @override
  State<ChatUsersScreen> createState() => _ChatUsersScreenState();
}

class _ChatUsersScreenState extends State<ChatUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: false,
        elevation: h_0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Chat with',
              style: tscwbsn_18wh,
            ),
          ],
        ),
        // actions: [
        // IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
        // ],
      ),
      body: userList.isNotEmpty
          ? listUsers(context: context)
          : Center(
              child: Text(
                'No User are Available to chat',
                style: tscwbsn_14gy500,
              ),
            ),
    );
  }

  Widget listUsers({required BuildContext context}) {
    return ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              listUsersSelected = [];
              listUsersSelected.add(qbUser!.id!);
              listUsersSelected.add(userList[index]!.id!);
              QBDialog createdDialog = await ChatApi().createDialog(listusers: listUsersSelected, strDialogName: userList[index]!.fullName!, intDialogType: QBChatDialogTypes.CHAT);

              exitScreen(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            bIsGroup: false,
                            strName: createdDialog.name!,
                            strDialogId: createdDialog.id!,
                            intNoOfMembers: listUsersSelected.length,
                          )));
              listUsersSelected = [];
            },
            child: ChatUserTile(
              strUserName: userList[index]!.fullName!,
            ),
          );
        });
  }
}
