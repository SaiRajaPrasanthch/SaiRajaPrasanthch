import 'dart:async';

import 'package:dmggo/arch/commonUI/com_msgthread.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view_model/chatmsglist_log.dart';
import 'package:flutter/material.dart';
import 'package:quickblox_sdk/mappers/qb_message_mapper.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class ChatScreen extends StatefulWidget {
  final String strName;
  final String? strProfileImg;
  final bool bIsGroup;
  final String strDialogId;
  final int intNoOfMembers;
  ChatScreen({Key? key, required this.strName, this.strProfileImg, required this.bIsGroup, required this.strDialogId, required this.intNoOfMembers}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatMsgListProvider _chatMsgListViewModel = ChatMsgListProvider();
  Map<String, String> properties = {};
  final ScrollController _scrollController = ScrollController();
  StreamSubscription? subReceiveMsg;
  StreamSubscription? subDeliveredMsg;
  StreamSubscription? subReadMsg;
  int _limit = i_40;
  bool isTop = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getUpdatedMessages();
    getDeliveredMessages();
    getReadMessages();
    getData(_limit);
  }

  Future<void> getData(int limit) async {
    setState(() {
      isLoading = true;
    });
    await _chatMsgListViewModel.chatMessages(strRoomId: widget.strDialogId, limit: limit);
    setState(() {
      isLoading = false;
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        if (_scrollController.hasClients && !isTop) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    });
  }

  getUpdatedMessages() async {
    subReceiveMsg = await QB.chat.subscribeChatEvent(qbEventReceiveNewMessage, (data) {
      Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(data);
      Map<dynamic, dynamic> payload = Map<dynamic, dynamic>.from(map["payload"]);
      QBMessage? msg = QBMessageMapper.mapToQBMessage(payload);
      Iterable<QBMessage?> msgExist = _chatMsgListViewModel.messages.where((element) => element!.id == msg!.id && widget.strDialogId == msg.dialogId);
      if (!msgExist.isNotEmpty) {
        _chatMsgListViewModel.messages.add(msg);
         ChatApi().markDelivered(msg!);

            Future.delayed(Duration(seconds: 1), () {
              ChatApi().markRead(msg);
            });
        setState(() {});
      }

      setState(() {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            // if (msgExist.isNotEmpty) {
           
            // }
          }
        });
      });
    });
  }

  getDeliveredMessages() async {
    subDeliveredMsg = await QB.chat.subscribeChatEvent(qbDeliveredMessage, (data) {});
    subDeliveredMsg!.onData((data) {
      Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(data);
      Map<dynamic, dynamic> payload = Map<dynamic, dynamic>.from(map["payload"]);
      String messageId = payload["messageId"];
      int userId = payload["userId"];
      String statusType = map["type"];
      addRecipt(intUserId: userId, strMessageId: messageId, strStatusType: statusType);
    });
  }

  getReadMessages() async {
    subReadMsg = await QB.chat.subscribeChatEvent(qbReadMessage, (data) {});
    subReadMsg!.onData((data) {
      Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(data);
      Map<dynamic, dynamic> payload = Map<dynamic, dynamic>.from(map["payload"]);
      String messageId = payload["messageId"];
      int userId = payload["userId"];
      String statusType = map["type"];
      Future.delayed(Duration(seconds: 1), () {
        addRecipt(intUserId: userId, strMessageId: messageId, strStatusType: statusType);
      });
    });
  }

  addRecipt({
    int? intUserId,
    String? strStatusType,
    String? strMessageId,
  }) {
    QBMessage m = QBMessage();
    Iterable<QBMessage?> msgExist = _chatMsgListViewModel.messages.where((element) => element!.id == strMessageId);
    if (msgExist.isNotEmpty) {
      m = msgExist.first!;
    }

    if (strStatusType == 'MESSAGE_DELIVERED') {
      // _chatMsgListViewModel.messages.where((element) {
      //   if (element!.id == strMessageId) {
      //     if (!element.deliveredIds!.contains(intUserId)) {
      //       element.deliveredIds!.add(intUserId!);
      //     }

      //     return true;
      //   }

      //   return false;
      // });
      if (!m.deliveredIds!.contains(intUserId)) {
        m.deliveredIds!.add(intUserId!);
        int index = _chatMsgListViewModel.messages.indexWhere((element) => element!.id == strMessageId);
        _chatMsgListViewModel.messages.removeWhere((element) => element!.id == strMessageId);
        _chatMsgListViewModel.messages.insert(index, m);
      }
    }
    if (strStatusType == 'MESSAGE_READ') {
      // _chatMsgListViewModel.messages.where((element) {
      //   if (element!.id == strMessageId) {
      //     if (!element.readIds!.contains(intUserId)) {
      //       element.readIds!.add(intUserId!);
      //     }

      //     return true;
      //   }
      //   return false;
      // });
      if (!m.readIds!.contains(intUserId)) {
        m.readIds!.add(intUserId!);
        int index = _chatMsgListViewModel.messages.indexWhere((element) => element!.id == strMessageId);
        _chatMsgListViewModel.messages.removeWhere((element) => element!.id == strMessageId);
        _chatMsgListViewModel.messages.insert(index, m);
      }
    }

    setState(() {
      // WidgetsBinding.instance?.addPostFrameCallback((_) {
      //   if (_scrollController.hasClients) {
      //     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      //   }
      // });
    });
  }

  @override
  void dispose() {
    if (subReceiveMsg != null) {
      subReceiveMsg!.cancel();
      subReceiveMsg = null;
    }
    if (subDeliveredMsg != null) {
      subDeliveredMsg!.cancel();
      subDeliveredMsg = null;
    }
    if (subReadMsg != null) {
      subReadMsg!.cancel();
      subReadMsg = null;
    }
    // viewKey.currentState?.getData();
    // viewKey.currentState?.reDraw();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // centerTitle: false,
          elevation: h_0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Icon(widget.bIsGroup ? Icons.groups_rounded : Icons.person),
              ),
              sbh_5w_5,
              Expanded(
                flex: 4,
                child: Text(
                  widget.strName,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: tscwnsn_14wh,
                ),
              ),
            ],
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)), if (!widget.bIsGroup) contactPopupMenu(), if (widget.bIsGroup) groupPopupMenu()],
        ),
        body: SafeArea(
          child: Column(
            children: [
              if (isLoading)
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
              Expanded(child: listMsg(context: context, chatlog: _chatMsgListViewModel.messages)),
              textfield(context: context)
            ],
          ),
        ));
  }

// chat textfield with send button add attachment Icon
  Widget textfield({
    required BuildContext context,
  }) {
    TextEditingController txtChat = TextEditingController();

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
              onTap: () async {
                if (txtChat.text.trim().isNotEmpty) {
                  properties["sendername"] = qbUser!.fullName!;

                  await QB.chat.sendMessage(
                    widget.strDialogId,
                    body: txtChat.text.trim(),
                    saveToHistory: true,
                    markable: true,
                    properties: properties,
                  );
                  txtChat.clear();
                }
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
                  style: tscwnsn_16b,
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Text(
                  strClearChat,
                  style: tscwnsn_16b,
                ),
                value: 2,
              ),
              PopupMenuItem(
                child: Text(
                  strMuteNotify,
                  style: tscwnsn_16b,
                ),
                value: 3,
              ),
              PopupMenuItem(
                child: Text(
                  strExitGroup,
                  style: tscwnsn_16b,
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
                  style: tscwnsn_16b,
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Text(
                  strClearChat,
                  style: tscwnsn_16b,
                ),
                value: 2,
              ),
              PopupMenuItem(
                child: Text(
                  strMuteNotify,
                  style: tscwnsn_16b,
                ),
                value: 3,
              ),
              PopupMenuItem(
                child: Text(
                  strBlock,
                  style: tscwnsn_16b,
                ),
                value: 4,
              ),
            ]);
  }

// list of message
  Widget listMsg({required BuildContext context, required List<QBMessage?> chatlog}) {
    print(chatlog);
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        final metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          isTop = metrics.pixels == 0;
          if (isTop) {
            getData(_limit = _limit + i_40);
          } else {
            isTop = false;
          }
        }
        return true;
      },
      child: ListView.builder(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
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
            // 134859157- user

            return CommonMessageThread(
              isGroup: widget.bIsGroup,
              isSameId: isSameId,
              isSameDay: isSameDate,
              isMsgReceived: chatlog[index]!.senderId == qbUser!.id! ? false : true,
              message: chatlog[index],
              intNoOfMembers: widget.intNoOfMembers,
            );
          }),
    );
  }
}
