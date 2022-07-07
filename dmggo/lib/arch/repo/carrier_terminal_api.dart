import 'dart:async';
import 'dart:io';
import 'package:dmggo/arch/models/all_operation_types.dart';
import 'package:dmggo/arch/models/carrire_terminal_model.dart';
import 'package:dmggo/arch/models/terminals_userId_opsId.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/utils/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dmggo/arch/models/get_userinfo.dart';
import 'package:dmggo/arch/repo/api_status.dart';
import 'package:dmggo/arch/repo/apis.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarrierTerminal {
  final Apis _api = Apis();
  Future<Object> getOperationTypes() async {
    try {
      http.Response res = await _api
          .getApi(
            strLUrl: URL_GET_OPERATION_TYPES ,
          )
          .timeout(Duration(seconds: 40));

      if (res.statusCode == i_200) {
        return Success(code: successResponse, response: allOperationTypesFromJson(res.body));
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
      if (kDebugMode) {
        print(e);
      }
      return Faliure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }
  Future<Object> getCarrierTerminalByUserIdOperationId({required int opsType}) async {
    try {
       SharedPreferences _pre = await prefs;
      http.Response res = await _api
          .getApi(
            strLUrl: URL_GET_CARRIER_TERMINAL_BY_USERID_OPERATIONID + 'terminalId=&userId=${_pre.getInt(intUserId)}&opsType=$opsType',
          )
          .timeout(Duration(seconds: 40));

      if (res.statusCode == i_200) {
        return Success(code: successResponse, response: terminalsbyUserIdOpsIdFromJson(res.body));
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
      if (kDebugMode) {
        print(e);
      }
      return Faliure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }
  Future<Object> getCarrierTerminalByOperationType() async {
    try {
      http.Response res = await _api
          .getApi(
            strLUrl: URL_GET_CARRIER_TERMINAL_BY_OPERATIONTYPE + '6',
          )
          .timeout(Duration(seconds: 40));

      if (res.statusCode == i_200) {
        return Success(code: successResponse, response: carriersTerminalsFromJson(res.body));
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
      if (kDebugMode) {
        print(e);
      }
      return Faliure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }
}
