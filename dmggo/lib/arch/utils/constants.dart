import 'dart:io';
import 'dart:math';

import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:dmggo/arch/models/driveronboardingsteps_model.dart';
import 'package:dmggo/arch/models/pretrip_inspection_model.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view/chat_list_screen.dart';
import 'package:dmggo/arch/view/manager_home_screen.dart';
import 'package:dmggo/arch/view/profile_screen.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/models/qb_session.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

double hinf = double.infinity;
double h_300 = 300.0;
double h_200 = 200.0;

double h_120 = 120.0;
double h_100 = 100.0;
double h_60 = 60.0;
double h_50 = 50.0;
double h_45 = 45.0;
double h_40 = 40.0;
double h_35 = 35.0;
double h_30 = 30.0;
double h_25 = 25.0;
double h_20 = 20.0;
double h_18 = 18.0;
double h_16 = 16.0;
double h_15 = 15.0;
double h_14 = 14.0;
double h_12 = 12.0;
double h_10 = 10.0;
double h_8 = 8.0;
double h_5 = 5.0;
double h_4 = 4.0;
double h_3 = 3.0;
double h_2 = 2.0;
double hp_12 = 1.2;
double h_1 = 1.0;
double h_05 = 0.5;
double h_01 = 0.1;
double h_0 = 0.0;

int i_200 = 200;
int i_10 = 10;
int i_8 = 8;
int i_6 = 6;
int i_4 = 4;
int i_3 = 3;
int i_2 = 2;
int i_1 = 1;
int i_0 = 0;

double? screenWidth;
double? screenHeight;

String? strEmail;

//Chat
QBUser? qbUser;
QBSession? qbSession;
String qbEventConnected = QBChatEvents.CONNECTED;
String qbEventReceiveNewMessage = QBChatEvents.RECEIVED_NEW_MESSAGE;
String qbEventSystemMessage = QBChatEvents.RECEIVED_SYSTEM_MESSAGE;
//test
// String appId = "96229";
// String authKey = "GcVHtt-UkZZ84bS";
// String authSecret = "sq8wzzpvET-zzq3";
// String accountKey = "pasWx-r41pLAkL8gZF4D";

//Prod
String appId = "96677";
String authKey = "9vCLsEnjJvYxCrk";
String authSecret = "nMhVNHF67JGwUWw";
String accountKey = "xGHxRqffg1o5BtRLnJEK";

final Config config = Config(
  tenant: '647119b9-2120-453d-ab27-e02884c15a1b',
  clientId: 'fe3d0d8a-0f41-4783-8766-44cee5ef23d6',
  scope: 'openid profile offline_access',
  redirectUri: Platform.isIOS ? 'msauth.com.seanergydigital.dmggo://auth' : 'msauth://com.seanergydigital.dmggo/VzSiQcXRmi2kyjzcA%2BmYLEtbGVs%3D',
);

const gStrChars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random rnd = Random();

final dataView = ChatListScreen(key: viewKey);
final AadOAuth oauth = AadOAuth(config);
String? accessToken;
final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

// Headers

Map<String, String>? strHeaders = {
  'Accept': 'application/json',
  'Content-type': 'application/json',
};

// error codes

const successResponse = 200;
const invalidResponse = 100;
const noInternet = 101;
const timeOut = 408;
const socketError = 504;
const invalidFormate = 102;
const unknownError = 500;
const platformException = 400;

//list Driver on boarding Steps
List<DrOBS> listDrOBS = [
  DrOBS(intCount: 0, bStatus: true, strTitle: strDrOBAUEs),
  DrOBS(bStatus: false, strTitle: strDrOBSYOL),
  DrOBS(intCount: 2, bStatus: false, strTitle: strDrOBUYDL),
  DrOBS(intCount: 1, bStatus: false, strTitle: strDrOBSBCC),
  DrOBS(bStatus: false, strTitle: strDrOBSDATC),
  DrOBS(bStatus: false, strTitle: strDrOBUISD),
  DrOBS(intCount: 1, bStatus: false, strTitle: strDrOBSSIA),
  DrOBS(bStatus: false, strTitle: strDrOBSBA),
  DrOBS(bStatus: false, strTitle: strDrOBSNDA),
  DrOBS(intCount: 5, bStatus: false, strTitle: strDrOBSVTA),
];

//list manager home screen
List<DrOBS> listMHS = [
  DrOBS(bStatus: true, strTitle: strDashboard),
  DrOBS(bStatus: false, strTitle: strFU),
  DrOBS(intCount: 2, bStatus: false, strTitle: strHSI),
  DrOBS(intCount: 1, bStatus: false, strTitle: strMT),
  DrOBS(bStatus: false, strTitle: strRS),
  DrOBS(bStatus: false, strTitle: strACD),
  DrOBS(intCount: 1, bStatus: false, strTitle: strETD),
  DrOBS(bStatus: false, strTitle: strPCR),
];

//list Driver home screen

List<DrOBS> listDHS = [
  DrOBS(bStatus: false, strTitle: strFU),
  DrOBS(bStatus: true, strTitle: strMSI),
  DrOBS(intCount: 2, bStatus: false, strTitle: strMT),
  DrOBS(intCount: 1, bStatus: false, strTitle: strMRS),
  DrOBS(bStatus: false, strTitle: strMLM),
  DrOBS(bStatus: false, strTitle: strMLD),
  DrOBS(intCount: 1, bStatus: false, strTitle: strMPS),
  DrOBS(bStatus: false, strTitle: strMLH),
  DrOBS(bStatus: false, strTitle: strMCP),
  DrOBS(bStatus: false, strTitle: strDVI),
  DrOBS(bStatus: false, strTitle: strQR),
];

List<DrOBS> listDVI = [
  DrOBS(bStatus: false, strTitle: strPreTI),
  DrOBS(bStatus: false, strTitle: strPostTI),
];

var currentTab = [
  ManagerHomeScreen(),
  ProfileScreen(),
  ChatListScreen(),
];

List<PTI> listPTIS = [
  PTI(isCheck: false, strTitle: strDashLights, strSubTitle: strNFLDB, strStatus: "Defective", strImage: 'assets/images/dash_lights.jpg', check: Check(strFail: 'Defective', strPass: 'Working')),
  PTI(isCheck: true, strTitle: strHeadLights, strSubTitle: strLHB, strStatus: "Working", check: Check(strFail: 'Defective', strPass: 'Working')),
  PTI(strTitle: strTires, strSubTitle: strVSI, strStatus: "", check: Check(strFail: 'Defective', strPass: 'Working')),
  PTI(strTitle: strPackages, strSubTitle: strNPLV, strStatus: "", check: Check(strFail: 'Found Packages', strPass: 'Empty')),
];
List<PTI> listNewDamage = [
  PTI(isCheck: false, strTitle: strFrontCond, strStatus: "Damage Found", strSubTitle: strUDED, strImage: 'assets/images/truck_front.jpg', check: Check(strFail: 'Damage Found', strPass: 'Fine')),
  PTI(isCheck: true, strTitle: strRearCond, strSubTitle: strUDED, strStatus: "Fine", strImage: 'assets/images/truck_rear.jpeg', check: Check(strFail: 'Damage Found', strPass: 'Fine')),
  PTI(
      isCheck: false,
      strTitle: strDriverSideCond,
      strSubTitle: strUDED,
      strStatus: "Damage Found",
      strImage: 'assets/images/truck_driver_side.jpeg',
      check: Check(strFail: 'Damage Found', strPass: 'Fine')),
  PTI(
      isCheck: false,
      strTitle: strPassSideCond,
      strSubTitle: strUDED,
      strStatus: "Damage Found",
      strImage: 'assets/images/truck_passenger_side.jpeg',
      check: Check(strFail: 'Damage Found', strPass: 'Fine')),
];
