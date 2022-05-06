import 'package:dmggo/arch/view_model/bottombar_log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dmggo/arch/commonUI/com_tabbar.dart';
import 'package:dmggo/arch/utils/constants.dart';

// ignore: must_be_immutable
class LaunchScreen extends StatelessWidget {
  LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarProvider provider = Provider.of<BottomNavigationBarProvider>(context); 
    return Scaffold(
      body: currentTab[provider.currentBar],
      bottomNavigationBar: CommonTabbar(),
    );
  }
}
