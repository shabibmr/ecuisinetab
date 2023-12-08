// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../Datamodels/HiveModels/UOM/UOMHiveModel.dart';

class BatchDataModel extends Equatable {
  final String? itemID;
  final String? itemReqId;
  final String? SKUID;
  final String? batchNo;
  final String? batchName;
  final String? serialNo;
  final String? serialNoFrom;
  final String? serialNoTo;
  final String? serialSuffix;
  final String? serialPrefix;

  final String? VoucherNo;
  final String? VoucherType;
  final String? VoucherPrefix;
  final String? RefNo;
  final String? RefType;
  final String? RefPrefix;
  final DateTime? voucherDate;

  final DateTime? MfgDate;
  final DateTime? ExpiryDate;
  final String? shelfLife;
  final double? purchaseCost;
  final double? sellingPrice;

  final double? crQty;
  final double? drQty;
  final double? stock;
  final UOMHiveMOdel? uom;

  final String? fromGodown;
  final String? toGodown;
  final String? godownName;

  final String? transactionId;
  final String? RequirementVoucherNo;

  final String? fromLedger;
  final String? toLedger;

  const BatchDataModel({
    this.itemID,
    this.itemReqId,
    this.SKUID,
    this.batchNo,
    this.batchName,
    this.serialNo,
    this.serialNoFrom,
    this.serialNoTo,
    this.serialSuffix,
    this.serialPrefix,
    this.VoucherNo,
    this.VoucherType,
    this.VoucherPrefix,
    this.RefNo,
    this.RefType,
    this.RefPrefix,
    this.voucherDate,
    this.MfgDate,
    this.ExpiryDate,
    this.shelfLife,
    this.purchaseCost,
    this.sellingPrice,
    this.crQty,
    this.drQty,
    this.stock,
    this.uom,
    this.fromGodown,
    this.toGodown,
    this.godownName,
    this.transactionId,
    this.RequirementVoucherNo,
    this.fromLedger,
    this.toLedger,
  });

  BatchDataModel copyWith({
    String? itemID,
    String? itemReqId,
    String? SKUID,
    String? batchNo,
    String? batchName,
    String? serialNo,
    String? serialNoFrom,
    String? serialNoTo,
    String? serialSuffix,
    String? serialPrefix,
    String? VoucherNo,
    String? VoucherType,
    String? VoucherPrefix,
    String? RefNo,
    String? RefType,
    String? RefPrefix,
    DateTime? voucherDate,
    DateTime? MfgDate,
    DateTime? ExpiryDate,
    String? shelfLife,
    double? purchaseCost,
    double? sellingPrice,
    double? crQty,
    double? drQty,
    double? stock,
    UOMHiveMOdel? uom,
    String? fromGodown,
    String? toGodown,
    String? godownName,
    String? transactionId,
    String? RequirementVoucherNo,
    String? fromLedger,
    String? toLedger,
  }) {
    return BatchDataModel(
      itemID: itemID ?? this.itemID,
      itemReqId: itemReqId ?? this.itemReqId,
      SKUID: SKUID ?? this.SKUID,
      batchNo: batchNo ?? this.batchNo,
      batchName: batchName ?? this.batchName,
      serialNo: serialNo ?? this.serialNo,
      serialNoFrom: serialNoFrom ?? this.serialNoFrom,
      serialNoTo: serialNoTo ?? this.serialNoTo,
      serialSuffix: serialSuffix ?? this.serialSuffix,
      serialPrefix: serialPrefix ?? this.serialPrefix,
      VoucherNo: VoucherNo ?? this.VoucherNo,
      VoucherType: VoucherType ?? this.VoucherType,
      VoucherPrefix: VoucherPrefix ?? this.VoucherPrefix,
      RefNo: RefNo ?? this.RefNo,
      RefType: RefType ?? this.RefType,
      RefPrefix: RefPrefix ?? this.RefPrefix,
      voucherDate: voucherDate ?? this.voucherDate,
      MfgDate: MfgDate ?? this.MfgDate,
      ExpiryDate: ExpiryDate ?? this.ExpiryDate,
      shelfLife: shelfLife ?? this.shelfLife,
      purchaseCost: purchaseCost ?? this.purchaseCost,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      crQty: crQty ?? this.crQty,
      drQty: drQty ?? this.drQty,
      stock: stock ?? this.stock,
      uom: uom ?? this.uom,
      fromGodown: fromGodown ?? this.fromGodown,
      toGodown: toGodown ?? this.toGodown,
      godownName: godownName ?? this.godownName,
      transactionId: transactionId ?? this.transactionId,
      RequirementVoucherNo: RequirementVoucherNo ?? this.RequirementVoucherNo,
      fromLedger: fromLedger ?? this.fromLedger,
      toLedger: toLedger ?? this.toLedger,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemID': itemID,
      'itemReqId': itemReqId,
      'SKUID': SKUID,
      'batchNo': batchNo,
      'batchName': batchName,
      'serialNo': serialNo,
      'serialNoFrom': serialNoFrom,
      'serialNoTo': serialNoTo,
      'serialSuffix': serialSuffix,
      'serialPrefix': serialPrefix,
      'VoucherNo': VoucherNo,
      'VoucherType': VoucherType,
      'VoucherPrefix': VoucherPrefix,
      'RefNo': RefNo,
      'RefType': RefType,
      'RefPrefix': RefPrefix,
      'voucherDate': voucherDate?.millisecondsSinceEpoch,
      'MfgDate': MfgDate?.millisecondsSinceEpoch,
      'ExpiryDate': ExpiryDate?.millisecondsSinceEpoch,
      'shelfLife': shelfLife,
      'purchaseCost': purchaseCost,
      'sellingPrice': sellingPrice,
      'crQty': crQty,
      'drQty': drQty,
      'uom': uom,
      'fromGodown': fromGodown,
      'toGodown': toGodown,
      'transactionId': transactionId,
      'RequirementVoucherNo': RequirementVoucherNo,
    };
  }

  factory BatchDataModel.fromMap(Map<String, dynamic> map) {
    return BatchDataModel(
      itemID: map['itemID'],
      itemReqId: map['itemReqId'],
      SKUID: map['SKUID'],
      batchNo: map['batchNo'],
      batchName: map['batchName'],
      serialNo: map['Serial_No'],
      serialNoFrom: map['serialNoFrom'],
      serialNoTo: map['serialNoTo'],
      serialSuffix: map['serialSuffix'],
      serialPrefix: map['serialPrefix'],
      VoucherNo: map['VoucherNo'],
      VoucherType: map['VoucherType'],
      VoucherPrefix: map['VoucherPrefix'],
      RefNo: map['RefNo'],
      RefType: map['RefType'],
      RefPrefix: map['RefPrefix'],
      voucherDate: DateTime.fromMillisecondsSinceEpoch(
          int.parse(map['Voucher_Date'] ?? '0') * 1000),
      MfgDate: DateTime.fromMillisecondsSinceEpoch(
          int.parse(map['MfgDate'] ?? '0') * 1000),
      ExpiryDate: DateTime.fromMillisecondsSinceEpoch(
          int.parse(map['ExpiryDate'] ?? '0') * 1000),
      shelfLife: map['shelfLife'],
      purchaseCost: double.parse(map['purchaseCost'] ?? '0'),
      sellingPrice: double.parse(map['sellingPrice'] ?? '0'),
      crQty: double.parse(map['crQty'] ?? '0'),
      drQty: double.parse(map['drQty'] ?? '0'),
      uom: map['uom'] != null ? UOMHiveMOdel(UOM_id: map['uom']) : null,
      fromGodown: map['fromGodown'],
      toGodown: map['toGodown'],
      godownName: map['Godown_Name'],
      transactionId: map['transactionId'],
      RequirementVoucherNo: map['RequirementVoucherNo'],
      stock: double.parse(map['stock'] ?? 0),
    );
  }

  String toJson() => json.encode(toMap());

  factory BatchDataModel.fromJson(String source) =>
      BatchDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BatchDataModel(itemID: $itemID, itemReqId: $itemReqId, SKUID: $SKUID, batchNo: $batchNo, batchName: $batchName, serialNoFrom: $serialNoFrom, serialNoTo: $serialNoTo, serialSuffix: $serialSuffix, serialPrefix: $serialPrefix, VoucherNo: $VoucherNo, VoucherType: $VoucherType, VoucherPrefix: $VoucherPrefix, RefNo: $RefNo, RefType: $RefType, RefPrefix: $RefPrefix, voucherDate: $voucherDate, MfgDate: $MfgDate, ExpiryDate: $ExpiryDate, shelfLife: $shelfLife, purchaseCost: $purchaseCost, sellingPrice: $sellingPrice, crQty: $crQty, drQty: $drQty, uom: $uom,)';
  }

  @override
  List<Object?> get props {
    return [
      itemID,
      itemReqId,
      SKUID,
      batchNo,
      batchName,
      serialNo,
      serialNoFrom,
      serialNoTo,
      serialSuffix,
      serialPrefix,
      VoucherNo,
      VoucherType,
      VoucherPrefix,
      RefNo,
      RefType,
      RefPrefix,
      voucherDate,
      MfgDate,
      ExpiryDate,
      shelfLife,
      purchaseCost,
      sellingPrice,
      crQty,
      drQty,
      stock,
      uom,
      fromGodown,
      toGodown,
      godownName,
      transactionId,
      RequirementVoucherNo,
      fromLedger,
      toLedger,
    ];
  }
}
