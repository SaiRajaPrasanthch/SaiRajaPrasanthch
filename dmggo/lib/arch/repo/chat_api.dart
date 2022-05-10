import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:quickblox_sdk/auth/module.dart';
import 'package:quickblox_sdk/models/qb_session.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class ChatApi {
  String login = "MalayadriSeanergy";
  String password = "Malayadri@123";
  bool autoReconnect = true;
  int messageTimeout = 3;

  void initialzeChat() async {
    try {
      await QB.settings.init(appId, authKey, authSecret, accountKey);
      // enableAutoReconnect();
      // enableCarbons();
      initStreamManagement();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void enableAutoReconnect() async {
    try {
      await QB.settings.enableAutoReconnect(true);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
  }

  void enableCarbons() async {
    try {
      await QB.settings.enableCarbons();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
  }

  void initStreamManagement() async {
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
      QBLoginResult result = await QB.auth.login(login, password);
      qbUser = result.qbUser;
      qbSession = result.qbSession;
      await connect();
      ChatListViewModel().chatReadSubcriptions();
      if (kDebugMode) {
        print(qbUser);
        print(qbSession);
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
  }

  void session() async {
    try {
      QBSession? session = await QB.auth.getSession();
      setSessionQB(session);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
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
      if (await checkConnection()) {
        await QB.chat.connect(qbUser!.id!, password);
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

  void disConnect() async {
    try {
      await QB.chat.disconnect();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Some error occurred, look at the exception message for more details
    }
  }
}
