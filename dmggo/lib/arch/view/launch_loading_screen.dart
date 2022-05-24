import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view/chat_list_screen.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:dmggo/arch/view_model/login_log.dart';
import 'package:flutter/material.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class LaunchLoadingScreen extends StatefulWidget {
  const LaunchLoadingScreen({Key? key}) : super(key: key);

  @override
  State<LaunchLoadingScreen> createState() => _LaunchLoadingScreenState();
}

class _LaunchLoadingScreenState extends State<LaunchLoadingScreen> {
  @override
  void initState() {
    super.initState();
    create();
  }

  create() async {
    if (await LoginLogic().getUserInfo()) {
      await ChatListViewModel().getChatListData();
      subscriptionSystemMsg = await QB.chat.subscribeChatEvent(qbEventSystemMessage, (data) {
        ChatListViewModel().getChatListData();
      });
      launchHomeScreen(context);
    } else {
      exitScreen(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: h_200, width: h_200, child: CircularProgressIndicator()),
          Text(
            'Syncing...\nPlease Wait',
            style: tscwnsn_18b,
            textAlign: TextAlign.center,
          )
        ]),
      ),
    );
  }
}
