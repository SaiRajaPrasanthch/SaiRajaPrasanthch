import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class ChatListViewModel with ChangeNotifier {
  List<QBDialog?> _dialogs = [];

  List<QBDialog?> get dialogs => _dialogs;

  setDialogs(List<QBDialog?> dialogs) {
    _dialogs = dialogs;
    notifyListeners();
  }

  //constructor
  ChatListViewModel() {
    chatListData();
  }

  chatListData() async {
    _dialogs = await QB.chat.getDialogs();
    notifyListeners();
  }
}
