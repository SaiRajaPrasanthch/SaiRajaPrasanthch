import 'package:flutter/material.dart';
import 'package:dmggo/arch/view/login_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
