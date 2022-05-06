import 'package:dmggo/arch/view_model/chatmsglist_log.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/commonUI/com_msgthread.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:provider/provider.dart';
import 'package:quickblox_sdk/models/qb_message.dart';

class ChatScreen extends StatelessWidget {
  final String strName;
  final String? strProfileImg;
  final bool bIsGroup;
  final String strDialogId;
  ChatScreen({Key? key, required this.strName, this.strProfileImg, required this.bIsGroup, required this.strDialogId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ChatMsgListProvider chatlog = context.watch<ChatMsgListProvider>();
    chatlog.chatMessages(strDialogId);
    print('hi');
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            // centerTitle: false,
            elevation: h_0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(bIsGroup ? Icons.groups_rounded : Icons.person),
                ),
                sbh_5w_5,
                Text(
                  strName,
                  style: grfwbsn_18wh,
                ),
              ],
            ),
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)), if (!bIsGroup) contactPopupMenu(), if (bIsGroup) groupPopupMenu()],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Expanded(
                //     child: listMsg(
                //   context: context,
                //   // chatlog: chatlog.messages
                // )),
                textfield(context: context)
              ],
            ),
          )),
    );
  }

// chat textfield with send button add attachment Icon
  Widget textfield({
    required BuildContext context,
  }) {
    TextEditingController txtChat = TextEditingController();
    ChatMsgListProvider chatlog = Provider.of<ChatMsgListProvider>(
      context,
      //  listen: false
    );

    return Container(
      alignment: Alignment.bottomCenter,
      color: cgrey_200,
      child: Padding(
        padding: EdgeInsets.all(h_5),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: brCir_20,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      sbh_5w_5,
                      // Icon(Icons.insert_emoticon,
                      //     size: h_30, color: Theme.of(context).hintColor),
                      sbh_5w_5,
                      Expanded(
                        child: TextField(
                          controller: txtChat,
                          maxLines: 4,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: strTypeMsg,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      sbh_5w_5,
                      sbh_5w_5,
                      Icon(Icons.attach_file, size: h_30, color: Theme.of(context).hintColor),
                      sbh_5w_5,
                    ],
                  ),
                ),
              ),
            ),
            sbh_5w_5,
            GestureDetector(
              onTap: () {
                // chatlog.chatSendMSG(strDialogId: strDialogId, txtChatMsg: txtChat.text);
                txtChat.clear();
              },
              child: CircleAvatar(
                child: Icon(Icons.send),
              ),
            ),
          ],
        ),
      ),
    );
  }

// popup menu item for group category
  Widget groupPopupMenu() {
    return PopupMenuButton(
        child: Icon(Icons.more_vert_rounded),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  strGroupInfo,
                  style: grfwnsn_16b,
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Text(
                  strClearChat,
                  style: grfwnsn_16b,
                ),
                value: 2,
              ),
              PopupMenuItem(
                child: Text(
                  strMuteNotify,
                  style: grfwnsn_16b,
                ),
                value: 3,
              ),
              PopupMenuItem(
                child: Text(
                  strExitGroup,
                  style: grfwnsn_16b,
                ),
                value: 4,
              ),
            ]);
  }

// popup menu item for individual category
  Widget contactPopupMenu() {
    return PopupMenuButton(
        child: Icon(Icons.more_vert_rounded),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  strContInfo,
                  style: grfwnsn_16b,
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Text(
                  strClearChat,
                  style: grfwnsn_16b,
                ),
                value: 2,
              ),
              PopupMenuItem(
                child: Text(
                  strMuteNotify,
                  style: grfwnsn_16b,
                ),
                value: 3,
              ),
              PopupMenuItem(
                child: Text(
                  strBlock,
                  style: grfwnsn_16b,
                ),
                value: 4,
              ),
            ]);
  }

// list of message
  Widget listMsg({required BuildContext context, required List<QBMessage?> chatlog}) {
    return ListView.builder(
        itemCount: chatlog.length,
        itemBuilder: (context, index) {
          bool isSameId = false;
          if (index > 0 && chatlog[index]!.senderId == chatlog[index - 1]!.senderId) {
            isSameId = true;
          }
          bool isSameDate = false;

          if (index > 0) {
            DateTime dt = DateTime.fromMillisecondsSinceEpoch(chatlog[index]!.dateSent!);
            DateTime dt1 = DateTime.fromMillisecondsSinceEpoch(chatlog[index - 1]!.dateSent!);
            if (dt1.day == dt.day && dt1.month == dt.month && dt1.year == dt.year) {
              isSameDate = true;
            }
          }
          return CommonMessageThread(
            isGroup: bIsGroup,
            isSameId: isSameId,
            isSameDay: isSameDate,
            isMsgReceived: chatlog[index]!.senderId == qbUser!.id! ? false : true,
            message: chatlog[index],
          );
        });
  }
}
