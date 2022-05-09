import 'dart:async';

import 'package:dmggo/arch/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/mappers/qb_message_mapper.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class ChatMsgListProvider with ChangeNotifier {
  List<QBMessage?> messages = [];
  StreamSubscription? someSubscription;
 ChatMsgListProvider() {
 
  }
  chatMessages(String strRoomId) async {
    try {
      // messages = await QB.chat.getDialogMessages(strRoomId, markAsRead: true);
      notifyListeners();

      // chatReadSubcriptions();
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
