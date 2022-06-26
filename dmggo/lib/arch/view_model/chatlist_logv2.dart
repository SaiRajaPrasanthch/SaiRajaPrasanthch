import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view_model/chatmsglist_logv2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class ChatListViewModelV2 with ChangeNotifier {
  List<QBDialog?> _listdialogs = [];
  List<QBDialog?> get listdialogs => _listdialogs;
  QBDialog _dialogDetails = QBDialog();
  QBDialog get dialogDetails => _dialogDetails;
  set details(QBDialog value) {
    _dialogDetails = value;
    notifyListeners();
  }

  set setDialogs(List<QBDialog?> v) {
    _listdialogs = v;
    notifyListeners();
  }

  getChatListData() async {
    setDialogs = await QB.chat.getDialogs();
  }

  selectedDialog({required int index, required BuildContext context}) {
    details = _listdialogs[index]!;
    openChatScreenV2(context);
    context.read<ChatMsgListProviderV2>().chatMessages(strRoomId: dialogDetails.id!);
    context.read<ChatMsgListProviderV2>().subscribeEvents();
  }
}
