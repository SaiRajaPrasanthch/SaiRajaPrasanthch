import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/mappers/qb_message_mapper.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class ChatListProvider with ChangeNotifier {

  List<QBDialog?> dialogs = [];
  chatListData() async {
    dialogs = await QB.chat.getDialogs();
    notifyListeners();
  }

 

 
}
