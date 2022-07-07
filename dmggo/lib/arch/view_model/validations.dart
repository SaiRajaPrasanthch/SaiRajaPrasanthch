import 'package:dmggo/arch/commonUI/com_alert.dart';
import 'package:dmggo/arch/models/driveronboardingsteps_model.dart';
import 'package:dmggo/arch/models/get_userinfo.dart';
import 'package:dmggo/arch/repo/api_status.dart';
import 'package:dmggo/arch/repo/auth_methods.dart';
import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/repo/user_services.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/utils/urls.dart';
import 'package:dmggo/arch/view_model/carrier_terminal_log.dart';
import 'package:dmggo/arch/view_model/login_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/models/validation_model.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_error_string.dart';
import 'package:dmggo/arch/view/driver_home_screen.dart';
import 'package:dmggo/arch/view/manager_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Validations extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  GetUserInfo? _getUserInfo;
  GetUserInfo? get getUserInfo => _getUserInfo;

  ValidationItem _validPhoneEmail = ValidationItem(null, null);

  ValidationItem get validPhoneEmail => _validPhoneEmail;

  ValidationItem _validPassword = ValidationItem(null, null);

  ValidationItem get validPassword => _validPassword;

  // bool isPhone(String input) => RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$').hasMatch(input);
  bool isPhone(String input) => RegExp(r'^[0-9]{3}[0-9]{3}[0-9]{4,6}$').hasMatch(input);

  bool isEmail(String input) => RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$').hasMatch(input);

  bool get isValid {
    if (_validPhoneEmail.value != null) {
      return true;
    } else {
      return false;
    }
  }

  set loading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  set userInfo(GetUserInfo value) {
    _getUserInfo = value;
  }

  Future<bool> changePhoneNumber(String value) async {
    if (kDebugMode) {
      bool p = isPhone(value);
      bool e = isEmail(value);
      print('valid email $e');
      print('valid phone number $p');
    }
    if (value.isEmpty || value == '') {
      _validPhoneEmail = ValidationItem(null, strEmailOrPass);
      return false;
    } else if (isPhone(value) || int.tryParse(value) != null) {
      if (value.length >= i_10) {
        _validPhoneEmail = ValidationItem(value, null);
        return true; //make it true

      } else {
        _validPhoneEmail = ValidationItem(null, strErrValidPhNo);
        return false;
      }
    } else if (!isEmail(value)) {
      _validPhoneEmail = ValidationItem(null, strErrValidEmail);
      return false;
    }
    //  else if (value.toLowerCase() != dummyStrDrFirstimEmail.toLowerCase() &&
    //     value.toLowerCase() != dummyStrDriverEmail.toLowerCase() &&
    //     value.toLowerCase() != dummyStrOwnerEmail.toLowerCase() &&
    //     value.toLowerCase() != dummyStrManagerEmail.toLowerCase()) {
    //   _validPhoneEmail= ValidationItem(null, strEmailOrPassDontExist);
    //   return false;
    // }
    else {
      // if (value.toLowerCase() == dummyStrDrFirstimEmail.toLowerCase()) {
      //   strEmail = dummyStrDrFirstimEmail;
      //   currentTab.insert(i_0, DriverOnboardingScreen());
      // }
      // if (value.toLowerCase() == dummyStrDriverEmail.toLowerCase()) {
      //   strEmail = dummyStrDriverEmail;
      //   currentTab.insert(i_0, DriverHomeScreen());
      // }
      // if (value.toLowerCase() == dummyStrOwnerEmail.toLowerCase() || value.toLowerCase() == dummyStrManagerEmail.toLowerCase()) {
      //   strEmail = value.toLowerCase();
      //   currentTab.insert(i_0, ManagerHomeScreen());
      //   if (value.toLowerCase() == dummyStrOwnerEmail.toLowerCase()) {
      //     if (!listMHS.contains(DrOBS(bStatus: false, strTitle: strReconcilation))) {
      //       listMHS.add(
      //         DrOBS(bStatus: false, strTitle: strReconcilation),
      //       );
      //     }
      //   }
      // }
      _validPhoneEmail = ValidationItem(value, null);
    }
    // await dummylogin(email: value, password: '12345678');
    return true;
  }

  Future<bool> validatePassword(String value) async {
    if (value.isEmpty || value == '') {
      _validPassword = ValidationItem(null, strPleaseEnterPass);
      return false;
    } else if (value.length < i_6) {
      _validPassword = ValidationItem(null, strPleaseEnter6Character);
      return false;
    }
    _validPassword = ValidationItem(value, null);
    return true;
  }

  // homeScreenAdding() async {
  //   SharedPreferences _pre = await prefs;
  //   strEmail = _pre.getString(strQBEmail);
  //   if (strEmail!.toLowerCase() == dummyStrDrFirstimEmail.toLowerCase()) {
  //     currentTab.insert(i_0, DriverOnboardingScreen());
  //   }
  //   if (strEmail!.toLowerCase() == dummyStrDriverEmail.toLowerCase()) {
  //     currentTab.insert(i_0, DriverHomeScreen());
  //   }
  //   if (strEmail!.toLowerCase() == dummyStrOwnerEmail.toLowerCase() || strEmail!.toLowerCase() == dummyStrManagerEmail.toLowerCase()) {
  //     currentTab.insert(i_0, ManagerHomeScreen());
  //     if (strEmail!.toLowerCase() == dummyStrOwnerEmail.toLowerCase()) {
  //       if (!listMHS.contains(DrOBS(bStatus: false, strTitle: strReconcilation))) {
  //         listMHS.add(
  //           DrOBS(bStatus: false, strTitle: strReconcilation),
  //         );
  //       }
  //     }
  //   }
  // }

  homeScreenAddingV2(BuildContext context) async {
    SharedPreferences _pre = await prefs;
    int? role = _pre.getInt(intRoleId);
    if (role == i_5 || role == i_6) {
      currentTab.insert(i_0, DriverHomeScreen());
    }
    // if (strEmail!.toLowerCase() == dummyStrDriverEmail.toLowerCase()) {
    //   currentTab.insert(i_0, DriverHomeScreen());
    // }
    if (role == i_1 || role == i_2 || role == i_3 || role == i_4) {
      context.read<CarrierTerminalLog>().getOps();
      currentTab.insert(i_0, ManagerHomeScreen());
      if (role == i_1 || role == i_2 || role == i_3) {
        if (!listMHS.contains(DrOBS(bStatus: false, strTitle: strReconcilation))) {
          listMHS.add(
            DrOBS(bStatus: false, strTitle: strReconcilation),
          );
        }
      }
    }
  }

  directLogin({required String emailorPhone, required String password, required BuildContext context}) async {
    loading = true;
    var res = await UserInfo().postValidUser(strLUrl: URL_POST_VALIDATEUSER, emailOrPhone: emailorPhone, password: password);

    if (res is Success) {
      if (res.code == newUserResponse) {
        loading = false;
        openChangePasswordScreen(context);
      } else if (res.code == invalidCredintials) {
        loading = false;
        ComAlert().showSuccessAlert(context, res);
      } else if (res.code == successResponse) {
        // add quick blox login code
        userInfo = res.response as GetUserInfo;

        await checkForQuickBlox(context);
        await homeScreenAddingV2(context);
        launchHomeScreen(context);
        loading = false;
      }
    } else {
      loading = false;
      ComAlert().showFailureAlert(context, res as Faliure);
    }
  }

  checkForQuickBlox(BuildContext context) async {
    await ChatApi().initialzeChat();
    if (_getUserInfo!.qbId == null && _getUserInfo!.qbLogin == null && _getUserInfo!.qbPassword == null) {
      String strLPassword = AuthMethods().getRandomString(16);
      var resQB =
          await ChatApi().createUserInQB(strLEmail: _getUserInfo!.email, strLPass: strLPassword, strLName: _getUserInfo!.firstName + ' ' + _getUserInfo!.lastName, strPhoneNumber: _getUserInfo!.phone);
      if (resQB is Success) {
        var resCreateUser = await UserInfo().createUserInfo(strLUrl: URL_POST_CREATEQUICKBLOXID, qbUsers: resQB.response as QBUser, strPassword: strLPassword, intUserId: _getUserInfo!.userId);
        if (resCreateUser is Success) {
          await save(user: resQB.response as QBUser, passWord: strLPassword, introleId: getUserInfo!.roleId);
        } else {
          ComAlert().showFailureAlert(context, resCreateUser as Faliure);
          loading = false;
        }
      } else {
        ComAlert().showFailureAlert(context, resQB as Faliure);
        loading = false;
      }
    } else {
      QBUser user = QBUser();
      user.id = int.parse(_getUserInfo!.qbId!);
      user.email = _getUserInfo!.email;
      user.fullName = _getUserInfo!.firstName + " " + _getUserInfo!.lastName;
      user.login = _getUserInfo!.email;

      await save(user: user, passWord: _getUserInfo!.qbPassword, introleId: getUserInfo!.roleId);
    }
  }

  save({QBUser? user, String? passWord, required int introleId}) async {
    await LoginLogic().saveInStorage(
        user: user,
        strqbPassword: passWord,
        intId: _getUserInfo!.userId,
        dOBirth: _getUserInfo!.dob,
        mobileNo: _getUserInfo!.phone,
        role: _getUserInfo!.userType,
        drivingLic: _getUserInfo!.drivingLicense,
        roleId: introleId);
    await LoginLogic().callQBServices();
  }

// // dummy login for testing
//   dummylogin({
//     required String email,
//     required String password,
//   }) async {
//     await ChatApi().initialzeChat();
//     await ChatApi().enableAutoReconnect();
//     await ChatApi().enableCarbons();
//     await ChatApi().initStreamManagement();
//     QBLoginResult result = await QB.auth.login(email, password);
//     qbUser = result.qbUser;
//     await dummySaveInStorage(user: qbUser, intId: qbUser!.id, strPassword: password);
//     await ChatApi().connect();
//     await ChatListViewModel().getChatListData();
//     subscriptionSystemMsg = await QB.chat.subscribeChatEvent(qbEventSystemMessage, (data) {
//       ChatListViewModel().getChatListData();
//     });
//     subscriptionReceiveMsg = await QB.chat.subscribeChatEvent(qbEventReceiveNewMessage, (data) {
//       ChatListViewModel().getChatListData();
//     });
//   }

// //Dummy storage of credentials..

//   dummySaveInStorage({QBUser? user, int? intId, String? strPassword}) async {
//     SharedPreferences _pre = await prefs;
//     _pre.setString(strQBLogin, user!.login!);
//     _pre.setString(strQBPass, strPassword!);
//     _pre.setString(strQBEmail, user.email!);
//     _pre.setString(strQBFullName, user.fullName!);
//     _pre.setInt(intUserId, intId!);
//     _pre.setInt(intQBId, user.id!);
//   }

  Future<bool> submit({required String strEmail, required String strPass, required BuildContext context}) async {
    bool isEmailPhone = await changePhoneNumber(strEmail);
    bool isPass = await validatePassword(strPass);
    if (isEmailPhone && isPass) {
      loading = false;
      await directLogin(emailorPhone: strEmail, password: strPass, context: context);
      return true;
    }
    notifyListeners();
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
