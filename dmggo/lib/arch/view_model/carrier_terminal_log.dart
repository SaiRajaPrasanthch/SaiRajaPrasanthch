import 'package:dmggo/arch/models/carrire_terminal_model.dart';
import 'package:dmggo/arch/repo/api_status.dart';
import 'package:dmggo/arch/repo/carrier_terminal_api.dart';
import 'package:flutter/material.dart';

class CarrierTerminalLog extends ChangeNotifier {
  List<CarriersTerminals> _listCarrierTerminal = [];
  List<CarriersTerminals> get listCarrierTerminals => _listCarrierTerminal;
  set loadData(List<CarriersTerminals> value) {
    _listCarrierTerminal = value;
    notifyListeners();
  }

  getCarriersAndTerminal() async {
    var res = await CarrierTerminal().getCarrierTerminalByOperationType();
    if (res is Success) {
      loadData = res.response as List<CarriersTerminals>;
    }
  }
}
