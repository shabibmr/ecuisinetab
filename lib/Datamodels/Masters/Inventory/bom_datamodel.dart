import 'dart:convert';

import 'package:equatable/equatable.dart';

class BOMDataModel extends Equatable {
  final String? SalesItem;
  final double? SalesItemQty;
  final String? PurchaseItem;
  final String? PurchaseItemName;
  final double? PurchaseItemQty;
  final String? PurchaseUom;
  final double? conValue;
  final String? purchaseItemSection;
  final String? RouteID;
  final double? pRate;
  const BOMDataModel({
    this.SalesItem,
    this.SalesItemQty,
    this.PurchaseItem,
    this.PurchaseItemName,
    this.PurchaseItemQty,
    this.PurchaseUom,
    this.conValue,
    this.purchaseItemSection,
    this.RouteID,
    this.pRate,
  });

  BOMDataModel copyWith({
    String? SalesItem,
    double? SalesItemQty,
    String? PurchaseItem,
    String? PurchaseItemName,
    double? PurchaseItemQty,
    String? PurchaseUom,
    double? conValue,
    String? purchaseItemSection,
    String? RouteID,
    double? pRate,
  }) {
    return BOMDataModel(
      SalesItem: SalesItem ?? this.SalesItem,
      SalesItemQty: SalesItemQty ?? this.SalesItemQty,
      PurchaseItem: PurchaseItem ?? this.PurchaseItem,
      PurchaseItemName: PurchaseItemName ?? this.PurchaseItemName,
      PurchaseItemQty: PurchaseItemQty ?? this.PurchaseItemQty,
      PurchaseUom: PurchaseUom ?? this.PurchaseUom,
      conValue: conValue ?? this.conValue,
      purchaseItemSection: purchaseItemSection ?? this.purchaseItemSection,
      RouteID: RouteID ?? this.RouteID,
      pRate: pRate ?? this.pRate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'SalesItem': SalesItem,
      'SalesItemQty': SalesItemQty,
      'PurchaseItem': PurchaseItem,
      'PurchaseItemName': PurchaseItemName,
      'PurchaseItemQty': PurchaseItemQty,
      'PurchaseUom': PurchaseUom,
      'conValue': conValue,
      'purchaseItemSection': purchaseItemSection,
      'RouteID': RouteID,
      'pRate': pRate,
    };
  }

  factory BOMDataModel.fromMap(Map<String, dynamic> map) {
    return BOMDataModel(
      SalesItem: map['SalesItem'],
      SalesItemQty: map['SalesItemQty']?.toDouble(),
      PurchaseItem: map['PurchaseItem'],
      PurchaseItemName: map['PurchaseItemName'],
      PurchaseItemQty: map['PurchaseItemQty']?.toDouble(),
      PurchaseUom: map['PurchaseUom'],
      conValue: map['conValue']?.toDouble(),
      purchaseItemSection: map['purchaseItemSection'],
      RouteID: map['RouteID'],
      pRate: map['pRate']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory BOMDataModel.fromJson(String source) =>
      BOMDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BOMDataModel(SalesItem: $SalesItem, SalesItemQty: $SalesItemQty, PurchaseItem: $PurchaseItem, PurchaseItemName: $PurchaseItemName, PurchaseItemQty: $PurchaseItemQty, PurchaseUom: $PurchaseUom, conValue: $conValue, purchaseItemSection: $purchaseItemSection, RouteID: $RouteID, pRate: $pRate)';
  }

  @override
  List<Object?> get props {
    return [
      SalesItem,
      SalesItemQty,
      PurchaseItem,
      PurchaseItemName,
      PurchaseItemQty,
      PurchaseUom,
      conValue,
      purchaseItemSection,
      RouteID,
      pRate,
    ];
  }
}
