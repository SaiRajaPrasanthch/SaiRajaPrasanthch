import 'dart:async';

import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/mappers/qb_message_mapper.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/models/qb_sort.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class ChatMsgListProviderV2 with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<QBMessage?> _messages = [];
  List<QBMessage?> get messages => _messages;
  QBDialog? dialogDetails;
  ChatMsgListProviderV2({this.dialogDetails});
  StreamSubscription? subReceiveMsg;
  StreamSubscription? subDeliveredMsg;
  StreamSubscription? subReadMsg;
  ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;
  Map<String, String> properties = {};

  set loading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set listMessages(List<QBMessage?> value) {
    _messages = value.reversed.toList();
  }

  chatMessages({
    required String strRoomId,
    int? limit = 30,
  }) async {
    try {
      loading = true;
      QBSort sort = QBSort();
      sort.field = QBChatMessageSorts.DATE_SENT;
      sort.ascending = false;
      sort.type = QBChatMessageFilterOperators.LTE;
      listMessages = await QB.chat.getDialogMessages(strRoomId, limit: limit!, sort: sort, markAsRead: false);
      scrollDown();
      loading = false;
      makeReceipt();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
  }

  makeReceipt() {
    List<QBMessage?> m = _messages.where((element) => element!.readIds!.length >= i_1).toList();
    for (var element in m) {
      ChatApi().markDelivered(element!);
      ChatApi().markRead(element);
    }
  }

  scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 1);
    }
  }

  sendMessage({String? strMessage}) async {
    properties["sendername"] = qbUser!.fullName!;
    await QB.chat.sendMessage(
      dialogDetails!.id!,
      body: strMessage!.trim(),
      saveToHistory: true,
      markable: true,
      properties: properties,
    );
  }

  subscribeEvents() {
    getReceiveMessages();
    getDeliveredMessages();
    getReadMessages();
  }

  Future<bool> unSubscribeEvents() async {
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
    listMessages = [];
    return true;
  }

  getReceiveMessages() async {
    subReceiveMsg = await QB.chat.subscribeChatEvent(qbEventReceiveNewMessage, (data) {
      Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(data);
      Map<dynamic, dynamic> payload = Map<dynamic, dynamic>.from(map["payload"]);
      QBMessage? msg = QBMessageMapper.mapToQBMessage(payload);
      Iterable<QBMessage?> msgExist = _messages.where((element) => element!.id == msg!.id && dialogDetails!.id! == msg.dialogId);
      if (!msgExist.isNotEmpty) {
        _messages.add(msg);
        scrollDown();
        notifyListeners();
        ChatApi().markDelivered(msg!);

        Future.delayed(Duration(seconds: 1), () {
          ChatApi().markRead(msg);
        });
      }
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
    Iterable<QBMessage?> msgExist = _messages.where((element) => element!.id == strMessageId);
    if (msgExist.isNotEmpty) {
      m = msgExist.first!;
    }

    if (strStatusType!.contains('MESSAGE_DELIVERED')) {
      if (!m.deliveredIds!.contains(intUserId)) {
        m.deliveredIds!.add(intUserId!);
      }
    }
    if (strStatusType.contains('MESSAGE_READ')) {
      if (!m.readIds!.contains(intUserId)) {
        m.readIds!.add(intUserId!);
      }
    }
    int index = _messages.indexWhere((element) => element!.id == strMessageId);
    _messages.removeWhere((element) => element!.id == strMessageId);
    _messages.insert(index, m);
    notifyListeners();
  }
}
