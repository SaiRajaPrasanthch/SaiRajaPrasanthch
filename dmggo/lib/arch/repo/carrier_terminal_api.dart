import 'dart:async';
import 'dart:io';
import 'package:dmggo/arch/models/carrire_terminal_model.dart';
import 'package:dmggo/arch/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:dmggo/arch/models/get_userinfo.dart';
import 'package:dmggo/arch/repo/api_status.dart';
import 'package:dmggo/arch/repo/apis.dart';
import 'package:dmggo/arch/utils/constants.dart';

class CarrierTerminal{
   final Apis _api = Apis();
   Future<Object> getCarrierTerminalByOperationType() async {
    try {
      http.Response res = await _api
          .getApi(
            strLUrl: URL_GET_CARRIER_TERMINAL_BY_OPERATIONTYPE+'6',
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
      return Faliure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }
}