import 'package:dmggo/arch/app.dart';
import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view/splash.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:dmggo/arch/view_model/login_log.dart';
import 'package:dmggo/arch/view_model/profile_log.dart';
import 'package:dmggo/arch/view_model/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'arch/view_model/bottombar_log.dart';

String? strLoginExist;
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await oauth.logout();
  accessToken = await oauth.getAccessToken();
  SharedPreferences per = await prefs;
  strLoginExist = per.getString(strQBLogin);
  if (accessToken != null && strLoginExist != null) {
    // await ChatApi().initialzeChat();
    // await LoginLogic().callQBServices();
    // await ChatListViewModel().getChatListData();
    // subscriptionSystemMsg = await QB.chat.subscribeChatEvent(qbEventSystemMessage, (data) {
    //   ChatListViewModel().getChatListData();
    // });
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.black, // Color for Android
    statusBarBrightness: Brightness.light, // Dark == white status bar -- for IOS.
  ));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => BottomNavigationBarProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => Validations(),
      ),
      ChangeNotifierProvider(
        create: (_) => ProfileLogic(),
      ),
      ChangeNotifierProvider(
        create: (_) => ChatListViewModel(),
      ),
      // ChangeNotifierProvider(
      //   create: (_) => ChatMsgListProvider(),
      // )
    ],
    child: MyApp(),
  ));
}
