import 'dart:convert';

List<CarriersTerminals> carriersTerminalsFromJson(String str) => List<CarriersTerminals>.from(json.decode(str).map((x) => CarriersTerminals.fromJson(x)));

String carriersTerminalsToJson(List<CarriersTerminals> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarriersTerminals {
  CarriersTerminals({
    this.carrierAccountId,
    this.carrierName,
    this.terminalId,
    this.terminalCode,
    this.terminalName,
    this.terminalCount,
    this.isSelected=false,
    this.children,
  });

  final int? carrierAccountId;
  final String? carrierName;
  final String? terminalId;
  final String? terminalCode;
  final String? terminalName;
  final int? terminalCount;
   bool isSelected;
  final List<CarriersTerminals>? children;

  CarriersTerminals copyWith({
    required int carrierAccountId,
    required String carrierName,
    required String terminalId,
    required String terminalCode,
    required String terminalName,
    required int terminalCount,

    required List<CarriersTerminals> children,
  }) =>
      CarriersTerminals(
        carrierAccountId: carrierAccountId,
        carrierName: carrierName,
        terminalId: terminalId,
        terminalCode: terminalCode,
        terminalName: terminalName,
        terminalCount: terminalCount,
        children: children,
      );

  factory CarriersTerminals.fromJson(Map<String, dynamic> json) => CarriersTerminals(
        carrierAccountId: json["carrierAccountId"] ?? json["carrierAccountId"],
        carrierName: json["carrierName"] ?? json["carrierName"],
        terminalId: json["terminalId"] ?? json["terminalId"],
        terminalCode: json["terminalCode"] ?? json["terminalCode"],
        terminalName: json["terminalName"] ?? json["terminalName"],
        terminalCount: json["terminalCount"] ?? json["terminalCount"],
        children: List<CarriersTerminals>.from(json["children"].map((x) => CarriersTerminals.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "carrierAccountId": carrierAccountId,
        "carrierName": carrierName,
        "terminalId": terminalId,
        "terminalCode": terminalCode,
        "terminalName": terminalName,
        "terminalCount": terminalCount,
        "children": List<dynamic>.from(children!.map((x) => x.toJson())),
      };
}
