import 'dart:async';

import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/view_model/bottombar_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

List<QBDialog?> _dialogs = [];
List<QBUser?> userList = [];
StreamSubscription? subscriptionReceiveMsg;
StreamSubscription? subscriptionSystemMsg;

List<int> listUsersSelected = [];

class ChatListViewModel with ChangeNotifier {
  List<QBDialog?> get dialogs => _dialogs;

  setDialogs(List<QBDialog?> dialogs) {
    _dialogs = dialogs;
    notifyListeners();
  }

  //constructor
  // ChatListViewModel() {
  //   someSubscription = null;
  //   chatReadSubcriptions();
  //   getChatListData();
  // }

  getChatListData() async {
    List<QBDialog?> _ldialogs = [];
    _ldialogs = await QB.chat.getDialogs();
    setDialogs(_ldialogs);
    // Provider.of<BottomNavigationBarProvider>(context, listen: true)
    BottomNavigationBarProvider barProvider = BottomNavigationBarProvider();
    // int w = _ldialogs.fold(0, (sum, element) => sum + element!.unreadMessagesCount!);
    // print(w);
    barProvider.notifyListeners();
  }

  chatReadSubcriptions() async {
    try {
      // someSubscription = await QB.chat.subscribeChatEvent(qbEventReceiveNewMessage, (data) {
      //   getChatListData();
      // });

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

  getUsers() async {
    userList = await QB.users.getUsers();
    userList.removeAt(userList.indexWhere((element) => element!.id == qbUser!.id!));
  }

  selectUsersForGroupCreation({required int index}) {
    if (listUsersSelected.contains(userList[index]!.id!)) {
      listUsersSelected.remove(userList[index]!.id!);
    } else {
      listUsersSelected.add(userList[index]!.id!);
    }
  }

  // updateChatListData() async {
  //   QBDialog? _ldialogs = QBDialog();
  //   // _ldialogs = await QB.chat.updateDialog();
  //   // setDialogs(_ldialogs);
  // }
}
