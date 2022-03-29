import 'package:dmggo/arch/app.dart';
import 'package:dmggo/arch/view_model/profile_log.dart';
import 'package:dmggo/arch/view_model/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'arch/view_model/bottombar_log.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.black, // Color for Android
    statusBarBrightness:
        Brightness.light, // Dark == white status bar -- for IOS.
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
      )
    ],
    child: MyApp(),
  ));
}
