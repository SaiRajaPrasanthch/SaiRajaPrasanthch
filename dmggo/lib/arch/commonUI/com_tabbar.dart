import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view_model/bottombar_log.dart';

class CommonTabbar extends StatelessWidget {
  CommonTabbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarProvider provider = Provider.of<BottomNavigationBarProvider>(context, listen: true);

    return BottomNavigationBar(
      backgroundColor: cgrey_200,
      unselectedItemColor: cgrey_900,
      selectedLabelStyle: tscwnsn_14b,
      unselectedLabelStyle: tscwnsn_12b,
      currentIndex: provider.currentBar,
      onTap: (index) {
        provider.current = index;
      },
      iconSize: h_25,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: strCHome,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: strCProfile,
        ),
        BottomNavigationBarItem(
          icon: Badge(child: Icon(Icons.message_rounded), elevation: h_0, position: BadgePosition(top: -h_1, end: -h_3)),
          label: strCom,
        ),
      ],
    );
  }
}
