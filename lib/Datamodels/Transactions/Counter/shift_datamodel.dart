import 'dart:convert';

import 'package:equatable/equatable.dart';

class ShiftDataModel extends Equatable {
  final String? voucherPrefix;
  final String? billsFrom;
  final String? billsTo;
  final int? billsCount;
  final DateTime? shiftStartfinalDateTime;
  final DateTime? shiftEndfinalDateTime;

  final int? cashierID;
  final String? cashierName;
  final DateTime? shiftDate;

  final double? openingCash;
  final double? salesTotal;

  final double? cashInCounter;

  final double? cashWithDrawn;

  final double? taxTotal;
  final double? taxableTotal;
  final double? cashSales;
  final double? cardSales;
  final double? creditSales;
  final double? purchaseTotal;
  final double? cashPurchase;
  final double? cardPurchase;
  final double? creditPurchase;
  final double? receiptTotal;
  final double? cashReceipts;
  final double? cardReceipts;
  final double? paymentTotal;
  final double? cashPayments;
  final double? cardPayments;
  final double? purchaseReturnTotal;
  final double? cashPurchaseReturn;
  final double? salesReturnTotal;
  final double? cashSalesReturn;
  final double? totalCash;
  final double? tillDifference;
  final double? cashBalance;

  final String? narration;
  const ShiftDataModel({
    this.voucherPrefix,
    this.billsFrom,
    this.billsTo,
    this.billsCount,
    this.shiftStartfinalDateTime,
    this.shiftEndfinalDateTime,
    this.cashierID,
    this.cashierName,
    this.shiftDate,
    this.openingCash,
    this.salesTotal,
    this.cashInCounter,
    this.cashWithDrawn,
    this.taxTotal,
    this.taxableTotal,
    this.cashSales,
    this.cardSales,
    this.creditSales,
    this.purchaseTotal,
    this.cashPurchase,
    this.cardPurchase,
    this.creditPurchase,
    this.receiptTotal,
    this.cashReceipts,
    this.cardReceipts,
    this.paymentTotal,
    this.cashPayments,
    this.cardPayments,
    this.purchaseReturnTotal,
    this.cashPurchaseReturn,
    this.salesReturnTotal,
    this.cashSalesReturn,
    this.totalCash,
    this.tillDifference,
    this.cashBalance,
    this.narration,
  });

  ShiftDataModel copyWith({
    String? voucherPrefix,
    String? billsFrom,
    String? billsTo,
    int? billsCount,
    DateTime? shiftStartfinalDateTime,
    DateTime? shiftEndfinalDateTime,
    int? cashierID,
    String? cashierName,
    DateTime? shiftDate,
    double? openingCash,
    double? salesTotal,
    double? cashInCounter,
    double? cashWithDrawn,
    double? taxTotal,
    double? taxableTotal,
    double? cashSales,
    double? cardSales,
    double? creditSales,
    double? purchaseTotal,
    double? cashPurchase,
    double? cardPurchase,
    double? creditPurchase,
    double? receiptTotal,
    double? cashReceipts,
    double? cardReceipts,
    double? paymentTotal,
    double? cashPayments,
    double? cardPayments,
    double? purchaseReturnTotal,
    double? cashPurchaseReturn,
    double? salesReturnTotal,
    double? cashSalesReturn,
    double? totalCash,
    double? tillDifference,
    double? cashBalance,
    String? narration,
  }) {
    return ShiftDataModel(
      voucherPrefix: voucherPrefix ?? this.voucherPrefix,
      billsFrom: billsFrom ?? this.billsFrom,
      billsTo: billsTo ?? this.billsTo,
      billsCount: billsCount ?? this.billsCount,
      shiftStartfinalDateTime:
          shiftStartfinalDateTime ?? this.shiftStartfinalDateTime,
      shiftEndfinalDateTime:
          shiftEndfinalDateTime ?? this.shiftEndfinalDateTime,
      cashierID: cashierID ?? this.cashierID,
      cashierName: cashierName ?? this.cashierName,
      shiftDate: shiftDate ?? this.shiftDate,
      openingCash: openingCash ?? this.openingCash,
      salesTotal: salesTotal ?? this.salesTotal,
      cashInCounter: cashInCounter ?? this.cashInCounter,
      cashWithDrawn: cashWithDrawn ?? this.cashWithDrawn,
      taxTotal: taxTotal ?? this.taxTotal,
      taxableTotal: taxableTotal ?? this.taxableTotal,
      cashSales: cashSales ?? this.cashSales,
      cardSales: cardSales ?? this.cardSales,
      creditSales: creditSales ?? this.creditSales,
      purchaseTotal: purchaseTotal ?? this.purchaseTotal,
      cashPurchase: cashPurchase ?? this.cashPurchase,
      cardPurchase: cardPurchase ?? this.cardPurchase,
      creditPurchase: creditPurchase ?? this.creditPurchase,
      receiptTotal: receiptTotal ?? this.receiptTotal,
      cashReceipts: cashReceipts ?? this.cashReceipts,
      cardReceipts: cardReceipts ?? this.cardReceipts,
      paymentTotal: paymentTotal ?? this.paymentTotal,
      cashPayments: cashPayments ?? this.cashPayments,
      cardPayments: cardPayments ?? this.cardPayments,
      purchaseReturnTotal: purchaseReturnTotal ?? this.purchaseReturnTotal,
      cashPurchaseReturn: cashPurchaseReturn ?? this.cashPurchaseReturn,
      salesReturnTotal: salesReturnTotal ?? this.salesReturnTotal,
      cashSalesReturn: cashSalesReturn ?? this.cashSalesReturn,
      totalCash: totalCash ?? this.totalCash,
      tillDifference: tillDifference ?? this.tillDifference,
      cashBalance: cashBalance ?? this.cashBalance,
      narration: narration ?? this.narration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'VoucherPrefix': voucherPrefix,
      'BillsFrom': billsFrom,
      'BillsTo': billsTo,
      'BillsCount': billsCount,
      'ShiftStartDateTime': shiftStartfinalDateTime?.millisecondsSinceEpoch,
      'ShiftEndDateTime': shiftEndfinalDateTime?.millisecondsSinceEpoch,
      'cashierID': cashierID,
      'cashierName': cashierName,
      'shiftDate': shiftDate?.millisecondsSinceEpoch,
      'OpeningCash': openingCash,
      'SalesTotal': salesTotal,
      'CashInCounter': cashInCounter,
      'CashWithDrawn': cashWithDrawn,
      'vatTotal': taxTotal,
      'taxableTotal': taxableTotal,
      'CashSales': cashSales,
      'CardSales': cardSales,
      'CreditSales': creditSales,
      'PurchaseTotal': purchaseTotal,
      'CashPurchase': cashPurchase,
      'CardPurchase': cardPurchase,
      'CreditPurchase': creditPurchase,
      'ReceiptTotal': receiptTotal,
      'CashReceipts': cashReceipts,
      'CardReceipts': cardReceipts,
      'PaymentTotal': paymentTotal,
      'CashPayments': cashPayments,
      'CardPayments': cardPayments,
      'PurchaseReturnTotal': purchaseReturnTotal,
      'CashPurchaseReturn': cashPurchaseReturn,
      'SalesReturnTotal': salesReturnTotal,
      'CashSalesReturn': cashSalesReturn,
      'totalCash': totalCash,
      'TillDifference': tillDifference,
      'CashBalance': cashBalance,
      'Narration': narration,
    };
  }

  factory ShiftDataModel.fromMap(Map<String, dynamic> map) {
    // map.printTypes();
    final model = ShiftDataModel(
      voucherPrefix: map['VoucherPrefix'],
      billsFrom: map['BillsFrom'].toString(),
      billsTo: map['BillsTo'].toString(),
      billsCount: (map['BillsTo'] - map['BillsFrom']),
      shiftStartfinalDateTime: map['ShiftStartDateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['ShiftStartDateTime'])
          : null,
      shiftEndfinalDateTime: map['ShiftEndDateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['ShiftEndDateTime'])
          : null,
      // cashierID: int.tryParse(map['cashierID']) ?? null,
      // cashierName: map['cashierName'],
      // shiftDate: map['shiftDate'] != null
      //     ? DateTime.fromMillisecondsSinceEpoch(map['shiftDate'])
      //     : null,
      openingCash: double.parse(map['OpeningCash'] ?? '0'),
      salesTotal: double.parse(map['SalesTotal'] ?? '0'),
      //cashInCounter: double.parse(map['CashInCounter'] ?? '0'),
      //cashWithDrawn: double.parse(map['CashWithDrawn'] ?? '0'),
      taxTotal: double.parse(map['vatTotal'] ?? '0'),
      taxableTotal: map['taxableTotal'] ?? 0,
      cashSales: double.parse(map['CashSales'] ?? '0'),
      cardSales: double.parse(map['CardSales'] ?? '0'),
      creditSales: double.parse(map['CreditSales'] ?? '0'),
      purchaseTotal: double.parse(map['PurchaseTotal'] ?? '0'),
      cashPurchase: double.parse(map['CashPurchase'] ?? '0'),
      cardPurchase: double.parse(map['CardPurchase'] ?? '0'),
      creditPurchase: double.parse(map['CreditPurchase'] ?? '0'),
      receiptTotal: double.parse(map['ReceiptTotal'] ?? '0'),
      cashReceipts: double.parse(map['CashReceipts'] ?? '0'),
      cardReceipts: double.parse(map['CardReceipts'] ?? '0'),
      paymentTotal: double.parse(map['PaymentTotal'] ?? '0'),
      cashPayments: double.parse(map['CashPayments'] ?? '0'),
      cardPayments: double.parse(map['CardPayments'] ?? '0'),
      purchaseReturnTotal: double.parse(map['PurchaseReturnTotal'] ?? '0'),
      cashPurchaseReturn: double.parse(map['CashPurchaseReturn'] ?? '0'),
      salesReturnTotal: double.parse(map['SalesReturnTotal'] ?? '0'),
      cashSalesReturn: double.parse(map['CashSalesReturn'] ?? '0'),
      totalCash: double.parse(map['totalCash']?.toString() ?? '0'),
      tillDifference: double.parse(map['TillDifference']?.toString() ?? '0'),
      cashBalance: double.parse(map['CashBalance']?.toString() ?? '0'),
      narration: map['narration'] ?? '',
    );

    return model;
  }

  ShiftDataModel calculateShift() {
    return copyWith(
      totalCash: (openingCash ?? 0) +
          (cashSales ?? 0) +
          (cashReceipts ?? 0) -
          (cashPayments ?? 0) -
          (cashPurchase ?? 0),
    )
      ..copyWith(
        tillDifference: (cashInCounter ?? 0) - (totalCash ?? 0),
      )
      ..copyWith(cashBalance: (cashInCounter ?? 0) - (cashWithDrawn ?? 0));
  }

  String toJson() => json.encode(toMap());

  factory ShiftDataModel.fromJson(String source) =>
      ShiftDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShiftDataModel(voucherPrefix: $voucherPrefix, billsFrom: $billsFrom, billsTo: $billsTo, billsCount: $billsCount, shiftStartfinalDateTime: $shiftStartfinalDateTime, shiftEndfinalDateTime: $shiftEndfinalDateTime, cashierID: $cashierID, cashierName: $cashierName, shiftDate: $shiftDate, openingCash: $openingCash, salesTotal: $salesTotal, cashInCounter: $cashInCounter, cashWithDrawn: $cashWithDrawn, taxTotal: $taxTotal, taxableTotal: $taxableTotal, cashSales: $cashSales, cardSales: $cardSales, creditSales: $creditSales, purchaseTotal: $purchaseTotal, cashPurchase: $cashPurchase, cardPurchase: $cardPurchase, creditPurchase: $creditPurchase, receiptTotal: $receiptTotal, cashReceipts: $cashReceipts, cardReceipts: $cardReceipts, paymentTotal: $paymentTotal, cashPayments: $cashPayments, cardPayments: $cardPayments, purchaseReturnTotal: $purchaseReturnTotal, cashPurchaseReturn: $cashPurchaseReturn, salesReturnTotal: $salesReturnTotal, cashSalesReturn: $cashSalesReturn, totalCash: $totalCash, tillDifference: $tillDifference, cashBalance: $cashBalance, narration: $narration)';
  }

  @override
  List<Object?> get props {
    return [
      voucherPrefix,
      billsFrom,
      billsTo,
      billsCount,
      shiftStartfinalDateTime,
      shiftEndfinalDateTime,
      cashierID,
      cashierName,
      shiftDate,
      openingCash,
      salesTotal,
      cashInCounter,
      cashWithDrawn,
      taxTotal,
      taxableTotal,
      cashSales,
      cardSales,
      creditSales,
      purchaseTotal,
      cashPurchase,
      cardPurchase,
      creditPurchase,
      receiptTotal,
      cashReceipts,
      cardReceipts,
      paymentTotal,
      cashPayments,
      cardPayments,
      purchaseReturnTotal,
      cashPurchaseReturn,
      salesReturnTotal,
      cashSalesReturn,
      totalCash,
      tillDifference,
      cashBalance,
      narration,
    ];
  }
}
