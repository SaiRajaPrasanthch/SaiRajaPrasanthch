import 'dart:convert';

List<TerminalsbyUserIdOpsId> terminalsbyUserIdOpsIdFromJson(String str) => List<TerminalsbyUserIdOpsId>.from(json.decode(str).map((x) => TerminalsbyUserIdOpsId.fromJson(x)));

String terminalsbyUserIdOpsIdToJson(List<TerminalsbyUserIdOpsId> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TerminalsbyUserIdOpsId {
  TerminalsbyUserIdOpsId(
      {this.accountId,
      this.accountName,
      this.ownerName,
      this.ownerEmail,
      this.launchedOn,
      this.address,
      this.city,
      this.state,
      this.zipCode,
      this.country,
      this.phone,
      this.fax,
      this.status,
      this.ownerId,
      this.carrierLaunchedOn,
      this.carrierTimeZoneOffSet,
      this.terminals,
      this.isCarrierSelected = false});

  int? accountId;
  String? accountName;
  String? ownerName;
  String? ownerEmail;
  dynamic launchedOn;
  String? address;
  String? city;
  String? state;
  String? zipCode;
  String? country;
  String? phone;
  String? fax;
  int? status;
  int? ownerId;
  dynamic carrierLaunchedOn;
  dynamic carrierTimeZoneOffSet;
  bool isCarrierSelected;
  List<Terminal>? terminals;

  TerminalsbyUserIdOpsId copyWith({
    int? accountId,
    String? accountName,
    String? ownerName,
    String? ownerEmail,
    dynamic launchedOn,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    String? phone,
    String? fax,
    int? status,
    int? ownerId,
    dynamic carrierLaunchedOn,
    dynamic carrierTimeZoneOffSet,
    List<Terminal>? terminals,
  }) =>
      TerminalsbyUserIdOpsId(
        accountId: accountId ?? this.accountId,
        accountName: accountName ?? this.accountName,
        ownerName: ownerName ?? this.ownerName,
        ownerEmail: ownerEmail ?? this.ownerEmail,
        launchedOn: launchedOn ?? this.launchedOn,
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        zipCode: zipCode ?? this.zipCode,
        country: country ?? this.country,
        phone: phone ?? this.phone,
        fax: fax ?? this.fax,
        status: status ?? this.status,
        ownerId: ownerId ?? this.ownerId,
        carrierLaunchedOn: carrierLaunchedOn ?? this.carrierLaunchedOn,
        carrierTimeZoneOffSet: carrierTimeZoneOffSet ?? this.carrierTimeZoneOffSet,
        terminals: terminals ?? this.terminals,
      );

  factory TerminalsbyUserIdOpsId.fromJson(Map<String, dynamic> json) => TerminalsbyUserIdOpsId(
        accountId: json["accountId"],
        accountName: json["accountName"],
        ownerName: json["ownerName"] ?? json["ownerName"],
        ownerEmail: json["ownerEmail"] ?? json["ownerEmail"],
        launchedOn: json["launchedOn"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"],
        country: json["country"],
        phone: json["phone"],
        fax: json["fax"],
        status: json["status"],
        ownerId: json["ownerId"],
        carrierLaunchedOn: json["carrierLaunchedOn"],
        carrierTimeZoneOffSet: json["carrierTimeZoneOffSet"],
        terminals: List<Terminal>.from(json["terminals"].map((x) => Terminal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "accountName": accountName,
        "ownerName": ownerName ?? ownerName,
        "ownerEmail": ownerEmail ?? ownerEmail,
        "launchedOn": launchedOn,
        "address": address,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "country": country,
        "phone": phone,
        "fax": fax,
        "status": status,
        "ownerId": ownerId,
        "carrierLaunchedOn": carrierLaunchedOn,
        "carrierTimeZoneOffSet": carrierTimeZoneOffSet,
        "terminals": List<dynamic>.from(terminals!.map((x) => x.toJson())),
      };
}

class Terminal {
  Terminal({
    this.terminalId,
    this.terminalName,
    this.terminalCode,
    this.stationCode,
    this.accountName,
    this.managerName,
    this.managerEmail,
    this.launchedOn,
    this.cancelledOn,
    this.timeZoneOffSet,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.phone,
    this.fax,
    this.status,
    this.isTerminalSelected=false,
    this.managerId,
  });

  int? terminalId;
  String? terminalName;
  String? terminalCode;
  String? stationCode;
  String? accountName;
  String? managerName;
  String? managerEmail;
  String? launchedOn;
  dynamic cancelledOn;
  String? timeZoneOffSet;
  String? address;
  String? city;
  String? state;
  String? zipCode;
  String? country;
  String? phone;
  String? fax;
  int? status;
  bool isTerminalSelected;
  int? managerId;

  Terminal copyWith({
    int? terminalId,
    String? terminalName,
    String? terminalCode,
    String? stationCode,
    String? accountName,
    String? managerName,
    String? managerEmail,
    String? launchedOn,
    dynamic cancelledOn,
    String? timeZoneOffSet,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    String? phone,
    String? fax,
    int? status,
    int? managerId,
  }) =>
      Terminal(
        terminalId: terminalId ?? this.terminalId,
        terminalName: terminalName ?? this.terminalName,
        terminalCode: terminalCode ?? this.terminalCode,
        stationCode: stationCode ?? this.stationCode,
        accountName: accountName ?? this.accountName,
        managerName: managerName ?? this.managerName,
        managerEmail: managerEmail ?? this.managerEmail,
        launchedOn: launchedOn ?? this.launchedOn,
        cancelledOn: cancelledOn ?? this.cancelledOn,
        timeZoneOffSet: timeZoneOffSet ?? this.timeZoneOffSet,
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        zipCode: zipCode ?? this.zipCode,
        country: country ?? this.country,
        phone: phone ?? this.phone,
        fax: fax ?? this.fax,
        status: status ?? this.status,
        managerId: managerId ?? this.managerId,
      );

  factory Terminal.fromJson(Map<String, dynamic> json) => Terminal(
        terminalId: json["terminalId"],
        terminalName: json["terminalName"],
        terminalCode: json["terminalCode"],
        stationCode: json["stationCode"],
        accountName: json["accountName"],
        managerName: json["managerName"] ?? json["managerName"],
        managerEmail: json["managerEmail"] ?? json["managerEmail"],
        launchedOn: json["launchedOn"],
        cancelledOn: json["cancelledOn"],
        timeZoneOffSet: json["timeZoneOffSet"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"],
        country: json["country"],
        phone: json["phone"],
        fax: json["fax"],
        status: json["status"],
        managerId: json["managerId"],
      );

  Map<String, dynamic> toJson() => {
        "terminalId": terminalId,
        "terminalName": terminalName,
        "terminalCode": terminalCode,
        "stationCode": stationCode,
        "accountName": accountName,
        "managerName": managerName ?? managerName,
        "managerEmail": managerEmail ?? managerEmail,
        "launchedOn": launchedOn,
        "cancelledOn": cancelledOn,
        "timeZoneOffSet": timeZoneOffSet,
        "address": address,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "country": country,
        "phone": phone,
        "fax": fax,
        "status": status,
        "managerId": managerId,
      };
}
