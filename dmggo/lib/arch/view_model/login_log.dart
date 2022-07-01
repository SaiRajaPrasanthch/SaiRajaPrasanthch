import 'package:dmggo/arch/models/get_userinfo.dart';
import 'package:dmggo/arch/repo/api_status.dart';
import 'package:dmggo/arch/repo/auth_methods.dart';
import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/repo/user_services.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/utils/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLogic {
//Validate whether User exist
  Future<bool> getUserInfo() async {
    try {
      if (kDebugMode) {
        print('6');
      }
      Map<String, dynamic> userData = AuthMethods().parseJwt(accessToken!);
      // creates a valid microsoft user in our db for now and returns if user is created in Quick Blox
      if (kDebugMode) {
        print('7');
      }
      var response = await UserInfo().getUserInfo(strLUrl: '${strGetUserInfoURL}email=${userData['unique_name']}&firstName=${userData['given_name']}&lastName=${userData['family_name']}');
      if (kDebugMode) {
        print('8');
      }
      if (response is Success) {
        if (kDebugMode) {
          print('9');
        }
        GetUserInfo userinfo = response.response as GetUserInfo;
        // iinitalize chat here
        if (kDebugMode) {
          print('10');
        }
        await ChatApi().initialzeChat();
        if (kDebugMode) {
          print('11');
        }
        if (userinfo.qbId == null) {
          if (kDebugMode) {
            print('12');
          }
          String strLPassword = AuthMethods().getRandomString(16);
          if (kDebugMode) {
            print('13');
          }
          // Create User in Quick block
          var resQB = await ChatApi().createUserInQB(strLEmail: userData['unique_name'], strLPass: strLPassword, strLName: userData['name']);
          if (kDebugMode) {
            print('14');
          }
          if (resQB is Success) {
            // Create an user in Db with QB details
            if (kDebugMode) {
              print('15');
            }
            var resCreateUser = await UserInfo().createUserInfo(strLUrl: URL_POST_CREATEQUICKBLOXID, qbUsers: resQB.response as QBUser, strPassword: strLPassword, intUserId: userinfo.userId);
            if (resCreateUser is Success) {
              // await saveInStorage(user: resQB.response as QBUser, strqbPassword: strLPassword, intId: userinfo.userId);
              await callQBServices();
              return true;
            } else {
              await oauth.logout();
              prefs.then((value) => value.clear());
              return false;
            }
          } else {
            await oauth.logout();
            prefs.then((value) => value.clear());
            return false;
          }
        } else {
          if (kDebugMode) {
            print('20');
          }
          QBUser user = QBUser();
          user.id = int.parse(userinfo.qbId!);
          user.email = userinfo.email;
          user.fullName = userinfo.firstName + " " + userinfo.lastName;
          user.login = userinfo.email;
          // await saveInStorage(user: user, strqbPassword: userinfo.qbPassword, intId: userinfo.userId);
          await callQBServices();
          return true;
        }
      }
      await oauth.logout();
      prefs.then((value) => value.clear());

      return false;
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  saveInStorage({
    QBUser? user,
    int? intId,
    String? strqbPassword,
    String? drivingLic,
    String? mobileNo,
    String? dOBirth,
    String? role,required int roleId,
  }) async {
    SharedPreferences _pre = await prefs;
    _pre.setString(strQBLogin, user!.login!);
    _pre.setString(strQBPass, strqbPassword!);
    _pre.setString(strQBEmail, user.email!);
    _pre.setString(strQBFullName, user.fullName!);
    _pre.setInt(intUserId, intId!);
    _pre.setInt(intQBId, user.id!);
    _pre.setInt(intRoleId, roleId);
    _pre.setString(strDrivingLicense, drivingLic??'- NA -');
    _pre.setString(strMobile, mobileNo??'- NA -');
    _pre.setString(strDOB, dOBirth??'- NA -');
    _pre.setString(strRole,role??'- NA -');
  }

  callQBServices() async {
    await ChatApi().enableAutoReconnect();
    await ChatApi().enableCarbons();
    await ChatApi().initStreamManagement();
    await ChatApi().loginQB();
  }
}
