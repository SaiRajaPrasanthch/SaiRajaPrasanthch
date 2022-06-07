import 'package:dmggo/arch/models/driveronboardingsteps_model.dart';
import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/models/validation_model.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_error_string.dart';
import 'package:dmggo/arch/view/driver_home_screen.dart';
import 'package:dmggo/arch/view/driver_onboard_screen.dart';
import 'package:dmggo/arch/view/manager_home_screen.dart';
import 'package:quickblox_sdk/auth/module.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Validations extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ValidationItem _phoneNumber = ValidationItem(null, null);

  ValidationItem get phoneNumber => _phoneNumber;

  bool isPhone(String input) => RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$').hasMatch(input);

  bool isEmail(String input) => RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$').hasMatch(input);

  bool get isValid {
    if (_phoneNumber.value != null) {
      return true;
    } else {
      return false;
    }
  }

  set loading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<bool> changePhoneNumber(String value) async {
    if (value.isEmpty) {
      _phoneNumber = ValidationItem(null, strEmailOrPass);
      return false;
    } else if (isPhone(value)) {
      if (value.length >= i_10) {
        _phoneNumber = ValidationItem(value, null);
        return false; //make it true

      } else {
        _phoneNumber = ValidationItem(null, strErrValidPhNo);
        return false;
      }
    } else if (!isEmail(value)) {
      _phoneNumber = ValidationItem(null, strErrValidEmail);
      return false;
    } else if (value.toLowerCase() != dummyStrDrFirstimEmail.toLowerCase() &&
        value.toLowerCase() != dummyStrDriverEmail.toLowerCase() &&
        value.toLowerCase() != dummyStrOwnerEmail.toLowerCase() &&
        value.toLowerCase() != dummyStrManagerEmail.toLowerCase()) {
      _phoneNumber = ValidationItem(null, strEmailOrPassDontExist);
      return false;
    } else {
      if (value.toLowerCase() == dummyStrDrFirstimEmail.toLowerCase()) {
        strEmail = dummyStrDrFirstimEmail;
        currentTab.insert(i_0, DriverOnboardingScreen());
      }
      if (value.toLowerCase() == dummyStrDriverEmail.toLowerCase()) {
        strEmail = dummyStrDriverEmail;
        currentTab.insert(i_0, DriverHomeScreen());
      }
      if (value.toLowerCase() == dummyStrOwnerEmail.toLowerCase() || value.toLowerCase() == dummyStrManagerEmail.toLowerCase()) {
        strEmail = value.toLowerCase();
        currentTab.insert(i_0, ManagerHomeScreen());
        if (value.toLowerCase() == dummyStrOwnerEmail.toLowerCase()) {
          if (!listMHS.contains(DrOBS(bStatus: false, strTitle: strReconcilation))) {
            listMHS.add(
              DrOBS(bStatus: false, strTitle: strReconcilation),
            );
          }
        }
      }
      _phoneNumber = ValidationItem(value, null);
    }
    await dummylogin(email: value, password: '12345678');
    return true;
  }

  homeScreenAdding() async {
    SharedPreferences _pre = await prefs;
    strEmail = _pre.getString(strQBEmail);
    if (strEmail!.toLowerCase() == dummyStrDrFirstimEmail.toLowerCase()) {
      currentTab.insert(i_0, DriverOnboardingScreen());
    }
    if (strEmail!.toLowerCase() == dummyStrDriverEmail.toLowerCase()) {
      currentTab.insert(i_0, DriverHomeScreen());
    }
    if (strEmail!.toLowerCase() == dummyStrOwnerEmail.toLowerCase() || strEmail!.toLowerCase() == dummyStrManagerEmail.toLowerCase()) {
      currentTab.insert(i_0, ManagerHomeScreen());
      if (strEmail!.toLowerCase() == dummyStrOwnerEmail.toLowerCase()) {
        if (!listMHS.contains(DrOBS(bStatus: false, strTitle: strReconcilation))) {
          listMHS.add(
            DrOBS(bStatus: false, strTitle: strReconcilation),
          );
        }
      }
    }
  }

// dummy login for testing
  dummylogin({
    required String email,
    required String password,
  }) async {
    await ChatApi().initialzeChat();
    await ChatApi().enableAutoReconnect();
    await ChatApi().enableCarbons();
    await ChatApi().initStreamManagement();
    QBLoginResult result = await QB.auth.login(email, password);
    qbUser = result.qbUser;
    await dummySaveInStorage(user: qbUser, intId: qbUser!.id, strPassword: password);
    await ChatApi().connect();
    await ChatListViewModel().getChatListData();
    subscriptionSystemMsg = await QB.chat.subscribeChatEvent(qbEventSystemMessage, (data) {
      ChatListViewModel().getChatListData();
    });
    subscriptionReceiveMsg = await QB.chat.subscribeChatEvent(qbEventReceiveNewMessage, (data) {
      ChatListViewModel().getChatListData();
    });
  }

//Dummy storage of credentials..

  dummySaveInStorage({QBUser? user, int? intId, String? strPassword}) async {
    SharedPreferences _pre = await prefs;
    _pre.setString(strQBLogin, user!.login!);
    _pre.setString(strQBPass, strPassword!);
    _pre.setString(strQBEmail, user.email!);
    _pre.setString(strQBFullName, user.fullName!);
    _pre.setInt(intUserId, intId!);
    _pre.setInt(intQBId, user.id!);
  }

  Future<bool> submit({required String strEmail, required BuildContext context}) async {
    loading = true;
    if (await changePhoneNumber(strEmail)) {
      loading = false;
      return true;
    }
    loading = false;
    return false;
  }

  Future<bool> islogin() async {
    accessToken = await oauth.getAccessToken();
    SharedPreferences per = await prefs;
    strLoginExist = per.getString(strQBLogin);
    //  accessToken != null &&
    if (strLoginExist != null) {
      return true;
    } else {
      return false;
    }
  }
}
