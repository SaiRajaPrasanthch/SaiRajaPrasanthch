import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view/driver_home_screen.dart';
import 'package:dmggo/arch/view/manager_home_screen.dart';
import 'package:flutter/material.dart';

class ProfileLogic extends ChangeNotifier {
  bool isNotifiable = false;
  String strSwitch = strEmail == dummyStrOwnerEmail ? strOwner : strManager;
  void toggleNotification({
    bool isNotifiable = true,
  }) {
    this.isNotifiable = isNotifiable;

    if (strEmail == dummyStrOwnerEmail || strEmail == dummyStrManagerEmail) {
      currentTab.removeAt(0);
      if (isNotifiable) {
        // if (strEmail == dummyStrOwnerEmail) {
        //   strSwitch = strOwner;
        // } else {
        //   strSwitch = strManager;
        // }

        currentTab.insert(0, DriverHomeScreen());
      } else {
        currentTab.insert(0, ManagerHomeScreen());
      }
    }

    notifyListeners();
  }
}
