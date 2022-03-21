import 'package:flutter/material.dart';
import 'package:dmggo/arch/commonUI/com_msgthread.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';

class ChatScreen extends StatelessWidget {
  final String strName;
  final String? strProfileImg;
  final bool bIsGroup;
  ChatScreen(
      {Key? key,
      required this.strName,
      this.strProfileImg,
      required this.bIsGroup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // centerTitle: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Icon(Icons.person),
              ),
              sbh_5w_5,
              Text(
                strName,
                style: grfwbsn_18wh,
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
            if (!bIsGroup) contactPopupMenu(),
            if (bIsGroup) groupPopupMenu()
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [Expanded(child: listMsg()), textfield(context)],
          ),
        ));
  }

// chat textfield with send button add attachment Icon
  Widget textfield(BuildContext context) {
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
                      Icon(Icons.attach_file,
                          size: h_30, color: Theme.of(context).hintColor),
                      sbh_5w_5,
                    ],
                  ),
                ),
              ),
            ),
            sbh_5w_5,
            GestureDetector(
              onTap: () {},
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
  Widget listMsg() {
    return ListView.builder(
        itemCount: listChat.length,
        itemBuilder: (context, index) {
          return CommonMessageThread(
            isMsgReceived: listChat[index].isReceived!,
            strMessage: listChat[index].stgMsg!,
            strStatus: listChat[index].strStatus,
            strTime: listChat[index].strTime!,
          );
        });
  }
}
