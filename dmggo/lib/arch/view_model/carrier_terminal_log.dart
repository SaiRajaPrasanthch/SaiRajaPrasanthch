import 'package:dmggo/arch/models/all_operation_types.dart';
import 'package:dmggo/arch/models/terminals_userId_opsId.dart';
import 'package:dmggo/arch/repo/api_status.dart';
import 'package:dmggo/arch/repo/carrier_terminal_api.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:flutter/material.dart';

class CarrierTerminalLog extends ChangeNotifier {
  List<TerminalsbyUserIdOpsId> _listCarrierTerminal = [];
  List<TerminalsbyUserIdOpsId> get listCarrierTerminals => _listCarrierTerminal;
  set loadData(List<TerminalsbyUserIdOpsId> value) {
    _listCarrierTerminal = value;
    _listCarrierNTerminal = value;
    notifyListeners();
  }

  List<TerminalsbyUserIdOpsId> _listCarrierNTerminal = [];
  List<TerminalsbyUserIdOpsId> get listCarrierNTerminal => _listCarrierNTerminal;
  set loadCarrierNTerminalData(List<TerminalsbyUserIdOpsId> value) {
    _listCarrierNTerminal = value;
    notifyListeners();
  }

  List<AllOperationTypes> _listOpsType = [];
  List<AllOperationTypes> get listOpsType => _listOpsType;
  set loadOpsData(List<AllOperationTypes> value) {
    _listOpsType = value;
  }

  String _selectedCarrierNTerminal = '- select -';
  String get selectedCarrierNTerminal => _selectedCarrierNTerminal;

  bool _selectAll = false;
  bool get selectAll => _selectAll;

  AllOperationTypes _selectedOpsType = AllOperationTypes();
  AllOperationTypes get selectedOpsType => _selectedOpsType;
  set selectedOps(AllOperationTypes value) {
    _selectedOpsType = value;
  }

  carrierSelection(TerminalsbyUserIdOpsId carrier) {
    int index = _listCarrierTerminal.indexWhere((element) => element.accountId == carrier.accountId);
    bool select = false;
    _listCarrierTerminal[index].isCarrierSelected ? select = false : select = true;
    listCarrierTerminals[index].isCarrierSelected = select;
    for (var element in _listCarrierTerminal[index].terminals!) {
      element.isTerminalSelected = select;
    }
    selectAllFromCarrier();
    notifyListeners();
  }

  terminalSelection(TerminalsbyUserIdOpsId carrier, Terminal terminal) {
    int indexCarrier = _listCarrierTerminal.indexWhere((element) => element.accountId == carrier.accountId);
    int indexTerminal = _listCarrierTerminal[indexCarrier].terminals!.indexWhere((element) => element.terminalId == terminal.terminalId);

    bool select = false;
    _listCarrierTerminal[indexCarrier].terminals![indexTerminal].isTerminalSelected ? select = false : select = true;
    _listCarrierTerminal[indexCarrier].terminals![indexTerminal].isTerminalSelected = select;
    List<Terminal> listTrue = _listCarrierTerminal[indexCarrier]
        .terminals!
        .where(
          (element) => element.isTerminalSelected == true,
        )
        .toList();
    if (listTrue.length == _listCarrierTerminal[indexCarrier].terminals!.length) {
      carrierSelection(_listCarrierTerminal[indexCarrier]);
      return;
    }
    List<Terminal> listFalse = _listCarrierTerminal[indexCarrier]
        .terminals!
        .where(
          (element) => element.isTerminalSelected == false,
        )
        .toList();
    if (listFalse.length == _listCarrierTerminal[indexCarrier].terminals!.length) {
      carrierSelection(_listCarrierTerminal[indexCarrier]);
      return;
    }
    notifyListeners();
  }

  selectionDisplay() {
    List<TerminalsbyUserIdOpsId> list = _listCarrierNTerminal.where((element) => element.isCarrierSelected == true).toList();
    if (list.length == i_1) {
      _selectedCarrierNTerminal = list.first.accountName!;
    } else if (list.length > i_1) {
      _selectedCarrierNTerminal = '${list.length} selected';
    } else {
      _selectedCarrierNTerminal = '- select -';
    }
    selectAllFromCarrier();
  }

  selectAllFromCarrier() {
    List<TerminalsbyUserIdOpsId> list = _listCarrierNTerminal.where((element) => element.isCarrierSelected == true).toList();
    if (list.length == _listCarrierTerminal.length) {
      _selectAll = true;
    } else {
      _selectAll = false;
    }
  }

  applyFilter() {
    loadCarrierNTerminalData = _listCarrierTerminal;
    selectionDisplay();
    notifyListeners();
  }

  selectAllCarriersNTerminals(bool v) {
    _selectAll = v;
    for (var element in _listCarrierTerminal) {
      element.isCarrierSelected = _selectAll;
      for (var element in element.terminals!) {
        element.isTerminalSelected = _selectAll;
      }
    }

    notifyListeners();
  }

  getCarriersAndTerminal() async {
    var res = await CarrierTerminal().getCarrierTerminalByOperationType();
    if (res is Success) {
      // loadData = res.response as List<CarriersTerminals>;
    }
  }

  getCarriersAndTerminalByUserIdOperationId({required int opsType}) async {
    var res = await CarrierTerminal().getCarrierTerminalByUserIdOperationId(opsType: opsType);
    if (res is Success) {
      loadData = res.response as List<TerminalsbyUserIdOpsId>;
      selectAllCarriersNTerminals(true);
    applyFilter();
    } else {
      getCarriersAndTerminalByUserIdOperationId(opsType: opsType);
    }
  }

  getOps() async {
    var res = await CarrierTerminal().getOperationTypes();
    if (res is Success) {
      loadOpsData = res.response as List<AllOperationTypes>;
      selectedOpstype(_listOpsType[i_0]);
    } else {
      getOps();
    }
  }

  selectedOpstype(AllOperationTypes v) {
    selectedOps = v;
    _selectedCarrierNTerminal = '- select -';

    getCarriersAndTerminalByUserIdOperationId(opsType: _selectedOpsType.id!);
    
  }
}
