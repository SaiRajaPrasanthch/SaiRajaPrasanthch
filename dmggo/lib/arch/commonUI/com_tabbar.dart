import 'package:badges/badges.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:dmggo/arch/view_model/profile_log.dart';
import 'package:flutter/foundation.dart';
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
    BottomNavigationBarProvider pro = Provider.of<BottomNavigationBarProvider>(context, listen: true);
    Provider.of<ProfileLogic>(context, listen: false).setvalues();
    if (kDebugMode) {
      print(pro.unReadCount);
    }
    int c = 0;
    c = Provider.of<ChatListViewModel>(context, listen: false).dialogs.fold(0, (sum, element) {
      if (element!.unreadMessagesCount != null) {
        sum + element.unreadMessagesCount!;
      } else {
        sum + 0;
      }
      return sum;
    });
    if (kDebugMode) {
      print(c);
    }
    return BottomNavigationBar(
      backgroundColor: cgrey_200,
      unselectedItemColor: cgrey_900,
      selectedLabelStyle: tscwnsn_14b,
      unselectedLabelStyle: tscwnsn_12b,
      currentIndex: pro.currentBar,
      onTap: (index) {
        pro.current = index;
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
          icon: c > 0
              ? Badge(
                  toAnimate: false,
                  badgeColor: cblue_700,
                  alignment: Alignment.center,
                  badgeContent: Text(
                    c.toString(),
                    style: tscwnsn_12wh,
                    textAlign: TextAlign.center,
                  ),
                  child: Icon(Icons.message_rounded),
                  elevation: h_0,
                  // position: BadgePosition(top: -h_1, end: -h_3)
                )
              : Icon(Icons.message_rounded),
          label: strCom,
        ),
      ],
    );
  }
}
