import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_chat_listtile.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view_model/chatlist_logv2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatListScreenV2 extends StatelessWidget {
  const ChatListScreenV2({Key? key}) : super(key: key);

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
          child: context.watch<ChatListViewModelV2>().listdialogs.isNotEmpty ? listDialogs(context: context) : noChatAvail(context: context),
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
        itemCount: context.watch<ChatListViewModelV2>().listdialogs.length,
        itemBuilder: (context, index) {
          return CommonChatListTile(
            value: context.watch<ChatListViewModelV2>().listdialogs[index]!,
            onTap: () {
              context.read<ChatListViewModelV2>().selectedDialog(index: index, context: context);
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
              // getData();
              // reDraw();
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
