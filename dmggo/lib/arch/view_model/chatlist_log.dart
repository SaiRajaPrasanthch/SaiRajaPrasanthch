import 'dart:async';

import 'package:dmggo/arch/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class ChatListViewModel with ChangeNotifier {
  List<QBDialog?> _dialogs = [];

  List<QBDialog?> get dialogs => _dialogs;

  StreamSubscription? someSubscription;

  setDialogs(List<QBDialog?> dialogs) {
    _dialogs = dialogs;
    notifyListeners();
  }

  //constructor
  ChatListViewModel() {
    someSubscription = null;
    // chatReadSubcriptions();
    // getChatListData();
  }

  getChatListData() async {
    List<QBDialog?> _ldialogs = [];
    _ldialogs = await QB.chat.getDialogs();
    setDialogs(_ldialogs);
  }

  chatReadSubcriptions() async {
    try {
      someSubscription =
          await QB.chat.subscribeChatEvent(qbEventReceiveNewMessage, (data) {
        getChatListData();
      });

      // someSubscription?.onData((data) {
      //   getChatListData();
      // });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
  }

  updateChatListData() async {
    QBDialog? _ldialogs = QBDialog();
    // _ldialogs = await QB.chat.updateDialog();
    // setDialogs(_ldialogs);
  }
}
