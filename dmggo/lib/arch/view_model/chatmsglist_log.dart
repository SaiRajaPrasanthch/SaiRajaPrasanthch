import 'dart:async';
import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/models/qb_sort.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class ChatMsgListProvider {
  List<QBMessage?> messages = [];

  StreamSubscription? someSubscription;
  chatMessages({
    required String strRoomId,
    int? limit = 30,
  }) async {
    try {
      QBSort sort = QBSort();
      sort.field = QBChatMessageSorts.DATE_SENT;
      sort.ascending = false;
      sort.type = QBChatMessageFilterOperators.LTE;
      messages = await QB.chat.getDialogMessages(strRoomId, limit: limit!, sort: sort, markAsRead: false);
      messages = messages.reversed.toList();
      makeReceipt();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
  }

  makeReceipt() {
    List<QBMessage?> m = messages.where((element) => element!.readIds!.length >= i_1).toList();
    for (var element in m) {
      ChatApi().markRead(element!);
    }
  }

  chatSendMSG({required strDialogId, @required txtChatMsg}) async {
    try {
      await QB.chat.sendMessage(strDialogId, body: txtChatMsg, saveToHistory: true);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
