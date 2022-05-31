import 'package:dmggo/arch/models/get_userinfo.dart';
import 'package:dmggo/arch/repo/api_status.dart';
import 'package:dmggo/arch/repo/auth_methods.dart';
import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/repo/user_services.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/utils/urls.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLogic {
//Validate whether User exist
  Future<bool> getUserInfo() async {
    try {
           print('6');
      Map<String, dynamic> userData = AuthMethods().parseJwt(accessToken!);
      // creates a valid microsoft user in our db for now and returns if user is created in Quick Blox
               print('7');
      var response = await UserInfo().getUserInfo(strLUrl: '${strGetUserInfoURL}email=${userData['unique_name']}&firstName=${userData['given_name']}&lastName=${userData['family_name']}');
              print('8');
      if (response is Success) {
                 print('9');
        GetUserInfo userinfo = response.response as GetUserInfo;
        // iinitalize chat here
          print('10');
        await ChatApi().initialzeChat();
            print('11');
        if (userinfo.qbId == null) {
           print('12');
          String strLPassword = AuthMethods().getRandomString(16);
print('13');
          // Create User in Quick block
          var resQB = await ChatApi().createUserInQB(strLEmail: userData['unique_name'], strLPass: strLPassword, strLName: userData['name']);
         print('14');
          if (resQB is Success) {
            // Create an user in Db with QB details
            print('15');
            var resCreateUser = await UserInfo().createUserInfo(strLUrl: strCreateQuickBloxId, qbUsers: resQB.response as QBUser, strPassword: strLPassword, intUserId: userinfo.userId);
            if (resCreateUser is Success) {
              await saveInStorage(user: resQB.response as QBUser, strPassword: strLPassword, intId: userinfo.userId);
              // await callQBServices();
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
            print('20');
          QBUser user = QBUser();
          user.id = int.parse(userinfo.qbId!);
          user.email = userinfo.email;
          user.fullName = userinfo.firstName + " " + userinfo.lastName;
          user.login = userinfo.email;
          await saveInStorage(user: user, strPassword: userinfo.qbPassword, intId: userinfo.userId);
          // await callQBServices();
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

  saveInStorage({QBUser? user, int? intId, String? strPassword}) async {
    SharedPreferences _pre = await prefs;
    _pre.setString(strQBLogin, user!.login!);
    _pre.setString(strQBPass, strPassword!);
    _pre.setString(strQBEmail, user.email!);
    _pre.setString(strQBFullName, user.fullName!);
    _pre.setInt(intUserId, intId!);
    _pre.setInt(intQBId, user.id!);
  }

  callQBServices() async {
    await ChatApi().enableAutoReconnect();
    // await ChatApi().enableCarbons();
    await ChatApi().initStreamManagement();
    await ChatApi().loginQB();
  }
  // Future<bool> vOrCQBA() async {
  //   Map<String, dynamic> userData = AuthMethods().parseJwt(accessToken!);

  //   int resCode = 404;
  //   if (resCode == 404 || resCode == 401) {
  //     String strLPassword = AuthMethods().getRandomString(16);
  //     return await ChatApi().createUserInQB(strLEmail: userData['unique_name'], strLPass: strLPassword, strLName: userData['name']);
  //   } else if (resCode == 200) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
