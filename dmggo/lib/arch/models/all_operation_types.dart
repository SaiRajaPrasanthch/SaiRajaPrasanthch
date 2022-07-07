// To parse this JSON data, do
//
//     final allOperationTypes = allOperationTypesFromJson(jsonString);

import 'dart:convert';

List<AllOperationTypes> allOperationTypesFromJson(String str) => List<AllOperationTypes>.from(json.decode(str).map((x) => AllOperationTypes.fromJson(x)));

String allOperationTypesToJson(List<AllOperationTypes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllOperationTypes {
    AllOperationTypes({
        this.id,
        this.type,
        this.value,
        this.displayName,
        this.displayOrder,
        this.isActive,
        this.createdOn,
    });

    int? id;
    String? type;
    String? value;
    String? displayName;
    String? displayOrder;
    int? isActive;
    DateTime? createdOn;

    AllOperationTypes copyWith({
        int? id,
        String? type,
        String? value,
        String? displayName,
        String? displayOrder,
        int? isActive,
        DateTime? createdOn,
    }) => 
        AllOperationTypes(
            id: id ?? this.id,
            type: type ?? this.type,
            value: value ?? this.value,
            displayName: displayName ?? this.displayName,
            displayOrder: displayOrder ?? this.displayOrder,
            isActive: isActive ?? this.isActive,
            createdOn: createdOn ?? this.createdOn,
        );

    factory AllOperationTypes.fromJson(Map<String, dynamic> json) => AllOperationTypes(
        id: json["id"],
        type: json["type"],
        value: json["value"],
        displayName: json["displayName"],
        displayOrder: json["displayOrder"],
        isActive: json["isActive"],
        createdOn: DateTime.parse(json["createdOn"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
        "displayName": displayName,
        "displayOrder": displayOrder,
        "isActive": isActive,
        "createdOn": createdOn,
    };
}
