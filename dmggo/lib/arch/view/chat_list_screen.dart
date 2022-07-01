import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_chat_listtile.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view/chat_screen.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

GlobalKey<_ChatListScreenState> viewKey = GlobalKey();

// import 'package:provider/provider.dart';
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> with WidgetsBindingObserver {
  final ChatListViewModel _chatListViewModel = ChatListViewModel();
  // StreamSubscription? subscriptionReceive;
  @override
  void initState() {
    super.initState();
    setState(() {});
    WidgetsBinding.instance!.addObserver(this);

    _chatListViewModel.getUsers();

    getupdates();
    getData();
    getSystemupdates();
  }

  void reDraw() {
    getData();
  }

  getupdates() async {
    subscriptionReceiveMsg = await QB.chat.subscribeChatEvent(qbEventReceiveNewMessage, (data) {
      getData();
    });
    subscriptionReceiveMsg!.onData((data) {
      if (kDebugMode) {
        print(data);
      }
      getData();
    });
    setState(() {});
  }

  getSystemupdates() async {
    subscriptionSystemMsg = await QB.chat.subscribeChatEvent(qbEventSystemMessage, (data) {
      getData();
    });
    subscriptionSystemMsg!.onData((data) {
      getData();
    });
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  getData() async {
    await _chatListViewModel.getChatListData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: h_0,
          title: Text(
            strChat,
            style: tscwbsn_18wh,
          ),
          actions: [IconButton(onPressed: () => openChatUserScreen(context), icon: Icon(Icons.search_rounded)), chatPopupMenu(context: context), sbh_5w_10],
        ),
        body: Container(
          child: _chatListViewModel.dialogs.isNotEmpty ? listDialogs(context: context) : noChatAvail(context: context),
        ));
  }

  noChatAvail({required BuildContext context}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset(
                imgNoChat,
                height: h_300,
                width: h_300,
              ),
              Text(
                strNoMessage,
                style: tscwnsn_25b,
              ),
              Text(
                strNoMessSub,
                style: tscwnsn_16b,
              ),
            ],
          ),
          CommonButton(
            color: ctransparent,
            strBtnText: strSearch,
            dWidth: h_200,
            textStyle: tscwnsn_18bl700,
            onPressed: () => openChatUserScreen(context),
          )
        ],
      ),
    );
  }

  listDialogs({required BuildContext context}) {
    return ListView.builder(
        itemCount: _chatListViewModel.dialogs.length,
        itemBuilder: (context, index) {
          QBDialog value = _chatListViewModel.dialogs[index]!;
          return CommonChatListTile(
            value: value,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            bIsGroup: value.occupantsIds!.length > i_2 ? true : false,
                            strName: value.name!,
                            strDialogId: value.id!,
                            intNoOfMembers: value.occupantsIds!.length,
                          ))).then((value) => reDraw());
            },
          );
        });
  }

// popup menu item for chat
  Widget chatPopupMenu({required BuildContext context}) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == 1) {
            openUserSelectionForGroupCreation(context).then((v) {
              getData();
              reDraw();
            });
          }
        },
        child: Icon(Icons.more_vert_rounded),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  strAddGroup,
                  style: tscwnsn_16b,
                ),
                value: 1,
              ),
              // PopupMenuItem(
              //   child: Text(
              //     strAddDriver,
              //     style: tscwnsn_16b,
              //   ),
              // ),
              PopupMenuItem(
                child: Text(
                  strSettings,
                  style: tscwnsn_16b,
                ),
              ),
              PopupMenuItem(
                child: Text(
                  strDelete,
                  style: tscwnsn_16b,
                ),
              ),
              PopupMenuItem(
                child: Text(
                  strHelp,
                  style: tscwnsn_16b,
                ),
              ),
            ]);
  }
}
