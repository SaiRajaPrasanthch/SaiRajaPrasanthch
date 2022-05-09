import 'dart:async';

import 'package:dmggo/arch/models/qbMessage.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class ChatMsgListProvider with ChangeNotifier {
  List<QBMessageLocal?> localMessages = [];
  List<QBMessageLocal?> localMessagesOld = [];
  List<QBMessage?> messages = [];

  StreamSubscription? someSubscription;
  chatMessages(String strRoomId) async {
    try {
      messages = await QB.chat.getDialogMessages(strRoomId, markAsRead: true);

      // messages.forEach(((element) {
      //   QBMessageLocal localMessage = QBMessageLocal();
      //   localMessage.id = element!.id;
      //   localMessage.attachments = element.attachments;
      //   localMessage.properties = element.properties;
      //   localMessage.dateSent = element.dateSent;
      //   localMessage.senderId = element.senderId;
      //   localMessage.recipientId = element.recipientId;
      //   localMessage.readIds = element.readIds;
      //   localMessage.deliveredIds = element.deliveredIds;
      //   localMessage.dialogId = element.dialogId;
      //   localMessage.markable = element.markable;
      //   localMessage.delayed = element.delayed;
      //   localMessage.body = element.body;

      //   localMessages.add(localMessage);
      // }));

      // if (localMessages != localMessagesOld) {
      //   notifyListeners();
      //   localMessages = localMessagesOld;
      // }

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
