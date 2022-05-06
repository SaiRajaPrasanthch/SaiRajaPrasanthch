import 'package:dmggo/arch/app.dart';
import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:dmggo/arch/view_model/chatmsglist_log.dart';
import 'package:dmggo/arch/view_model/profile_log.dart';
import 'package:dmggo/arch/view_model/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'arch/view_model/bottombar_log.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.black, // Color for Android
    statusBarBrightness:
        Brightness.light, // Dark == white status bar -- for IOS.
  ));
  ChatApi().initialzeChat();
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
      ChangeNotifierProvider(
        create: (_) => ChatMsgListProvider(),
      )
    ],
    child: MyApp(),
  ));
}
