import 'package:dmggo/arch/repo/api_status.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:quickblox_sdk/auth/module.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/models/qb_session.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatApi {
  // String login = "MalayadriSeanergy";
  // String password = "Malayadri@123";
  bool autoReconnect = true;
  int messageTimeout = 3;

  Future<void> initialzeChat() async {
    try {
      if (kDebugMode) {
        print('11');
      }
      await QB.settings.init(appId, authKey, authSecret, accountKey, apiEndpoint: apiEndPoint, chatEndpoint: chatEndPoint);
      if (kDebugMode) {
        print('12');
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> enableAutoReconnect() async {
    try {
      await QB.settings.enableAutoReconnect(true);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
  }

  Future<void> enableCarbons() async {
    try {
      await QB.settings.enableCarbons();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
  }

  Future<void> initStreamManagement() async {
    try {
      await QB.settings.initStreamManagement(messageTimeout, autoReconnect: autoReconnect);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
  }

  Future<void> loginQB() async {
    try {
      SharedPreferences _preference = await prefs;
      // QBLoginResult result = await QB.auth.login(login, password);
      QBLoginResult result = await QB.auth.login(_preference.getString(strQBLogin)!, _preference.getString(strQBPass)!);
      qbUser = result.qbUser;
      qbSession = result.qbSession;

      await connect();
      if (kDebugMode) {
        print(qbUser);
        print(qbSession!.token);
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
  }

  // Future<int> appSession() async {
  //   Uri url = Uri.parse('https://api.quickblox.com/session.json');
  //   http.Response res = await http.post(url, headers: {
  //     'Accept': 'application/json',
  //   }, body: {
  //     "application_id": "96229",
  //     "auth_key": "GcVHtt-UkZZ84bSF",
  //     "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
  //     "nonce": AuthMethods().getRandomString(4),
  //     "signature": "2279d7fd797c838b940c1081075b241907bcae34"
  //   });
  //   print(res);
  //   return 1;
  // }

  Future<int> session({required String strLEmail}) async {
    try {
      QBSession? session = await QB.auth.getSession();
      // setSessionQB(session);
      return await checkUserExist(strLEmail: strLEmail, strLToken: session!.token!);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 403;
      // Some error occurred, look at the exception message for more details
    }
  }

  void setSessionQB(QBSession? session) async {
    try {
      QBSession? sessionResult = await QB.auth.setSession(session!);
      if (kDebugMode) {
        print(sessionResult);
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
  }

  Future<void> connect() async {
    try {
      bool connected = await checkConnection();
      if (!connected) {
        SharedPreferences _preferences = await prefs;
        // await QB.chat.connect(qbUser!.id!, password);
        await QB.chat.connect(qbUser!.id!, _preferences.getString(strQBPass)!);
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
  }

  Future<bool> checkConnection() async {
    bool connected = false;
    try {
      connected = (await QB.chat.isConnected())!;
      return connected;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
    return connected;
  }

  Future<void> disConnect() async {
    try {
      await QB.chat.disconnect();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
  }

  Future<Object> createUserInQB({required String strLEmail, required String strLPass, required String strLName, String? strPhoneNumber}) async {
    try {
      QBUser? user = await QB.users.createUser(
          strLEmail, //login
          strLPass, //random generated 16 character password
          email: strLEmail,
          fullName: strLName,
          phone: strPhoneNumber);
      if (user != null) {
        return Success(code: successResponse, response: user);
      }
      return Faliure(code: invalidResponse, errorResponse: 'Invalid Response');
    } on PlatformException catch (e) {
      return Faliure(code: platformException, errorResponse: e);
    }
  }

  Future<int> checkUserExist({required String strLEmail, required String strLToken}) async {
    Uri url = Uri.parse('https://api.quickblox.com/users/by_login.json?login=' + strLEmail);
    http.Response res = await http.get(url, headers: {'Accept': 'application/json', 'QB-Token': strLToken});
    return res.statusCode;
  }

  Future<QBDialog> createDialog({required List<int> listusers, required String strDialogName, required int intDialogType}) async {
    QBDialog? createdDialog = await QB.chat.createDialog(listusers, dialogName: strDialogName, dialogType: intDialogType);
    if (createdDialog != null) {
      sendSystemMessage(listIds: createdDialog.occupantsIds!);
    }
    return createdDialog!;
  }

  sendSystemMessage({required List<int> listIds}) async {
    for (var element in listIds) {
      QB.chat.sendSystemMessage(element);
    }
  }

  markDelivered(QBMessage m) async {
    await QB.chat.markMessageDelivered(m);
  }

  markRead(QBMessage m) async {
    await QB.chat.markMessageRead(m);
  }
}
