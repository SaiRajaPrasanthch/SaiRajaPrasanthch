// dummies

import 'package:dmggo/arch/models/chat_model.dart';
import 'package:dmggo/arch/models/chatlist_model.dart';
import 'package:dmggo/arch/models/pretrip_inspec_popup_model.dart';
import 'package:dmggo/arch/utils/constants.dart';

String dStrCarrier = 'ANGELL DSP PARCEL';

String dStrRoute = 'FORT WORTH';

String strVNo = "ABC123";

String strOdNo = "25468";

//list of Carriers
List<String> listCarrier = ['Angell DSP Parcel', 'Angell ISP Parcel', 'Angell Semi', 'Angell LSO', 'Angell DSP'];

//list of Routes
List<String> listRoute = ['Fort Worth', 'Green Bay', 'Wilmer', 'Austin', 'Long Bench'];

String strCommingSoon = 'Comming Soon...';

List<ChatList> listChatList = [
  ChatList(isGroup: true, intUnreadMsg: 1, isImage: true, strName: "Angell Feed", strText: 'Christian Pulisic: Hello'),
  ChatList(isGroup: true, isImage: false, strName: "Terminal Feed"),
  ChatList(isGroup: true, intUnreadMsg: 1, isImage: true, strName: "Group 1", strText: 'Is there any update'),
  ChatList(isGroup: true, intUnreadMsg: 7, isImage: true, strName: "Group 2"),
  ChatList(isGroup: false, intUnreadMsg: 1, isImage: true, strName: "Christian Pulisic", strText: 'Whatssupp'),
  ChatList(isGroup: false, intUnreadMsg: 6, isImage: true, strName: "Giovanni Reyna", strText: 'Hi'),
  ChatList(isGroup: false, isImage: true, strName: "Tyler Adams"),
  ChatList(isGroup: false, isImage: true, strName: "Antonee Robinson"),
];

String dummyStrDrFirstimEmail = 'driver1@gmail.com';

String dummyStrDriverEmail = 'driver@gmail.com';

// String dummyStrOwnerEmail = 'driver4@gmail.com';
String dummyStrOwnerEmail = 'mikev@dmggo.com';

String dummyStrManagerEmail = 'laurend@dmggo.com';

List<Chat> listChat = [
  Chat(stgMsg: 'Hello mike', isReceived: true, strTime: "12:24 AM"),
  Chat(stgMsg: 'How Are you?', isReceived: true, strTime: "12:30 AM"),
  Chat(stgMsg: 'Hi', strStatus: status.await.toString(), isReceived: false, strTime: "02:24 PM"),
  Chat(stgMsg: 'Where i need to drop the matterial and where i need to collect the approval', strStatus: status.delivered.toString(), strTime: "02:26 PM", isReceived: false),
  Chat(stgMsg: 'And When i will get the payment', strStatus: status.read.toString(), strTime: "02:27 PM", isReceived: false),
];

List<PTIP> listPTIP = [
  PTIP(strImage: 'assets/images/truck_driver_side.jpeg', strDescription: 'driver side'),
  PTIP(strImage: 'assets/images/truck_front.jpg', strDescription: 'front'),
  PTIP(strImage: 'assets/images/truck_passenger_side.jpeg', strDescription: 'passanger side'),
];

List<String> listWeek = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];

List<String> listYear = ['2022', '2021', '2020', '2019'];

List<String> listMonth = ['Jan', 'Feb', 'Mar', 'Apr'];

List<PTIP> listReconRoutePay = [
  PTIP(strImage: 'AMZL Payment', strDescription: r'$43,342.09'),
  PTIP(strImage: 'Reconciled Amount', strDescription: r'$442.39'),
];

List<PTIP> listReconEqup = [
  PTIP(strImage: 'AMZL Payment', strDescription: r'$43,342.09'),
  PTIP(strImage: 'Reconciled Amount', strDescription: r'$442.39'),
];

List<String> listDispute = ['Approved', 'Rejected', 'Suggest different dispute​'];

String dummyStrReportedDispute = '21/1 - 1 Missing AMZL cancel.\n 26/2 - Remove 3 DSP cancels.\n 27/1 Add 1 training day for Stancy Grove.';
