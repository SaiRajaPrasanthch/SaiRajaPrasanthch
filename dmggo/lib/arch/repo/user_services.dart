import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dmggo/arch/models/get_userinfo.dart';
import 'package:dmggo/arch/repo/api_status.dart';
import 'package:dmggo/arch/repo/apis.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:quickblox_sdk/models/qb_user.dart';

class UserInfo {
  final Apis _api = Apis();
  Future<Object> getUserInfo({required strLUrl}) async {
    try {
      http.Response res = await _api
          .getApi(
            strLUrl: strLUrl,
          )
          .timeout(Duration(seconds: 40));

      if (res.statusCode == i_200) {
        return Success(code: successResponse, response: getUserInfoFromJson(res.body));
      }
      return Faliure(code: invalidResponse, errorResponse: 'Invalid Response');
    } on SocketException {
      return Faliure(code: invalidResponse, errorResponse: 'Invalid Response');
    } on TimeoutException {
      return Faliure(code: timeOut, errorResponse: 'TimeOut');
    } on HttpException {
      return Faliure(code: noInternet, errorResponse: 'No Internet');
    } on FormatException {
      return Faliure(code: invalidFormate, errorResponse: 'Invalid Format');
    } catch (e) {
      return Faliure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }

  Future<Object> postValidUser({required strLUrl, required emailOrPhone, required password}) async {
    try {
      var body = {"PhoneOREmailId": emailOrPhone, "Password": password};

      http.Response res = await _api
          .postApi(
            strLUrl: strLUrl,
            body: body
          )
          .timeout(Duration(seconds: 40));

      if (res.statusCode == i_200) {
        if (json.decode(res.body) == 'Allow to change password page') {
          return Success(code: newUserResponse, response: 'Allow to change password page');
        } else if (json.decode(res.body) == 'Invalid Credentials') {
          return Success(code: invalidCredintials, response: 'Invalid Credentials');
        }

        return Success(code: successResponse, response: getUserInfoFromJson(res.body));
      }
      return Faliure(code: invalidResponse, errorResponse: 'Invalid Response');
    } on SocketException {
      return Faliure(code: invalidResponse, errorResponse: 'Invalid Response');
    } on TimeoutException {
      return Faliure(code: timeOut, errorResponse: 'TimeOut');
    } on HttpException {
      return Faliure(code: noInternet, errorResponse: 'No Internet');
    } on FormatException {
      return Faliure(code: invalidFormate, errorResponse: 'Invalid Format');
    } catch (e) {
      return Faliure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }

  Future<Object> postChangePass({required strLUrl, required emailOrPhone, required password, required oldPassword}) async {
    try {
      var body = {"OldPassword": oldPassword, "NewPassword": password, "emailId": emailOrPhone};
      http.Response res = await _api
          .postApi(
            strLUrl: strLUrl ,
            body: body,
          )
          .timeout(Duration(seconds: 40));

      if (res.statusCode == i_200) {
        if (json.decode(res.body) == 'Invalid Old Password') {
          return Success(code: newUserResponse, response: 'Invalid oldPassword');
        } else if (json.decode(res.body) == 'Invalid Credentials') {
          return Success(code: invalidCredintials, response: 'Invalid Credentials');
        } else if (json.decode(res.body) == 'Password Changed Successfully') {
          return Success(code: successResponse, response: 'Password Changed Successfully');
        }
      }
      return Faliure(code: invalidResponse, errorResponse: 'Invalid Response');
    } on SocketException {
      return Faliure(code: invalidResponse, errorResponse: 'Invalid Response');
    } on TimeoutException {
      return Faliure(code: timeOut, errorResponse: 'TimeOut');
    } on HttpException {
      return Faliure(code: noInternet, errorResponse: 'No Internet');
    } on FormatException {
      return Faliure(code: invalidFormate, errorResponse: 'Invalid Format');
    } catch (e) {
      return Faliure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }

  Future<Object> createUserInfo({required strLUrl, required QBUser qbUsers, required int intUserId, required String strPassword}) async {
    http.Response res;
    try {
      var body = {
        "qbId": qbUsers.id,
        "userId": intUserId,
        "login": qbUsers.login,
        "password": strPassword,
        "email": qbUsers.email,
        "blobId": qbUsers.blobId,
        "externalUserId": qbUsers.externalId,
        "facebookId": qbUsers.facebookId,
        "twitterId": qbUsers.twitterId,
        "fullName": qbUsers.fullName,
        "phone": qbUsers.phone,
        "webSite": qbUsers.website,
        "customData": qbUsers.customData,
        "tagList": qbUsers.tags,
        "status": null
      };
      res = await _api.postApi(strLUrl: strLUrl, body: body).timeout(Duration(seconds: 40));

      if (kDebugMode) {
        print(res);
      }
      if (res.statusCode == i_200) {
        return Success(code: successResponse, response: res.body);
      }
      return Faliure(code: invalidResponse, errorResponse: 'Invalid Response');
    } on SocketException {
      return Faliure(code: invalidResponse, errorResponse: 'Invalid Response');
    } on TimeoutException {
      return Faliure(code: timeOut, errorResponse: 'TimeOut');
    } on HttpException {
      return Faliure(code: noInternet, errorResponse: 'No Internet');
    } on FormatException {
      return Faliure(code: invalidFormate, errorResponse: 'Invalid Format');
    } catch (e) {
      return Faliure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }
}
