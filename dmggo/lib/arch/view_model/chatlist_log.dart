import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class ChatListProvider with ChangeNotifier {
  List<QBDialog?> dialogs = [];
  // get currentdialogs => dialogs;

  chatListData() async {
    dialogs = await QB.chat.getDialogs();
    // dialogsData = await QB.chat.getDialogs();
  }

  // set dialogsData(List<QBDialog?> dialog) {
  //   dialogs = dialog;
  //   notifyListeners();
  // }
}
