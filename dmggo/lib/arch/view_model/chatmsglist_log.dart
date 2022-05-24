import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class ChatMsgListProvider {
  List<QBMessage?> messages = [];

  StreamSubscription? someSubscription;
  chatMessages(String strRoomId) async {
    try {
      messages = await QB.chat.getDialogMessages(strRoomId);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
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
