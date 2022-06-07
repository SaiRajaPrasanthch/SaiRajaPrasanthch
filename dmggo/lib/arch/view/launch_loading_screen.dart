import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view/manager_home_screen.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:dmggo/arch/view_model/login_log.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
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
    showMicrosoftLogin();
  }

  showMicrosoftLogin() async {
    try {
      print('1');
      await oauth.login(refreshIfAvailable: true);
      print('2');

      accessToken = await oauth.getAccessToken();
      print('3');

      if (accessToken != null) {
        print('4');
        create();
        // print('5');
      } else {
        exitScreen(context);
      }
    } catch (e) {
      exitScreen(context);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  create() async {
    try {
      print('5');
      if (await LoginLogic().getUserInfo()) {
        currentTab.insert(0, ManagerHomeScreen());
        await ChatListViewModel().getChatListData();
        subscriptionSystemMsg = await QB.chat.subscribeChatEvent(qbEventSystemMessage, (data) {
          ChatListViewModel().getChatListData();
        });
        subscriptionReceiveMsg = await QB.chat.subscribeChatEvent(qbEventReceiveNewMessage, (data) {
          ChatListViewModel().getChatListData();
        });
        launchHomeScreen(context);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong..", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
        exitScreen(context);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
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
