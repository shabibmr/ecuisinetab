import 'dart:convert';

import 'package:equatable/equatable.dart';

class BillwiseMappingModel extends Equatable {
  final String? VoucherPrefix;
  final String? VoucherType;
  final String? VoucherNo;
  final String? LedgerID;
  final String? RefPrefix;
  final String? RefType;
  final String? RefVoucherNo;
  final String? MethodOfAdjustment;
  final double? DebitAmount = 0;
  final double? CreditAmount = 0;
  final DateTime? VoucherDate;
  final DateTime? DueDate;
  final double? Amount;
  final double? selectedAmount;
  final bool? mapFlag;
  final int? pos;
  final int? salesManId;
  const BillwiseMappingModel({
    this.VoucherPrefix,
    this.VoucherType,
    this.VoucherNo,
    this.LedgerID,
    this.RefPrefix,
    this.RefType,
    this.RefVoucherNo,
    this.MethodOfAdjustment,
    this.VoucherDate,
    this.DueDate,
    this.Amount,
    this.selectedAmount,
    this.mapFlag,
    this.pos,
    this.salesManId,
  });

  BillwiseMappingModel copyWith({
    String? VoucherPrefix,
    String? VoucherType,
    String? VoucherNo,
    String? LedgerID,
    String? RefPrefix,
    String? RefType,
    String? RefVoucherNo,
    String? MethodOfAdjustment,
    DateTime? VoucherDate,
    DateTime? DueDate,
    double? Amount,
    double? selectedAmount,
    bool? mapFlag,
    int? pos,
    int? salesManId,
  }) {
    return BillwiseMappingModel(
      VoucherPrefix: VoucherPrefix ?? this.VoucherPrefix,
      VoucherType: VoucherType ?? this.VoucherType,
      VoucherNo: VoucherNo ?? this.VoucherNo,
      LedgerID: LedgerID ?? this.LedgerID,
      RefPrefix: RefPrefix ?? this.RefPrefix,
      RefType: RefType ?? this.RefType,
      RefVoucherNo: RefVoucherNo ?? this.RefVoucherNo,
      MethodOfAdjustment: MethodOfAdjustment ?? this.MethodOfAdjustment,
      VoucherDate: VoucherDate ?? this.VoucherDate,
      DueDate: DueDate ?? this.DueDate,
      Amount: Amount ?? this.Amount,
      selectedAmount: selectedAmount ?? this.selectedAmount,
      mapFlag: mapFlag ?? this.mapFlag,
      pos: pos ?? this.pos,
      salesManId: salesManId ?? this.salesManId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'VoucherPrefix': VoucherPrefix,
      'VoucherType': VoucherType,
      'VoucherNo': VoucherNo,
      'LedgerID': LedgerID,
      'RefPrefix': RefPrefix,
      'RefType': RefType,
      'RefVoucherNo': RefVoucherNo,
      'MethodOfAdjustment': MethodOfAdjustment,
      'VoucherDate': VoucherDate?.millisecondsSinceEpoch,
      'DueDate': DueDate?.millisecondsSinceEpoch,
      'Amount': Amount,
      'selectedAmount': selectedAmount,
      'mapFlag': mapFlag,
      'pos': pos,
      'salesManId': salesManId,
    };
  }

  factory BillwiseMappingModel.fromMap(Map<String, dynamic> map) {
    return BillwiseMappingModel(
      VoucherPrefix: map['VoucherPrefix'],
      VoucherType: map['VoucherType'],
      VoucherNo: map['VoucherNo'],
      LedgerID: map['LedgerID'],
      RefPrefix: map['RefPrefix'],
      RefType: map['RefType'],
      RefVoucherNo: map['RefVoucherNo'],
      MethodOfAdjustment: map['MethodOfAdjustment'],
      VoucherDate: map['VoucherDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['VoucherDate'])
          : null,
      DueDate: map['DueDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['DueDate'])
          : null,
      Amount: map['Amount']?.toDouble(),
      selectedAmount: map['selectedAmount']?.toDouble(),
      mapFlag: map['mapFlag'],
      pos: map['pos']?.toInt(),
      salesManId: map['salesManId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory BillwiseMappingModel.fromJson(String source) =>
      BillwiseMappingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BillwiseMappingModel(VoucherPrefix: $VoucherPrefix, VoucherType: $VoucherType, VoucherNo: $VoucherNo, LedgerID: $LedgerID, RefPrefix: $RefPrefix, RefType: $RefType, RefVoucherNo: $RefVoucherNo, MethodOfAdjustment: $MethodOfAdjustment, VoucherDate: $VoucherDate, DueDate: $DueDate, Amount: $Amount, selectedAmount: $selectedAmount, mapFlag: $mapFlag, pos: $pos, salesManId: $salesManId)';
  }

  @override
  List<Object?> get props {
    return [
      VoucherPrefix,
      VoucherType,
      VoucherNo,
      LedgerID,
      RefPrefix,
      RefType,
      RefVoucherNo,
      MethodOfAdjustment,
      VoucherDate,
      DueDate,
      Amount,
      selectedAmount,
      mapFlag,
      pos,
      salesManId,
    ];
  }
}
