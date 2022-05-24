import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view/chat_list_screen.dart';
import 'package:dmggo/arch/view/launch_loading_screen.dart';
import 'package:dmggo/arch/view/launch_screen.dart';
import 'package:dmggo/arch/view/login_screen.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:dmggo/arch/view_model/login_log.dart';
import 'package:dmggo/main.dart';
import 'package:flutter/material.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (accessToken != null && strLoginExist != null) {
      switch (state) {
        case AppLifecycleState.resumed:
          await ChatApi().initialzeChat();
          await LoginLogic().callQBServices();
          await ChatListViewModel().getChatListData();
          subscriptionSystemMsg = await QB.chat.subscribeChatEvent(qbEventSystemMessage, (data) {
            ChatListViewModel().getChatListData();
          });
          break;
        case AppLifecycleState.paused:
          // subscriptionReceiveMsg?.cancel();
          await ChatApi().disConnect();
          break;
        case AppLifecycleState.inactive:
          //   subscriptionReceiveMsg?.cancel();
          //   await ChatApi().disConnect();
          break;
        case AppLifecycleState.detached:
          //   subscriptionReceiveMsg?.cancel();
          //   await ChatApi().disConnect();
          break;
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
      ),
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.0);
        screenWidth ??= mediaQueryData.size.width;
        screenHeight ??= mediaQueryData.size.height;

        return MediaQuery(
          child: child!,
          data: mediaQueryData.copyWith(textScaleFactor: scale),
        );
      },
      home: accessToken == null && strLoginExist == null ? LoginScreen() : LaunchScreen(), //LaunchScreen
      // home: accessToken == null ? LaunchLoadingScreen() : LaunchLoadingScreen(), //LaunchScreen
    );
  }
}
