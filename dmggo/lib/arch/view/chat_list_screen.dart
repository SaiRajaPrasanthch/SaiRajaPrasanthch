import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
// import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/commonUI/com_chat_listtile.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    ChatListViewModel chatNotifier =
        Provider.of<ChatListViewModel>(context, listen: false);
    chatNotifier.getChatListData();
    chatNotifier.chatReadSubcriptions();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: h_0,
          title: Text(
            'Chat',
            style: grfwbsn_18wh,
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
            chatPopupMenu()
          ],
        ),
        body: Container(
          child: listDialogs(context: context),
        ));
  }

  listDialogs({required BuildContext context}) {
    ChatListViewModel d = context.watch<ChatListViewModel>();
    if (d.someSubscription != null) {
      d.someSubscription!.onData((data) {
        print('hi');
      });
    }
    return ListView.builder(
        itemCount: d.dialogs.length,
        itemBuilder: (context, index) {
          return CommonChatListTile(value: d.dialogs[index]!);
        });
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
