import 'dart:convert';

import 'package:dmggo/arch/utils/constants.dart';
import 'package:http/http.dart' as http;

class Apis {
  Future<http.Response> getApi({required String strLUrl}) async {
    Uri url = Uri.parse(strLUrl);
    http.Response res = await http.get(url, headers: strHeaders);
    return res;
  }

  Future<http.Response> postApi({required String strLUrl, var body}) async {
    Uri url = Uri.parse(strLUrl);
   
    http.Response res = await http.post(url, headers: strHeaders, body: json.encode(body));
    return res;
  }
}
