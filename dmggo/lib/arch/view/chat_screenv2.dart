import 'package:dmggo/arch/commonUI/com_msgthread.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view_model/chatmsglist_logv2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreenV2 extends StatelessWidget {
  ChatScreenV2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => context.read<ChatMsgListProviderV2>().unSubscribeEvents(),
      child: GestureDetector(
        onHorizontalDragStart: (detail) {
          if (detail.localPosition.dx < i_40) {
            context.read<ChatMsgListProviderV2>().unSubscribeEvents();
            exitScreen(context);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              // centerTitle: false,
              elevation: h_0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Icon(context.watch<ChatMsgListProviderV2>().dialogDetails!.occupantsIds!.length > i_2 ? Icons.groups_rounded : Icons.person),
                  ),
                  sbh_5w_5,
                  Expanded(
                    flex: 4,
                    child: Text(
                      context.watch<ChatMsgListProviderV2>().dialogDetails!.name!,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: tscwnsn_14wh,
                    ),
                  ),
                ],
              ),
              // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)), if (!context.watch<ChatMsgListProviderV2>().dialogDetails!.occupantsIds!.length>i_2) contactPopupMenu(), if (widget.bIsGroup) groupPopupMenu()],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  if (context.watch<ChatMsgListProviderV2>().isLoading)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: h_20,
                            width: h_20,
                            child: CircularProgressIndicator(
                              color: cblue_200,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Loading old messages',
                              style: tscwnsn_14gy500,
                            ),
                          )
                        ],
                      ),
                    ),
                  Expanded(
                      child: listMsg(
                    context: context,
                  )),
                  textfield(context: context)
                ],
              ),
            )),
      ),
    );
  }

  // list of message
  Widget listMsg({required BuildContext context}) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        // final metrics = scrollEnd.metrics;
        // if (metrics.atEdge) {
        //   isTop = metrics.pixels == 0;
        //   if (isTop) {
        //     getData(_limit = _limit + i_40);
        //   } else {
        //     isTop = false;
        //   }
        // }
        return true;
      },
      child: ListView.builder(
          controller: context.watch<ChatMsgListProviderV2>().scrollController,
          physics: ClampingScrollPhysics(),
          itemCount: context.watch<ChatMsgListProviderV2>().messages.length,
          itemBuilder: (context, index) {
            bool isSameId = false;
            if (index > 0 && context.watch<ChatMsgListProviderV2>().messages[index]!.senderId == context.watch<ChatMsgListProviderV2>().messages[index - 1]!.senderId) {
              isSameId = true;
            }
            bool isSameDate = false;

            if (index > 0) {
              DateTime dt = DateTime.fromMillisecondsSinceEpoch(context.watch<ChatMsgListProviderV2>().messages[index]!.dateSent!);
              DateTime dt1 = DateTime.fromMillisecondsSinceEpoch(context.watch<ChatMsgListProviderV2>().messages[index - 1]!.dateSent!);
              if (dt1.day == dt.day && dt1.month == dt.month && dt1.year == dt.year) {
                isSameDate = true;
              }
            }
            // 134859157- user

            return CommonMessageThread(
              isGroup: context.watch<ChatMsgListProviderV2>().dialogDetails!.occupantsIds!.length > i_2 ? true : false,
              isSameId: isSameId,
              isSameDay: isSameDate,
              isMsgReceived: context.watch<ChatMsgListProviderV2>().messages[index]!.senderId == qbUser!.id! ? false : true,
              message: context.watch<ChatMsgListProviderV2>().messages[index],
              intNoOfMembers: context.watch<ChatMsgListProviderV2>().dialogDetails!.occupantsIds!.length,
            );
          }),
    );
  }

  final TextEditingController txtChat = TextEditingController();
// chat textfield with send button add attachment Icon
  Widget textfield({
    required BuildContext context,
  }) {
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
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          sbh_5w_5,
                          Icon(Icons.insert_emoticon, size: h_30, color: Theme.of(context).hintColor),
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
                          GestureDetector(
                              onTap: () async {
                                // showCupertinoModalPopup(context: context, builder: (context) => media());
                                // Map<Permission, PermissionStatus> statuses = await [
                                //   Permission.photos,
                                //   Permission.accessMediaLocation,
                                //   // Permission.manageExternalStorage,
                                //   // Permission.storage,
                                // ].request();
                                // FilePickerResult? result = await FilePicker.platform.pickFiles();

                                // if (result != null) {
                                // File file = File(result.paths);
                                // } else {
                                // User canceled the picker
                                // }
                              },
                              child: Icon(Icons.attach_file, size: h_30, color: Theme.of(context).hintColor)),
                          sbh_5w_5,
                        ],
                      ),
                      // if (listFile.isNotEmpty) SizedBox(height: h_80, child: listFiles()),
                    ],
                  ),
                ),
              ),
            ),
            sbh_5w_5,
            GestureDetector(
              onTap: () {
                context.read<ChatMsgListProviderV2>().sendMessage(strMessage: txtChat.text);
                // if (isUploadInProgress && listFile.isNotEmpty && listFile.length != attachmentsList.length) {
                //   Fluttertoast.showToast(msg: 'upload still in progress');
                //   return;
                // }
                // if (txtChat.text.trim().isNotEmpty) {
                // properties["sendername"] = qbUser!.fullName!;

                //   await QB.chat.sendMessage(widget.strDialogId, body: txtChat.text.trim(), saveToHistory: true, markable: true, properties: properties, attachments: attachmentsList);
                txtChat.clear();
                // } else {
                //   await QB.chat.sendMessage(widget.strDialogId, saveToHistory: true, markable: true, properties: properties, attachments: attachmentsList);
                // }
                // listFile = [];
                // listProgress = [];
                // attachmentsList = [];
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
}
