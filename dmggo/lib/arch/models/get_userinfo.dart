// // To parse this JSON data, do
// //
// //     final getUserInfo = getUserInfoFromJson(jsonString);

// import 'dart:convert';

// GetUserInfo getUserInfoFromJson(String str) => GetUserInfo.fromJson(json.decode(str));

// String getUserInfoToJson(GetUserInfo data) => json.encode(data.toJson());

// class GetUserInfo {
//   GetUserInfo({
//     required this.id,
//     required this.userName,
//     required this.email,
//     required this.userType,
//     required this.chat,
//     required this.address,
//     required this.city,
//     required this.state,
//     required this.zipCode,
//     required this.country,
//     required this.phone,
//     required this.altPhone,
//     this.qbLoginId,
//     required this.accountId,
//     required this.terminalId,
//     required this.createdDate,
//     required this.modifiedDate,
//     required this.createdBy,
//     required this.modifiedBy,
//     required this.lastChatOnlineOn,
//   });

//   final int id;
//   final dynamic userName;
//   final String email;
//   final dynamic userType;
//   final dynamic chat;
//   final dynamic address;
//   final dynamic city;
//   final dynamic state;
//   final dynamic zipCode;
//   final dynamic country;
//   final dynamic phone;
//   final int altPhone;
//   final String? qbLoginId;
//   final int accountId;
//   final int terminalId;
//   final String? createdDate;
//   final String? modifiedDate;
//   final dynamic createdBy;
//   final dynamic modifiedBy;
//   final dynamic lastChatOnlineOn;

//   // GetUserInfo copyWith({
//   //     int id,
//   //     dynamic userName,
//   //     String email,
//   //     dynamic userType,
//   //     dynamic chat,
//   //     dynamic address,
//   //     dynamic city,
//   //     dynamic state,
//   //     dynamic zipCode,
//   //     dynamic country,
//   //     dynamic phone,
//   //     int altPhone,
//   //     String qbLoginId,
//   //     int accountId,
//   //     int terminalId,
//   //     DateTime createdDate,
//   //     DateTime modifiedDate,
//   //     dynamic createdBy,
//   //     dynamic modifiedBy,
//   //     dynamic lastChatOnlineOn,
//   // }) =>
//   //     GetUserInfo(
//   //         id: id ?? this.id,
//   //         userName: userName ?? this.userName,
//   //         email: email ?? this.email,
//   //         userType: userType ?? this.userType,
//   //         chat: chat ?? this.chat,
//   //         address: address ?? this.address,
//   //         city: city ?? this.city,
//   //         state: state ?? this.state,
//   //         zipCode: zipCode ?? this.zipCode,
//   //         country: country ?? this.country,
//   //         phone: phone ?? this.phone,
//   //         altPhone: altPhone ?? this.altPhone,
//   //         qbLoginId: qbLoginId ?? this.qbLoginId,
//   //         accountId: accountId ?? this.accountId,
//   //         terminalId: terminalId ?? this.terminalId,
//   //         createdDate: createdDate ?? this.createdDate,
//   //         modifiedDate: modifiedDate ?? this.modifiedDate,
//   //         createdBy: createdBy ?? this.createdBy,
//   //         modifiedBy: modifiedBy ?? this.modifiedBy,
//   //         lastChatOnlineOn: lastChatOnlineOn ?? this.lastChatOnlineOn,
//   //     );

//   factory GetUserInfo.fromJson(Map<String, dynamic> json) => GetUserInfo(
//         id: json["id"] ?? json["id"],
//         userName: json["userName"],
//         email: json["email"] ?? json["email"],
//         userType: json["userType"],
//         chat: json["chat"],
//         address: json["address"],
//         city: json["city"],
//         state: json["state"],
//         zipCode: json["zipCode"],
//         country: json["country"],
//         phone: json["phone"],
//         altPhone: json["altPhone"] ?? json["altPhone"],
//         qbLoginId: json["qbLoginId"] ?? json["qbLoginId"],
//         accountId: json["accountId"] ?? json["accountId"],
//         terminalId: json["terminalId"] ?? json["terminalId"],
//         createdDate: json["createdDate"] ?? json["createdDate"],
//         modifiedDate: json["modifiedDate"] ?? json["modifiedDate"],
//         createdBy: json["createdBy"],
//         modifiedBy: json["modifiedBy"],
//         lastChatOnlineOn: json["lastChatOnlineOn"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "userName": userName,
//         "email": email,
//         "userType": userType,
//         "chat": chat,
//         "address": address,
//         "city": city,
//         "state": state,
//         "zipCode": zipCode,
//         "country": country,
//         "phone": phone,
//         "altPhone": altPhone,
//         "qbLoginId": qbLoginId,
//         "accountId": accountId,
//         "terminalId": terminalId,
//         "createdDate": createdDate ?? createdDate,
//         "modifiedDate": modifiedDate ?? modifiedDate,
//         "createdBy": createdBy,
//         "modifiedBy": modifiedBy,
//         "lastChatOnlineOn": lastChatOnlineOn,
//       };
// }

import 'dart:convert';

GetUserInfo getUserInfoFromJson(String str) => GetUserInfo.fromJson(json.decode(str));

String getUserInfoToJson(GetUserInfo data) => json.encode(data.toJson());

class GetUserInfo {
  GetUserInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.qbLogin,
    required this.qbPassword,
    required this.qbId,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? qbLogin;
  final String? qbPassword;
  final String? qbId;

  // GetUserInfo copyWith({
  //     int id,
  //     String firstName,
  //     String lastName,
  //     String email,
  //     dynamic qbLogin,
  //     dynamic qbPassword,
  //     dynamic qbId,
  // });
  //  =>
  //     GetUserInfo(
  //         id: id ?? this.id,
  //         firstName: firstName ?? this.firstName,
  //         lastName: lastName ?? this.lastName,
  //         email: email ?? this.email,
  //         qbLogin: qbLogin ?? this.qbLogin,
  //         qbPassword: qbPassword ?? this.qbPassword,
  //         qbId: qbId ?? this.qbId,
  //     );

  factory GetUserInfo.fromJson(Map<String, dynamic> json) => GetUserInfo(
        id: json["id"] ?? json["id"],
        firstName: json["firstName"] ?? json["firstName"],
        lastName: json["lastName"] ?? json["lastName"],
        email: json["email"] ?? json["email"],
        qbLogin: json["qbLogin"],
        qbPassword: json["qbPassword"],
        qbId: json["qbId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "qbLogin": qbLogin,
        "qbPassword": qbPassword,
        "qbId": qbId,
      };
}
 