import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view/driver_home_screen.dart';
import 'package:dmggo/arch/view/manager_home_screen.dart';
import 'package:dmggo/arch/view_model/bottombar_log.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileLogic extends ChangeNotifier {
  bool isNotifiable = false;
  String _userName = '- NA -';
  String _userEmail = '- NA -';
  String _userDOB = '- NA -';
  String _userRole = '- NA -';
  String _userDMGgoId = '- NA -';
  String _userMobile = '- NA -';
  String _userDrivingLicense = '- NA -';

  get userEmail => _userEmail;
  get userName => _userName;
  get userDOB => _userDOB;
  get userRole => _userRole;
  get userDMGgoId => _userDMGgoId;
  get userMobile => _userMobile;
  get userDrivingLicense => _userDrivingLicense;

  set setUserName(String value) {
    _userName = value;
  }

  set setUserDOB(String value) {
    _userDOB = value;
  }

  set setUserEmail(String value) {
    _userEmail = value;
  }

  set setUserDMGgoId(String value) {
    _userDMGgoId = value;
  }

  set setUserDL(String value) {
    _userDrivingLicense = value;
  }

  set setUserMobile(String value) {
    _userMobile = value;
  }

  set setUserRole(String value) {
    _userRole = value;
  }

  setvalues() async {
    SharedPreferences pre = await prefs;
    setUserName = pre.getString(strQBFullName)!;
    setUserDOB = pre.getString(strDOB)!;
    setUserEmail = pre.getString(strQBEmail)!;
    // setUserDMGgoId = pre.getString("")!;
    setUserDL = pre.getString(strDrivingLicense)!;
    setUserMobile = pre.getString(strMobile)!;
    setUserRole = pre.getString(strRole)!;
    notifyListeners();
  }

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

  logout({required BuildContext con}) async {
    await oauth.logout();
    await ChatApi().disConnect();

    qbUser = null;
    currentTab.removeAt(0);
    userList = [];
    if (_userRole == 'Super Admin' || _userRole == 'Owner' || _userRole == 'Admin') {
      listMHS.removeLast();
    }
    Provider.of<BottomNavigationBarProvider>(con, listen: false).current = i_0;
    prefs.then((value) => value.clear());
    launchLoginScreen(con);
    notifyListeners();
  }
}
