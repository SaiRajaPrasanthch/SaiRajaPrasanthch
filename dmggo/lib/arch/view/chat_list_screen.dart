import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
// import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/commonUI/com_chat_listtile.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatListProvider d = Provider.of<ChatListProvider>(
      context,
      //  listen: false
    );
    Future.delayed(Duration(seconds: 2), () {
      d.chatListData();
    });
    print('loop');
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: h_0,
          title: Text(
            'Chat',
            style: grfwbsn_18wh,
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)), chatPopupMenu()],
        ),
        body: ListView.builder(
            itemCount: d.dialogs.length,
            itemBuilder: (context, index) {
              return CommonChatListTile(value: d.dialogs[index]!);
            }));
  }

// popup menu item for chat
  Widget chatPopupMenu() {
    return PopupMenuButton(
        child: Icon(Icons.more_vert_rounded),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  strAddGroup,
                  style: grfwnsn_16b,
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Text(
                  strAddDriver,
                  style: grfwnsn_16b,
                ),
                value: 2,
              ),
              PopupMenuItem(
                child: Text(
                  strSettings,
                  style: grfwnsn_16b,
                ),
                value: 3,
              ),
              PopupMenuItem(
                child: Text(
                  strDelete,
                  style: grfwnsn_16b,
                ),
                value: 4,
              ),
              PopupMenuItem(
                child: Text(
                  strHelp,
                  style: grfwnsn_16b,
                ),
                value: 5,
              ),
            ]);
  }
}
