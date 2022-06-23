// // // To parse this JSON data, do
// // //
// // //     final getUserInfo = getUserInfoFromJson(jsonString);

// // import 'dart:convert';

// // GetUserInfo getUserInfoFromJson(String str) => GetUserInfo.fromJson(json.decode(str));

// // String getUserInfoToJson(GetUserInfo data) => json.encode(data.toJson());

// // class GetUserInfo {
// //   GetUserInfo({
// //     required this.id,
// //     required this.userName,
// //     required this.email,
// //     required this.userType,
// //     required this.chat,
// //     required this.address,
// //     required this.city,
// //     required this.state,
// //     required this.zipCode,
// //     required this.country,
// //     required this.phone,
// //     required this.altPhone,
// //     this.qbLoginId,
// //     required this.accountId,
// //     required this.terminalId,
// //     required this.createdDate,
// //     required this.modifiedDate,
// //     required this.createdBy,
// //     required this.modifiedBy,
// //     required this.lastChatOnlineOn,
// //   });

// //   final int id;
// //   final dynamic userName;
// //   final String email;
// //   final dynamic userType;
// //   final dynamic chat;
// //   final dynamic address;
// //   final dynamic city;
// //   final dynamic state;
// //   final dynamic zipCode;
// //   final dynamic country;
// //   final dynamic phone;
// //   final int altPhone;
// //   final String? qbLoginId;
// //   final int accountId;
// //   final int terminalId;
// //   final String? createdDate;
// //   final String? modifiedDate;
// //   final dynamic createdBy;
// //   final dynamic modifiedBy;
// //   final dynamic lastChatOnlineOn;

// //   // GetUserInfo copyWith({
// //   //     int id,
// //   //     dynamic userName,
// //   //     String email,
// //   //     dynamic userType,
// //   //     dynamic chat,
// //   //     dynamic address,
// //   //     dynamic city,
// //   //     dynamic state,
// //   //     dynamic zipCode,
// //   //     dynamic country,
// //   //     dynamic phone,
// //   //     int altPhone,
// //   //     String qbLoginId,
// //   //     int accountId,
// //   //     int terminalId,
// //   //     DateTime createdDate,
// //   //     DateTime modifiedDate,
// //   //     dynamic createdBy,
// //   //     dynamic modifiedBy,
// //   //     dynamic lastChatOnlineOn,
// //   // }) =>
// //   //     GetUserInfo(
// //   //         id: id ?? this.id,
// //   //         userName: userName ?? this.userName,
// //   //         email: email ?? this.email,
// //   //         userType: userType ?? this.userType,
// //   //         chat: chat ?? this.chat,
// //   //         address: address ?? this.address,
// //   //         city: city ?? this.city,
// //   //         state: state ?? this.state,
// //   //         zipCode: zipCode ?? this.zipCode,
// //   //         country: country ?? this.country,
// //   //         phone: phone ?? this.phone,
// //   //         altPhone: altPhone ?? this.altPhone,
// //   //         qbLoginId: qbLoginId ?? this.qbLoginId,
// //   //         accountId: accountId ?? this.accountId,
// //   //         terminalId: terminalId ?? this.terminalId,
// //   //         createdDate: createdDate ?? this.createdDate,
// //   //         modifiedDate: modifiedDate ?? this.modifiedDate,
// //   //         createdBy: createdBy ?? this.createdBy,
// //   //         modifiedBy: modifiedBy ?? this.modifiedBy,
// //   //         lastChatOnlineOn: lastChatOnlineOn ?? this.lastChatOnlineOn,
// //   //     );

// //   factory GetUserInfo.fromJson(Map<String, dynamic> json) => GetUserInfo(
// //         id: json["id"] ?? json["id"],
// //         userName: json["userName"],
// //         email: json["email"] ?? json["email"],
// //         userType: json["userType"],
// //         chat: json["chat"],
// //         address: json["address"],
// //         city: json["city"],
// //         state: json["state"],
// //         zipCode: json["zipCode"],
// //         country: json["country"],
// //         phone: json["phone"],
// //         altPhone: json["altPhone"] ?? json["altPhone"],
// //         qbLoginId: json["qbLoginId"] ?? json["qbLoginId"],
// //         accountId: json["accountId"] ?? json["accountId"],
// //         terminalId: json["terminalId"] ?? json["terminalId"],
// //         createdDate: json["createdDate"] ?? json["createdDate"],
// //         modifiedDate: json["modifiedDate"] ?? json["modifiedDate"],
// //         createdBy: json["createdBy"],
// //         modifiedBy: json["modifiedBy"],
// //         lastChatOnlineOn: json["lastChatOnlineOn"],
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "userName": userName,
// //         "email": email,
// //         "userType": userType,
// //         "chat": chat,
// //         "address": address,
// //         "city": city,
// //         "state": state,
// //         "zipCode": zipCode,
// //         "country": country,
// //         "phone": phone,
// //         "altPhone": altPhone,
// //         "qbLoginId": qbLoginId,
// //         "accountId": accountId,
// //         "terminalId": terminalId,
// //         "createdDate": createdDate ?? createdDate,
// //         "modifiedDate": modifiedDate ?? modifiedDate,
// //         "createdBy": createdBy,
// //         "modifiedBy": modifiedBy,
// //         "lastChatOnlineOn": lastChatOnlineOn,
// //       };
// // }

// import 'dart:convert';

// GetUserInfo getUserInfoFromJson(String str) => GetUserInfo.fromJson(json.decode(str));

// String getUserInfoToJson(GetUserInfo data) => json.encode(data.toJson());

// class GetUserInfo {
//   GetUserInfo({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.qbLogin,
//     required this.qbPassword,
//     required this.qbId,
//   });

//   final int id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String? qbLogin;
//   final String? qbPassword;
//   final String? qbId;

//   // GetUserInfo copyWith({
//   //     int id,
//   //     String firstName,
//   //     String lastName,
//   //     String email,
//   //     dynamic qbLogin,
//   //     dynamic qbPassword,
//   //     dynamic qbId,
//   // });
//   //  =>
//   //     GetUserInfo(
//   //         id: id ?? this.id,
//   //         firstName: firstName ?? this.firstName,
//   //         lastName: lastName ?? this.lastName,
//   //         email: email ?? this.email,
//   //         qbLogin: qbLogin ?? this.qbLogin,
//   //         qbPassword: qbPassword ?? this.qbPassword,
//   //         qbId: qbId ?? this.qbId,
//   //     );

//   factory GetUserInfo.fromJson(Map<String, dynamic> json) => GetUserInfo(
//         id: json["id"] ?? json["id"],
//         firstName: json["firstName"] ?? json["firstName"],
//         lastName: json["lastName"] ?? json["lastName"],
//         email: json["email"] ?? json["email"],
//         qbLogin: json["qbLogin"],
//         qbPassword: json["qbPassword"],
//         qbId: json["qbId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "firstName": firstName,
//         "lastName": lastName,
//         "email": email,
//         "qbLogin": qbLogin,
//         "qbPassword": qbPassword,
//         "qbId": qbId,
//       };
// }

// To parse this JSON data, do
//
//     final getUserInfo = getUserInfoFromJson(jsonString);

import 'dart:convert';

GetUserInfo getUserInfoFromJson(String str) => GetUserInfo.fromJson(json.decode(str));

String getUserInfoToJson(GetUserInfo data) => json.encode(data.toJson());

class GetUserInfo {
  GetUserInfo({
    required this.salesforceId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.age,
    required this.gender,
    required this.email,
    required this.userType,
    required this.chat,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.phone,
    required this.altPhone,
    required this.qbId,
    required this.dmgGoId,
    required this.dob,
    required this.drivingLicense,
    required this.accountName,
    required this.terminalName,
    required this.accountId,
    required this.terminalId,
    required this.qbLogin,
    required this.qbPassword,
    required this.createdDate,
    required this.modifiedDate,
    required this.createdBy,
    required this.modifiedBy,
    required this.lastChatOnlineOn,
  });

  final int userId;
  final dynamic salesforceId;
  final String firstName;
  final String lastName;
  final String userName;
  final int age;
  final int gender;
  final String email;
  final String? userType;
  final dynamic chat;
  final dynamic address;
  final dynamic city;
  final dynamic state;
  final dynamic zipCode;
  final dynamic country;
  final dynamic phone;
  final dynamic altPhone;
  final dynamic qbId;
  final dynamic dmgGoId;
  final String? dob;
  final String? drivingLicense;
  final dynamic accountName;
  final dynamic terminalName;
  final int accountId;
  final int terminalId;
  final dynamic qbLogin;
  final dynamic qbPassword;
  final String createdDate;
  final String modifiedDate;
  final dynamic createdBy;
  final dynamic modifiedBy;
  final String lastChatOnlineOn;

  GetUserInfo copyWith({
    required int userId,
    dynamic salesforceId,
    required String firstName,
    required String lastName,
    required String userName,
    required int age,
    required int gender,
    required String email,
    required String userType,
    dynamic chat,
    dynamic address,
    dynamic city,
    dynamic state,
    dynamic zipCode,
    dynamic country,
    dynamic phone,
    dynamic altPhone,
    dynamic qbId,
    dynamic dmgGoId,
    required String dob,
    required String drivingLicense,
    dynamic accountName,
    dynamic terminalName,
    required int accountId,
    required int terminalId,
    dynamic qbLogin,
    dynamic qbPassword,
    required String createdDate,
    required String modifiedDate,
    dynamic createdBy,
    dynamic modifiedBy,
    required String lastChatOnlineOn,
  }) =>
      GetUserInfo(
        userId: userId,
        salesforceId: salesforceId ?? this.salesforceId,
        firstName: firstName,
        lastName: lastName,
        userName: userName,
        age: age,
        gender: gender,
        email: email,
        userType: userType,
        chat: chat ?? this.chat,
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        zipCode: zipCode ?? this.zipCode,
        country: country ?? this.country,
        phone: phone ?? this.phone,
        altPhone: altPhone ?? this.altPhone,
        qbId: qbId ?? this.qbId,
        dmgGoId: dmgGoId ?? this.dmgGoId,
        dob: dob,
        drivingLicense: drivingLicense,
        accountName: accountName ?? this.accountName,
        terminalName: terminalName ?? this.terminalName,
        accountId: accountId,
        terminalId: terminalId,
        qbLogin: qbLogin ?? this.qbLogin,
        qbPassword: qbPassword ?? this.qbPassword,
        createdDate: createdDate,
        modifiedDate: modifiedDate,
        createdBy: createdBy ?? this.createdBy,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        lastChatOnlineOn: lastChatOnlineOn,
      );

  factory GetUserInfo.fromJson(Map<String, dynamic> json) => GetUserInfo(
        userId: json["userId"] ?? json["userId"],
        salesforceId: json["salesforceId"],
        firstName: json["firstName"] ?? json["firstName"],
        lastName: json["lastName"] ?? json["lastName"],
        userName: json["userName"] ?? json["userName"],
        age: json["age"] ?? json["age"],
        gender: json["gender"] ?? json["gender"],
        email: json["email"] ?? json["email"],
        userType: json["userType"] ?? json["userType"],
        chat: json["chat"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"],
        country: json["country"],
        phone: json["phone"],
        altPhone: json["altPhone"],
        qbId: json["qbId"],
        dmgGoId: json["dmgGoId"],
        dob: json["dob"] ?? json["dob"],
        drivingLicense: json["drivingLicense"] ?? json["drivingLicense"],
        accountName: json["accountName"],
        terminalName: json["terminalName"],
        accountId: json["accountId"] ?? json["accountId"],
        terminalId: json["terminalId"] ?? json["terminalId"],
        qbLogin: json["qbLogin"],
        qbPassword: json["qbPassword"],
        createdDate: json["createdDate"] ?? json["createdDate"],
        modifiedDate: json["modifiedDate"] ?? json["modifiedDate"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        lastChatOnlineOn: json["lastChatOnlineOn"] ?? json["lastChatOnlineOn"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "salesforceId": salesforceId,
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
        "age": age,
        "gender": gender,
        "email": email,
        "userType": userType,
        "chat": chat,
        "address": address,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "country": country,
        "phone": phone,
        "altPhone": altPhone,
        "qbId": qbId,
        "dmgGoId": dmgGoId,
        "dob": dob,
        "drivingLicense": drivingLicense,
        "accountName": accountName,
        "terminalName": terminalName,
        "accountId": accountId,
        "terminalId": terminalId,
        "qbLogin": qbLogin,
        "qbPassword": qbPassword,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "lastChatOnlineOn": lastChatOnlineOn,
      };
}
