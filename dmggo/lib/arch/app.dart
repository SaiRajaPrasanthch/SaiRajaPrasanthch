import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/view/login_screen.dart';

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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        ChatApi().connect();
        break;
      case AppLifecycleState.paused:
        ChatApi().disConnect();
        break;
      case AppLifecycleState.inactive:
        ChatApi().disConnect();
        break;
      case AppLifecycleState.detached:
        ChatApi().disConnect();
        break;
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
        return MediaQuery(
          child: child!,
          data: mediaQueryData.copyWith(textScaleFactor: scale),
        );
      },
      home: LoginScreen(),
    );
  }
}
