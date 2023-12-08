import 'dart:convert';

import 'package:equatable/equatable.dart';

class ChequeDetailModel extends Equatable {
  final String? id;
  final String? LedgerName;
  final String? LedgerID;
  final String? OurBankId;
  final String? BankID;
  final String? BankName;
  final String? TransactionType;
  final double? Amount = 0;
  final double? crAmount = 0;
  final double? drAmount = 0;
  final String? ChequeNo;
  final String? VoucherID;
  final String? VoucherType;
  final String? VoucherPrefix;
  final DateTime? IssuedOn;
  final String? Branch;
  final String? IFSC;
  final DateTime? InstrumentDate;
  final String? RefNumber;
  final bool? reconciled;
  final DateTime? reconciledDate;
  final bool? isPresented;
  final DateTime? presentedOn;
  final bool? isCleared;
  final DateTime? clearedOn;
  final bool? isRejected;
  final String? Narration;
  const ChequeDetailModel({
    this.id,
    this.LedgerName,
    this.LedgerID,
    this.OurBankId,
    this.BankID,
    this.BankName,
    this.TransactionType,
    this.ChequeNo,
    this.VoucherID,
    this.VoucherType,
    this.VoucherPrefix,
    this.IssuedOn,
    this.Branch,
    this.IFSC,
    this.InstrumentDate,
    this.RefNumber,
    this.reconciled,
    this.reconciledDate,
    this.isPresented,
    this.presentedOn,
    this.isCleared,
    this.clearedOn,
    this.isRejected,
    this.Narration,
  });

  ChequeDetailModel copyWith({
    String? id,
    String? LedgerName,
    String? LedgerID,
    String? OurBankId,
    String? BankID,
    String? BankName,
    String? TransactionType,
    String? ChequeNo,
    String? VoucherID,
    String? VoucherType,
    String? VoucherPrefix,
    DateTime? IssuedOn,
    String? Branch,
    String? IFSC,
    DateTime? InstrumentDate,
    String? RefNumber,
    bool? reconciled,
    DateTime? reconciledDate,
    bool? isPresented,
    DateTime? presentedOn,
    bool? isCleared,
    DateTime? clearedOn,
    bool? isRejected,
    String? Narration,
  }) {
    return ChequeDetailModel(
      id: id ?? this.id,
      LedgerName: LedgerName ?? this.LedgerName,
      LedgerID: LedgerID ?? this.LedgerID,
      OurBankId: OurBankId ?? this.OurBankId,
      BankID: BankID ?? this.BankID,
      BankName: BankName ?? this.BankName,
      TransactionType: TransactionType ?? this.TransactionType,
      ChequeNo: ChequeNo ?? this.ChequeNo,
      VoucherID: VoucherID ?? this.VoucherID,
      VoucherType: VoucherType ?? this.VoucherType,
      VoucherPrefix: VoucherPrefix ?? this.VoucherPrefix,
      IssuedOn: IssuedOn ?? this.IssuedOn,
      Branch: Branch ?? this.Branch,
      IFSC: IFSC ?? this.IFSC,
      InstrumentDate: InstrumentDate ?? this.InstrumentDate,
      RefNumber: RefNumber ?? this.RefNumber,
      reconciled: reconciled ?? this.reconciled,
      reconciledDate: reconciledDate ?? this.reconciledDate,
      isPresented: isPresented ?? this.isPresented,
      presentedOn: presentedOn ?? this.presentedOn,
      isCleared: isCleared ?? this.isCleared,
      clearedOn: clearedOn ?? this.clearedOn,
      isRejected: isRejected ?? this.isRejected,
      Narration: Narration ?? this.Narration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'LedgerName': LedgerName,
      'LedgerID': LedgerID,
      'OurBankId': OurBankId,
      'BankID': BankID,
      'BankName': BankName,
      'TransactionType': TransactionType,
      'ChequeNo': ChequeNo,
      'VoucherID': VoucherID,
      'VoucherType': VoucherType,
      'VoucherPrefix': VoucherPrefix,
      'IssuedOn': IssuedOn?.millisecondsSinceEpoch,
      'Branch': Branch,
      'IFSC': IFSC,
      'InstrumentDate': InstrumentDate?.millisecondsSinceEpoch,
      'RefNumber': RefNumber,
      'reconciled': reconciled,
      'reconciledDate': reconciledDate?.millisecondsSinceEpoch,
      'isPresented': isPresented,
      'presentedOn': presentedOn?.millisecondsSinceEpoch,
      'isCleared': isCleared,
      'clearedOn': clearedOn?.millisecondsSinceEpoch,
      'isRejected': isRejected,
      'Narration': Narration,
    };
  }

  factory ChequeDetailModel.fromMap(Map<String, dynamic> map) {
    return ChequeDetailModel(
      id: map['id'],
      LedgerName: map['LedgerName'],
      LedgerID: map['LedgerID'],
      OurBankId: map['OurBankId'],
      BankID: map['BankID'],
      BankName: map['BankName'],
      TransactionType: map['TransactionType'],
      ChequeNo: map['ChequeNo'],
      VoucherID: map['VoucherID'],
      VoucherType: map['VoucherType'],
      VoucherPrefix: map['VoucherPrefix'],
      IssuedOn: map['IssuedOn'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['IssuedOn'])
          : null,
      Branch: map['Branch'],
      IFSC: map['IFSC'],
      InstrumentDate: map['InstrumentDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['InstrumentDate'])
          : null,
      RefNumber: map['RefNumber'],
      reconciled: map['reconciled'],
      reconciledDate: map['reconciledDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['reconciledDate'])
          : null,
      isPresented: map['isPresented'],
      presentedOn: map['presentedOn'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['presentedOn'])
          : null,
      isCleared: map['isCleared'],
      clearedOn: map['clearedOn'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['clearedOn'])
          : null,
      isRejected: map['isRejected'],
      Narration: map['Narration'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChequeDetailModel.fromJson(String source) =>
      ChequeDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChequeDetailModel(id: $id, LedgerName: $LedgerName, LedgerID: $LedgerID, OurBankId: $OurBankId, BankID: $BankID, BankName: $BankName, TransactionType: $TransactionType, ChequeNo: $ChequeNo, VoucherID: $VoucherID, VoucherType: $VoucherType, VoucherPrefix: $VoucherPrefix, IssuedOn: $IssuedOn, Branch: $Branch, IFSC: $IFSC, InstrumentDate: $InstrumentDate, RefNumber: $RefNumber, reconciled: $reconciled, reconciledDate: $reconciledDate, isPresented: $isPresented, presentedOn: $presentedOn, isCleared: $isCleared, clearedOn: $clearedOn, isRejected: $isRejected, Narration: $Narration)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      LedgerName,
      LedgerID,
      OurBankId,
      BankID,
      BankName,
      TransactionType,
      ChequeNo,
      VoucherID,
      VoucherType,
      VoucherPrefix,
      IssuedOn,
      Branch,
      IFSC,
      InstrumentDate,
      RefNumber,
      reconciled,
      reconciledDate,
      isPresented,
      presentedOn,
      isCleared,
      clearedOn,
      isRejected,
      Narration,
    ];
  }
}
