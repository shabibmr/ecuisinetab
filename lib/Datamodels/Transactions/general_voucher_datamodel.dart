import 'dart:convert';

import '../../Utils/voucher_types.dart';
import 'package:equatable/equatable.dart';

import '../Masters/Accounts/LedgerMasterDataModel.dart';
import '../Masters/Accounts/billwise_records_datamodel.dart';
import '../HiveModels/address_book/contacts_data_model.dart';
import '../Masters/Inventory/CompoundItemDataModel.dart';
import '../Masters/Inventory/InventoryItemDataModel.dart';
import 'cheque_detail_datamodel.dart';
import 'shipping_details_datamodel.dart';

import '../../Utils/extensions/double_extension.dart';

enum SaveStatus {
  ready,
  reading,
  readComplete,
  saving,
  saved,
  saveerror,
}

class GeneralVoucherDataModel extends Equatable {
  final String? DisplayVoucherNumber;
  final String? voucherNumber;
  final DateTime? VoucherDate;
  final String? VoucherPrefix;
  final String? invoiceNumber;
  final DateTime? invoiceDate;
  final DateTime? DateCreated;
  final DateTime? timestamp;
  final DateTime? lastEditedDateTime;
  final LedgerMasterDataModel? ledgerObject;
  final List<CompoundItemDataModel>? InventoryItems;
  final List<InventoryItemDataModel>? deletedItems;
  final List<LedgerMasterDataModel> ledgersList;
  final String? narration;
  final int? priceListId;
  final String? priceListName;

  final double? discount;
  final double? discountPercent;

  final double? subTotal;
  final double? grossTotal;
  double? discountinAmount;
  double? grandTotal;
  double? taxTotalAmount;
  final double? otherLedgersTotal;
  double? cessAmount;

  final double? currencyConversionRate;
  final String? currency;
  final String? ProjectId;
  final String? AddedBy;
  final int? AddedById;
  final int? packedBy;
  final DateTime? DeliveryDate;
  final DateTime? DeliveryTime;
  final double? CompletionProbability;
  final int? CreditPeriod;

  final DateTime? completedTimeStamp;

  final int? RevisionNo;
  final String? ConvertedToSalesOrder;
  final bool? QuotationPrepared;
  final bool? QuotationDropped;
  final String? QuotationDroppedReason;
  final int? SalesmanID;
  final String? TermsAndConditionsID;
  final String? RequirementVoucherNo;
  final ContactsDataModel? Contact;
  final String? LPO;
  final String? BillingName;

  final String? prevTransVouchers;
  double? roundOff;

  final int? status;

  final String? voucherType;

  final bool? isIGST;

  final bool? ManagerApprovalStatus;
  final bool? ClientApprovalStatus;

  //    final int? Pax;  // changed to numBoxes
  final int? NoOfCopies;
  final int? ModeOfService;

  double? quantityTotal;

  double? BalanceAmount;
  final double? PaidAmount;

  final String? reference;
  final String? Location;
  final String? POCName;
  final String? POCEmail;
  final String? POCPhone;
  final String? kotNumber;

  final bool? BillSplit;
  final bool? paymentSplit;

  final double? advanceCash;

  final double? balance;

  final String? fromGodownName;
  final String? toGodownName;
  final String? fromGodownID;
  final String? toGodownID;
  final List<BillwiseMappingModel>? mapList;
  final ChequeDetailModel? chequeEntry;
  final bool? isReconciled;
  final DateTime? reconciledOn;

  double? crTotal;
  double? drTotal;
  double? ledgersTotal;
  final bool? fromExternal;
  final bool? sendFlag;
  final bool? voucherToExport;
  final String? TransactionId;

  final int? action;

  final DateTime? CustomerExpectingDate;

  final List<String>? HashTags;

  final LedgerMasterDataModel? purchaseLedger;

  // NOT DONE
  final String? LRNO;
  final int? numBoxes;
  double? totalWeight = 0;
  final int? Origin;
  final String? Currency;
  final double? CurrencyConvRate;
  final int? currencyDecimalPoint;

  final bool? isCoupled;
  final ShippingDetailDataModel? shippingInfo;
  final SaveStatus saveStatus;

  final bool? requestPrint;

  GeneralVoucherDataModel({
    this.DisplayVoucherNumber,
    this.voucherNumber,
    this.VoucherDate,
    this.VoucherPrefix,
    this.invoiceNumber,
    this.invoiceDate,
    this.DateCreated,
    this.timestamp,
    this.lastEditedDateTime,
    this.ledgerObject,
    this.InventoryItems,
    this.deletedItems,
    required this.ledgersList,
    this.narration,
    this.priceListId,
    this.priceListName,
    this.discount,
    this.discountPercent,
    this.subTotal = 0,
    this.grossTotal = 0,
    this.discountinAmount = 0,
    this.grandTotal = 0,
    this.taxTotalAmount = 0,
    this.otherLedgersTotal = 0,
    this.cessAmount = 0,
    this.currencyConversionRate = 1,
    this.currency,
    this.ProjectId,
    this.AddedBy,
    this.AddedById,
    this.packedBy,
    this.DeliveryDate,
    this.DeliveryTime,
    this.CompletionProbability,
    this.CreditPeriod,
    this.completedTimeStamp,
    this.RevisionNo,
    this.ConvertedToSalesOrder,
    this.QuotationPrepared,
    this.QuotationDropped,
    this.QuotationDroppedReason,
    this.SalesmanID,
    this.TermsAndConditionsID,
    this.RequirementVoucherNo,
    this.Contact,
    this.LPO,
    this.BillingName,
    this.prevTransVouchers,
    this.roundOff,
    this.status,
    this.voucherType,
    this.isIGST,
    this.ManagerApprovalStatus,
    this.ClientApprovalStatus,
    this.NoOfCopies,
    this.ModeOfService,
    this.quantityTotal = 0,
    this.BalanceAmount = 0,
    this.PaidAmount = 0,
    this.reference,
    this.Location,
    this.POCName,
    this.POCEmail,
    this.POCPhone,
    this.kotNumber,
    this.BillSplit,
    this.paymentSplit,
    this.advanceCash,
    this.balance,
    this.fromGodownName,
    this.toGodownName,
    this.fromGodownID,
    this.toGodownID,
    this.mapList,
    this.chequeEntry,
    this.isReconciled,
    this.reconciledOn,
    this.crTotal = 0,
    this.drTotal = 0,
    this.ledgersTotal,
    this.fromExternal,
    this.sendFlag,
    this.voucherToExport,
    this.TransactionId,
    this.action,
    this.CustomerExpectingDate,
    this.HashTags,
    this.purchaseLedger,
    this.LRNO,
    this.numBoxes = 0,
    this.totalWeight = 0,
    this.Origin,
    this.Currency,
    this.CurrencyConvRate,
    this.currencyDecimalPoint,
    this.isCoupled,
    this.shippingInfo,
    this.saveStatus = SaveStatus.ready,
    this.requestPrint,
  });

  GeneralVoucherDataModel copyWith({
    String? DisplayVoucherNumber,
    String? voucherNumber,
    DateTime? VoucherDate,
    String? VoucherPrefix,
    String? invoiceNumber,
    DateTime? invoiceDate,
    DateTime? DateCreated,
    DateTime? timestamp,
    DateTime? lastEditedDateTime,
    LedgerMasterDataModel? ledgerObject,
    List<CompoundItemDataModel>? InventoryItems,
    List<InventoryItemDataModel>? deletedItems,
    List<LedgerMasterDataModel>? ledgersList,
    String? narration,
    int? priceListId,
    String? priceListName,
    double? discount,
    double? discountPercent,
    double? subTotal,
    double? grossTotal,
    double? discountinAmount,
    double? grandTotal,
    double? taxTotalAmount,
    double? otherLedgersTotal,
    double? cessAmount,
    double? currencyConversionRate,
    String? currency,
    String? ProjectId,
    String? AddedBy,
    int? AddedById,
    int? packedBy,
    DateTime? DeliveryDate,
    DateTime? DeliveryTime,
    double? CompletionProbability,
    int? CreditPeriod,
    DateTime? completedTimeStamp,
    int? RevisionNo,
    String? ConvertedToSalesOrder,
    bool? QuotationPrepared,
    bool? QuotationDropped,
    String? QuotationDroppedReason,
    int? SalesmanID,
    String? TermsAndConditionsID,
    String? RequirementVoucherNo,
    ContactsDataModel? Contact,
    String? LPO,
    String? BillingName,
    String? prevTransVouchers,
    double? roundOff,
    int? status,
    String? voucherType,
    bool? isIGST,
    bool? ManagerApprovalStatus,
    bool? ClientApprovalStatus,
    int? NoOfCopies,
    int? ModeOfService,
    double? quantityTotal,
    double? BalanceAmount,
    double? PaidAmount,
    String? reference,
    String? Location,
    String? POCName,
    String? POCEmail,
    String? POCPhone,
    String? kotNumber,
    bool? BillSplit,
    bool? paymentSplit,
    double? advanceCash,
    double? balance,
    String? fromGodownName,
    String? toGodownName,
    String? fromGodownID,
    String? toGodownID,
    List<BillwiseMappingModel>? mapList,
    ChequeDetailModel? chequeEntry,
    bool? isReconciled,
    DateTime? reconciledOn,
    double? crTotal,
    double? drTotal,
    double? ledgersTotal,
    bool? fromExternal,
    bool? sendFlag,
    bool? voucherToExport,
    String? TransactionId,
    int? action,
    DateTime? CustomerExpectingDate,
    List<String>? HashTags,
    LedgerMasterDataModel? purchaseLedger,
    String? LRNO,
    int? numBoxes,
    double? totalWeight,
    int? Origin,
    String? Currency,
    double? CurrencyConvRate,
    int? currencyDecimalPoint,
    bool? isCoupled,
    ShippingDetailDataModel? shippingInfo,
    SaveStatus? saveStatus,
    bool? requestPrint,
  }) {
    return GeneralVoucherDataModel(
      DisplayVoucherNumber: DisplayVoucherNumber ?? this.DisplayVoucherNumber,
      voucherNumber: voucherNumber ?? this.voucherNumber,
      VoucherDate: VoucherDate ?? this.VoucherDate,
      VoucherPrefix: VoucherPrefix ?? this.VoucherPrefix,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      DateCreated: DateCreated ?? this.DateCreated,
      timestamp: timestamp ?? this.timestamp,
      lastEditedDateTime: lastEditedDateTime ?? this.lastEditedDateTime,
      ledgerObject: ledgerObject ?? this.ledgerObject,
      InventoryItems: InventoryItems ?? this.InventoryItems,
      deletedItems: deletedItems ?? this.deletedItems,
      ledgersList: ledgersList ?? this.ledgersList,
      narration: narration ?? this.narration,
      priceListId: priceListId ?? this.priceListId,
      priceListName: priceListName ?? this.priceListName,
      discount: discount ?? this.discount,
      discountPercent: discountPercent ?? this.discountPercent,
      subTotal: subTotal ?? this.subTotal,
      grossTotal: grossTotal ?? this.grossTotal,
      discountinAmount: discountinAmount ?? this.discountinAmount,
      grandTotal: grandTotal ?? this.grandTotal,
      taxTotalAmount: taxTotalAmount ?? this.taxTotalAmount,
      otherLedgersTotal: otherLedgersTotal ?? this.otherLedgersTotal,
      cessAmount: cessAmount ?? this.cessAmount,
      currencyConversionRate:
          currencyConversionRate ?? this.currencyConversionRate,
      currency: currency ?? this.currency,
      ProjectId: ProjectId ?? this.ProjectId,
      AddedBy: AddedBy ?? this.AddedBy,
      AddedById: AddedById ?? this.AddedById,
      packedBy: packedBy ?? this.packedBy,
      DeliveryDate: DeliveryDate ?? this.DeliveryDate,
      DeliveryTime: DeliveryTime ?? this.DeliveryTime,
      CompletionProbability:
          CompletionProbability ?? this.CompletionProbability,
      CreditPeriod: CreditPeriod ?? this.CreditPeriod,
      completedTimeStamp: completedTimeStamp ?? this.completedTimeStamp,
      RevisionNo: RevisionNo ?? this.RevisionNo,
      ConvertedToSalesOrder:
          ConvertedToSalesOrder ?? this.ConvertedToSalesOrder,
      QuotationPrepared: QuotationPrepared ?? this.QuotationPrepared,
      QuotationDropped: QuotationDropped ?? this.QuotationDropped,
      QuotationDroppedReason:
          QuotationDroppedReason ?? this.QuotationDroppedReason,
      SalesmanID: SalesmanID ?? this.SalesmanID,
      TermsAndConditionsID: TermsAndConditionsID ?? this.TermsAndConditionsID,
      RequirementVoucherNo: RequirementVoucherNo ?? this.RequirementVoucherNo,
      Contact: Contact ?? this.Contact,
      LPO: LPO ?? this.LPO,
      BillingName: BillingName ?? this.BillingName,
      prevTransVouchers: prevTransVouchers ?? this.prevTransVouchers,
      roundOff: roundOff ?? this.roundOff,
      status: status ?? this.status,
      voucherType: voucherType ?? this.voucherType,
      isIGST: isIGST ?? this.isIGST,
      ManagerApprovalStatus:
          ManagerApprovalStatus ?? this.ManagerApprovalStatus,
      ClientApprovalStatus: ClientApprovalStatus ?? this.ClientApprovalStatus,
      NoOfCopies: NoOfCopies ?? this.NoOfCopies,
      ModeOfService: ModeOfService ?? this.ModeOfService,
      quantityTotal: quantityTotal ?? this.quantityTotal,
      BalanceAmount: BalanceAmount ?? this.BalanceAmount,
      PaidAmount: PaidAmount ?? this.PaidAmount,
      reference: reference ?? this.reference,
      Location: Location ?? this.Location,
      POCName: POCName ?? this.POCName,
      POCEmail: POCEmail ?? this.POCEmail,
      POCPhone: POCPhone ?? this.POCPhone,
      kotNumber: kotNumber ?? this.kotNumber,
      BillSplit: BillSplit ?? this.BillSplit,
      paymentSplit: paymentSplit ?? this.paymentSplit,
      advanceCash: advanceCash ?? this.advanceCash,
      balance: balance ?? this.balance,
      fromGodownName: fromGodownName ?? this.fromGodownName,
      toGodownName: toGodownName ?? this.toGodownName,
      fromGodownID: fromGodownID ?? this.fromGodownID,
      toGodownID: toGodownID ?? this.toGodownID,
      mapList: mapList ?? this.mapList,
      chequeEntry: chequeEntry ?? this.chequeEntry,
      isReconciled: isReconciled ?? this.isReconciled,
      reconciledOn: reconciledOn ?? this.reconciledOn,
      crTotal: crTotal ?? this.crTotal,
      drTotal: drTotal ?? this.drTotal,
      ledgersTotal: ledgersTotal ?? this.ledgersTotal,
      fromExternal: fromExternal ?? this.fromExternal,
      sendFlag: sendFlag ?? this.sendFlag,
      voucherToExport: voucherToExport ?? this.voucherToExport,
      TransactionId: TransactionId ?? this.TransactionId,
      action: action ?? this.action,
      CustomerExpectingDate:
          CustomerExpectingDate ?? this.CustomerExpectingDate,
      HashTags: HashTags ?? this.HashTags,
      purchaseLedger: purchaseLedger ?? this.purchaseLedger,
      LRNO: LRNO ?? this.LRNO,
      numBoxes: numBoxes ?? this.numBoxes,
      totalWeight: totalWeight ?? this.totalWeight,
      Origin: Origin ?? this.Origin,
      Currency: Currency ?? this.Currency,
      CurrencyConvRate: CurrencyConvRate ?? this.CurrencyConvRate,
      currencyDecimalPoint: currencyDecimalPoint ?? this.currencyDecimalPoint,
      isCoupled: isCoupled ?? this.isCoupled,
      shippingInfo: shippingInfo ?? this.shippingInfo,
      saveStatus: saveStatus ?? this.saveStatus,
      requestPrint: requestPrint ?? this.requestPrint,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'DisplayVoucherNumber': DisplayVoucherNumber,
      'voucherNumber': voucherNumber,
      'VoucherDate': VoucherDate?.millisecondsSinceEpoch,
      'VoucherPrefix': VoucherPrefix,
      'invoiceNumber': invoiceNumber,
      'invoiceDate': invoiceDate?.millisecondsSinceEpoch,
      'DateCreated': DateCreated?.millisecondsSinceEpoch,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'lastEditedDateTime': lastEditedDateTime?.millisecondsSinceEpoch,
      'ledgerObject': ledgerObject?.toMap(),
      'InventoryItems': InventoryItems?.map((x) => x.toMap()).toList(),
      'deletedItems': deletedItems?.map((x) => x.toMap()).toList(),
      'ledgersList': ledgersList.map((x) => x.toMap()).toList(),
      'narration': narration,
      'priceListId': priceListId,
      'priceListName': priceListName,
      'discount': discount,
      'discountPercent': discountPercent,
      'subTotal': subTotal,
      'grossTotal': grossTotal,
      'discountinAmount': discountinAmount,
      'grandTotal': grandTotal,
      'taxTotalAmount': taxTotalAmount,
      'otherLedgersTotal': otherLedgersTotal,
      'cessAmount': cessAmount,
      'currencyConversionRate': currencyConversionRate,
      'currency': currency,
      'ProjectId': ProjectId,
      'AddedBy': AddedBy,
      'AddedById': AddedById,
      'packedBy': packedBy,
      'DeliveryDate': DeliveryDate?.millisecondsSinceEpoch,
      'DeliveryTime': DeliveryTime?.millisecondsSinceEpoch,
      'CompletionProbability': CompletionProbability,
      'CreditPeriod': CreditPeriod,
      'completedTimeStamp': completedTimeStamp?.millisecondsSinceEpoch,
      'RevisionNo': RevisionNo,
      'ConvertedToSalesOrder': ConvertedToSalesOrder,
      'QuotationPrepared': QuotationPrepared,
      'QuotationDropped': QuotationDropped,
      'QuotationDroppedReason': QuotationDroppedReason,
      'SalesmanID': SalesmanID,
      'TermsAndConditionsID': TermsAndConditionsID,
      'RequirementVoucherNo': RequirementVoucherNo,
      'Contact': Contact?.toMap(),
      'LPO': LPO,
      'BillingName': BillingName,
      'prevTransVouchers': prevTransVouchers,
      'roundOff': roundOff,
      'status': status,
      'voucherType': voucherType,
      'isIGST': isIGST,
      'ManagerApprovalStatus': ManagerApprovalStatus,
      'ClientApprovalStatus': ClientApprovalStatus,
      'NoOfCopies': NoOfCopies,
      'ModeOfService': ModeOfService,
      'quantityTotal': quantityTotal,
      'BalanceAmount': BalanceAmount,
      'PaidAmount': PaidAmount,
      'reference': reference,
      'Location': Location,
      'POCName': POCName,
      'POCEmail': POCEmail,
      'POCPhone': POCPhone,
      'kotNumber': kotNumber,
      'BillSplit': BillSplit,
      'paymentSplit': paymentSplit,
      'advanceCash': advanceCash,
      'balance': balance,
      'fromGodownName': fromGodownName,
      'toGodownName': toGodownName,
      'fromGodownID': fromGodownID,
      'toGodownID': toGodownID,
      'mapList': mapList?.map((x) => x.toMap()).toList(),
      'chequeEntry': chequeEntry?.toMap(),
      'isReconciled': isReconciled,
      'reconciledOn': reconciledOn?.millisecondsSinceEpoch,
      'crTotal': crTotal,
      'drTotal': drTotal,
      'ledgersTotal': ledgersTotal,
      'fromExternal': fromExternal,
      'sendFlag': sendFlag,
      'voucherToExport': voucherToExport,
      'TransactionId': TransactionId,
      'action': action,
      'CustomerExpectingDate': CustomerExpectingDate?.millisecondsSinceEpoch,
      'HashTags': HashTags,
      'purchaseLedger': purchaseLedger?.toMap(),
      'LRNO': LRNO,
      'numBoxes': numBoxes,
      'totalWeight': totalWeight,
      'Origin': Origin,
      'Currency': Currency,
      'CurrencyConvRate': CurrencyConvRate,
      'currencyDecimalPoint': currencyDecimalPoint,
      'isCoupled': isCoupled,
      'shippingInfo': shippingInfo?.toMap(),
    };
  }

  factory GeneralVoucherDataModel.fromMap(Map<String, dynamic> map) {
    return GeneralVoucherDataModel(
      DisplayVoucherNumber: map['DisplayVoucherNumber'],
      voucherNumber: map['voucherNumber'],
      VoucherDate: map['VoucherDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['VoucherDate'])
          : null,
      VoucherPrefix: map['VoucherPrefix'],
      invoiceNumber: map['invoiceNumber'],
      invoiceDate: map['invoiceDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['invoiceDate'])
          : null,
      DateCreated: map['DateCreated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['DateCreated'])
          : null,
      timestamp: map['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'])
          : null,
      lastEditedDateTime: map['lastEditedDateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastEditedDateTime'])
          : null,
      ledgerObject: map['ledgerObject'] != null
          ? LedgerMasterDataModel.fromMap(map['ledgerObject'])
          : null,
      InventoryItems: map['InventoryItems'] != null
          ? List<CompoundItemDataModel>.from(map['InventoryItems']
              ?.map((x) => CompoundItemDataModel.fromMapForTransTest(x)))
          : null,
      deletedItems: map['deletedItems'] != null
          ? List<InventoryItemDataModel>.from(map['deletedItems']
              ?.map((x) => InventoryItemDataModel.fromMapForTransTest(x)))
          : null,
      ledgersList: map['ledgersList'] != null
          ? List<LedgerMasterDataModel>.from(
              map['ledgersList']?.map((x) => LedgerMasterDataModel.fromMap(x)))
          : [],
      narration: map['narration'],
      priceListId: map['priceListId'],
      priceListName: map['priceListName'],
      discount: map['discount']?.toDouble(),
      discountPercent: map['discountPercent']?.toDouble(),
      subTotal: map['subTotal']?.toDouble(),
      grossTotal: map['grossTotal']?.toDouble(),
      discountinAmount: map['discountinAmount']?.toDouble(),
      grandTotal: map['grandTotal']?.toDouble(),
      taxTotalAmount: map['taxTotalAmount']?.toDouble(),
      otherLedgersTotal: map['otherLedgersTotal']?.toDouble(),
      cessAmount: map['cessAmount']?.toDouble(),
      currencyConversionRate: map['currencyConversionRate']?.toDouble(),
      currency: map['currency'],
      ProjectId: map['ProjectId'],
      AddedBy: map['AddedBy'],
      AddedById: map['AddedById']?.toInt(),
      packedBy: map['packedBy']?.toInt(),
      DeliveryDate: map['DeliveryDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['DeliveryDate'])
          : null,
      DeliveryTime: map['DeliveryTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['DeliveryTime'])
          : null,
      CompletionProbability: map['CompletionProbability']?.toDouble(),
      CreditPeriod: map['CreditPeriod']?.toInt(),
      completedTimeStamp: map['completedTimeStamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['completedTimeStamp'])
          : null,
      RevisionNo: map['RevisionNo']?.toInt(),
      ConvertedToSalesOrder: map['ConvertedToSalesOrder'],
      QuotationPrepared: map['QuotationPrepared'],
      QuotationDropped: map['QuotationDropped'],
      QuotationDroppedReason: map['QuotationDroppedReason'],
      SalesmanID: map['SalesmanID'],
      TermsAndConditionsID: map['TermsAndConditionsID'],
      RequirementVoucherNo: map['RequirementVoucherNo'],
      Contact: map['Contact'] != null
          ? ContactsDataModel.fromMap(map['Contact'])
          : null,
      LPO: map['LPO'],
      BillingName: map['BillingName'],
      prevTransVouchers: map['prevTransVouchers'],
      roundOff: map['roundOff']?.toDouble(),
      status: map['status']?.toInt(),
      voucherType: map['voucherType'],
      isIGST: map['isIGST'],
      ManagerApprovalStatus: map['ManagerApprovalStatus'],
      ClientApprovalStatus: map['ClientApprovalStatus'],
      NoOfCopies: map['NoOfCopies']?.toInt(),
      ModeOfService: map['ModeOfService']?.toInt(),
      quantityTotal: map['quantityTotal']?.toDouble(),
      BalanceAmount: map['BalanceAmount']?.toDouble(),
      PaidAmount: map['PaidAmount']?.toDouble(),
      reference: map['reference'],
      Location: map['Location'],
      POCName: map['POCName'],
      POCEmail: map['POCEmail'],
      POCPhone: map['POCPhone'],
      kotNumber: map['kotNumber'],
      BillSplit: map['BillSplit'],
      paymentSplit: map['paymentSplit'],
      advanceCash: map['advanceCash']?.toDouble(),
      balance: map['balance']?.toDouble(),
      fromGodownName: map['fromGodownName'],
      toGodownName: map['toGodownName'],
      fromGodownID: map['fromGodownID'],
      toGodownID: map['toGodownID'],
      mapList: map['mapList'] != null
          ? List<BillwiseMappingModel>.from(
              map['mapList']?.map((x) => BillwiseMappingModel.fromMap(x)))
          : null,
      chequeEntry: map['chequeEntry'] != null
          ? ChequeDetailModel.fromMap(map['chequeEntry'])
          : null,
      isReconciled: map['isReconciled'],
      reconciledOn: map['reconciledOn'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['reconciledOn'])
          : null,
      crTotal: map['crTotal']?.toDouble(),
      drTotal: map['drTotal']?.toDouble(),
      ledgersTotal: map['ledgersTotal']?.toDouble(),
      fromExternal: map['fromExternal'],
      sendFlag: map['sendFlag'],
      voucherToExport: map['voucherToExport'],
      TransactionId: map['TransactionId'],
      action: map['action']?.toInt(),
      CustomerExpectingDate: map['CustomerExpectingDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['CustomerExpectingDate'])
          : null,
      HashTags: List<String>.from(map['HashTags']),
      purchaseLedger: LedgerMasterDataModel.fromMap(map['purchaseLedger']),
      LRNO: map['LRNO'],
      numBoxes: map['numBoxes']?.toInt(),
      totalWeight: map['totalWeight']?.toDouble(),
      Origin: map['Origin']?.toInt(),
      Currency: map['Currency'],
      CurrencyConvRate: map['CurrencyConvRate']?.toDouble(),
      currencyDecimalPoint: map['currencyDecimalPoint']?.toInt(),
      isCoupled: map['isCoupled'],
      shippingInfo: map['shippingInfo'] != null
          ? ShippingDetailDataModel.fromMap(map['shippingInfo'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  String toJsonTrans() => json.encode(toMapForTransTest());

  factory GeneralVoucherDataModel.fromJson(String source) =>
      GeneralVoucherDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GeneralVoucherDataModel(DisplayVoucherNumber: $DisplayVoucherNumber, voucherNumber: $voucherNumber, VoucherDate: $VoucherDate, VoucherPrefix: $VoucherPrefix, invoiceNumber: $invoiceNumber, invoiceDate: $invoiceDate, DateCreated: $DateCreated, timestamp: $timestamp, lastEditedDateTime: $lastEditedDateTime, ledgerObject: $ledgerObject, InventoryItems: $InventoryItems, deletedItems: $deletedItems, ledgersList: $ledgersList, narration: $narration, priceListId: $priceListId, priceListName: $priceListName, discount: $discount, discountPercent: $discountPercent, subTotal: $subTotal, grossTotal: $grossTotal, discountinAmount: $discountinAmount, grandTotal: $grandTotal, taxTotalAmount: $taxTotalAmount, otherLedgersTotal: $otherLedgersTotal, cessAmount: $cessAmount, currencyConversionRate: $currencyConversionRate, currency: $currency, ProjectId: $ProjectId, AddedBy: $AddedBy, AddedById: $AddedById, packedBy: $packedBy, DeliveryDate: $DeliveryDate, DeliveryTime: $DeliveryTime, CompletionProbability: $CompletionProbability, CreditPeriod: $CreditPeriod, completedTimeStamp: $completedTimeStamp, RevisionNo: $RevisionNo, ConvertedToSalesOrder: $ConvertedToSalesOrder, QuotationPrepared: $QuotationPrepared, QuotationDropped: $QuotationDropped, QuotationDroppedReason: $QuotationDroppedReason, SalesmanID: $SalesmanID, TermsAndConditionsID: $TermsAndConditionsID, RequirementVoucherNo: $RequirementVoucherNo, Contact: $Contact, LPO: $LPO, BillingName: $BillingName, prevTransVouchers: $prevTransVouchers, roundOff: $roundOff, status: $status, voucherType: $voucherType, isIGST: $isIGST, ManagerApprovalStatus: $ManagerApprovalStatus, ClientApprovalStatus: $ClientApprovalStatus, NoOfCopies: $NoOfCopies, ModeOfService: $ModeOfService, quantityTotal: $quantityTotal, BalanceAmount: $BalanceAmount, PaidAmount: $PaidAmount, reference: $reference, Location: $Location, POCName: $POCName, POCEmail: $POCEmail, POCPhone: $POCPhone, kotNumber: $kotNumber, BillSplit: $BillSplit, paymentSplit: $paymentSplit, advanceCash: $advanceCash, balance: $balance, fromGodownName: $fromGodownName, toGodownName: $toGodownName, fromGodownID: $fromGodownID, toGodownID: $toGodownID, mapList: $mapList, chequeEntry: $chequeEntry, isReconciled: $isReconciled, reconciledOn: $reconciledOn, crTotal: $crTotal, drTotal: $drTotal, ledgersTotal: $ledgersTotal, fromExternal: $fromExternal, sendFlag: $sendFlag, voucherToExport: $voucherToExport, TransactionId: $TransactionId, action: $action, CustomerExpectingDate: $CustomerExpectingDate, HashTags: $HashTags, purchaseLedger: $purchaseLedger, LRNO: $LRNO, numBoxes: $numBoxes, totalWeight: $totalWeight, Origin: $Origin, Currency: $Currency, CurrencyConvRate: $CurrencyConvRate, currencyDecimalPoint: $currencyDecimalPoint, isCoupled: $isCoupled, shippingInfo: $shippingInfo)';
  }

  @override
  List<Object?> get props {
    return [
      DisplayVoucherNumber,
      voucherNumber,
      VoucherDate,
      VoucherPrefix,
      invoiceNumber,
      invoiceDate,
      DateCreated,
      timestamp,
      lastEditedDateTime,
      ledgerObject,
      ...InventoryItems ?? [],
      ...deletedItems ?? [],
      ...ledgersList ?? [],
      narration,
      priceListId,
      priceListName,
      discount,
      discountPercent,
      subTotal,
      grossTotal,
      discountinAmount,
      grandTotal,
      taxTotalAmount,
      otherLedgersTotal,
      cessAmount,
      currencyConversionRate,
      currency,
      ProjectId,
      AddedBy,
      AddedById,
      packedBy,
      DeliveryDate,
      DeliveryTime,
      CompletionProbability,
      CreditPeriod,
      completedTimeStamp,
      RevisionNo,
      ConvertedToSalesOrder,
      QuotationPrepared,
      QuotationDropped,
      QuotationDroppedReason,
      SalesmanID,
      TermsAndConditionsID,
      RequirementVoucherNo,
      Contact,
      LPO,
      BillingName,
      prevTransVouchers,
      roundOff,
      status,
      voucherType,
      isIGST,
      ManagerApprovalStatus,
      ClientApprovalStatus,
      NoOfCopies,
      ModeOfService,
      quantityTotal,
      BalanceAmount,
      PaidAmount,
      reference,
      Location,
      POCName,
      POCEmail,
      POCPhone,
      kotNumber,
      BillSplit,
      paymentSplit,
      advanceCash,
      balance,
      fromGodownName,
      toGodownName,
      fromGodownID,
      toGodownID,
      mapList,
      chequeEntry,
      isReconciled,
      reconciledOn,
      crTotal,
      drTotal,
      ledgersTotal,
      fromExternal,
      sendFlag,
      voucherToExport,
      TransactionId,
      action,
      CustomerExpectingDate,
      HashTags,
      purchaseLedger,
      LRNO,
      numBoxes,
      totalWeight,
      Origin,
      Currency,
      CurrencyConvRate,
      currencyDecimalPoint,
      isCoupled,
      shippingInfo,
      saveStatus,
    ];
  }

  double getItemCount(String itemID) {
    double val = 0;

    for (int i = 0; i < InventoryItems!.length; i++) {
      if (itemID == InventoryItems![i].BaseItem.ItemID) {
        val += InventoryItems![i].BaseItem.quantity ?? 0;
      }
    }
    return val;
  }

  double getItemCurrCount(String itemID) {
    double val = 0;
    // print('Checking item : $itemID');
    for (int i = 0; i < InventoryItems!.length; i++) {
      // print('Prev : ${InventoryItems![i].BaseItem.prevQty}');
      if (itemID == InventoryItems![i].BaseItem.ItemID &&
          (InventoryItems![i].BaseItem.prevQty ?? 0) == 0) {
        val += (InventoryItems![i].BaseItem.quantity ?? 0);
      }
    }
    // print('Count : $val');
    return val;
  }

  void calculateVoucherSales() {
    num subTotal = 0;
    num vatTotal = 0;
    num discountTotal = 0;
    num grossTotal = 0;

    Map<String, num> LedgersListTemp = {};

    quantityTotal = 0;
    totalWeight = 0;

    bool isIGST = false;
    /*
    if(ledgerObject!.TRN!.length>2)
        if(ledgerObject!.TRN.mid(0,2) != LoginValues::getCompany().trn.mid(0,2)){
            isIGST = true;
            qDebug()<<"IGST Billing";
        }
*/
    // print('Leee');
    // print('Items length: ${InventoryItems!.length}');
    for (int i = 0; i < InventoryItems!.length; i++) {
      // num vatAmt = 0;
      num vatamtBy_2 = 0;
      // num taxRate = 0;
      // num subT = 0;
      // num grandTotolItem = 0;
      // num itemCess = 0;

      // print('w : $totalWeight  q: ${InventoryItems![i].BaseItem.quantity}');
      totalWeight = totalWeight! +
          InventoryItems![i].BaseItem.quantity! *
              InventoryItems![i].BaseItem.weight!;

      quantityTotal = quantityTotal! + InventoryItems![i].BaseItem.quantity!;
      final taxRate = InventoryItems![i].BaseItem.taxRate!;

      if (voucherType == GMVoucherTypes.SalesVoucher ||
          voucherType == GMVoucherTypes.DeliveryNote) {
        InventoryItems![i].BaseItem.crQty =
            InventoryItems![i].BaseItem.quantity;
      } else if (voucherType == GMVoucherTypes.PurchaseVoucher ||
          voucherType == GMVoucherTypes.ReceiptNote)
        InventoryItems![i].BaseItem.drQty =
            InventoryItems![i].BaseItem.quantity;

      InventoryItems![i].BaseItem.subTotal = InventoryItems![i].BaseItem.rate! *
          InventoryItems![i].BaseItem.quantity!;

      InventoryItems![i].BaseItem.grossTotal =
          InventoryItems![i].BaseItem.subTotal! -
              InventoryItems![i].BaseItem.discountinAmount!;

      InventoryItems![i].BaseItem.taxAmount =
          InventoryItems![i].BaseItem.grossTotal! *
              InventoryItems![i].BaseItem.taxRate! /
              100;

      //        subT = InventoryItems[i].BaseItem.price *InventoryItems[i].BaseItem.quantity ;
      // subT = (InventoryItems![i].BaseItem.rate!) *
      //     InventoryItems![i].BaseItem.quantity!;

      // grandTotolItem = subT - InventoryItems![i].BaseItem.discountinAmount!;

      InventoryItems![i].BaseItem.grandTotal =
          InventoryItems![i].BaseItem.grossTotal! +
              InventoryItems![i].BaseItem.taxAmount!;

      //        discountinAmount += InventoryItems[i].BaseItem.discountinAmount;

      if (taxRate >= 0) {
        // vatAmt = InventoryItems![i].BaseItem.grossTotal! * taxRate / 100;
        vatamtBy_2 = InventoryItems![i].BaseItem.grossTotal! * taxRate / 200;
        // vatAmt = num.parse(vatAmt.toStringAsFixed(2));
      }

      subTotal += InventoryItems![i].BaseItem.subTotal!;
      grossTotal += InventoryItems![i].BaseItem.grandTotal!;

      discountTotal += InventoryItems![i].BaseItem.discountinAmount!;

      String SalesLedger = "";
      String CGSTLedger = "";
      String SGSTLedger = "";
      String IGSTLedger = "";

      if (taxRate == 0) {
        SalesLedger = "0x7x3";
      } else if (taxRate == 3) {
        SalesLedger = "0x7xSV5";
        CGSTLedger = "0x2x14xOCG15";
        SGSTLedger = "0x2x14xOSG15";
        if (isIGST) IGSTLedger = "0x2x14xOIG15";
      } else if (taxRate == 5) {
        SalesLedger = "0x7xSV5";
        CGSTLedger = "0x2x14xOCG25";
        SGSTLedger = "0x2x14xOSG25";
        if (isIGST) IGSTLedger = "0x2x14xOIG25";
      } else if (taxRate == 12) {
        SalesLedger = "0x7xSV12";
        CGSTLedger = "0x2x14xOCG6";
        SGSTLedger = "0x2x14xOSG6";
        if (isIGST) IGSTLedger = "0x2x14xOIG6";
      } else if (taxRate == 18) {
        SalesLedger = "0x7xSV18";
        CGSTLedger = "0x2x14xOCG9";
        SGSTLedger = "0x2x14xOSG9";
        if (isIGST) IGSTLedger = "0x2x14xOIG9";
      } else if (taxRate == 28) {
        SalesLedger = "0x7xSV28";
        CGSTLedger = "0x2x14xOCG14";
        SGSTLedger = "0x2x14xOSG14";
        if (isIGST) IGSTLedger = "0x2x14xOIG14";
      }

      //Sales Ledgers
      if (LedgersListTemp.keys.contains(SalesLedger)) {
        LedgersListTemp[SalesLedger] = LedgersListTemp[SalesLedger]! +
            InventoryItems![i].BaseItem.grossTotal!;
      } else {
        if (SalesLedger.isNotEmpty) {
          LedgersListTemp[SalesLedger] =
              InventoryItems![i].BaseItem.grossTotal!;
        }
      }

      if (isIGST) {
        if (LedgersListTemp.keys.contains(IGSTLedger)) {
          LedgersListTemp[IGSTLedger] = LedgersListTemp[IGSTLedger]! +
              num.parse(
                  InventoryItems![i].BaseItem.taxAmount!.toStringAsFixed(2));
          vatTotal += num.parse(
              InventoryItems![i].BaseItem.taxAmount!.toStringAsFixed(2));
        } else {
          if (IGSTLedger.isNotEmpty) {
            LedgersListTemp[IGSTLedger] = num.parse(
                InventoryItems![i].BaseItem.taxAmount!.toStringAsFixed(2));
            vatTotal += num.parse(
                InventoryItems![i].BaseItem.taxAmount!.toStringAsFixed(2));
          }
        }
      } else {
        //CGST
        if (LedgersListTemp.keys.contains(CGSTLedger)) {
          LedgersListTemp[CGSTLedger] = LedgersListTemp[CGSTLedger]! +
              num.parse(vatamtBy_2.toStringAsFixed(2));
          //            qDebug()<<" Value : "<<LedgersListTemp[CGSTLedger];
          //            qDebug()<<" Value(without ) : "<<vatAmt/2;
          //            qDebug()<<" Vat/2 (without): "<<vatamtBy_2;
          //            qDebug()<<" Vat/2 : "<<String::number(vatamtBy_2,'f',2).tonum();
          vatTotal += num.parse(vatamtBy_2.toStringAsFixed(2));
        } else {
          if (CGSTLedger.isNotEmpty) {
            LedgersListTemp[CGSTLedger] =
                num.parse(vatamtBy_2.toStringAsFixed(2));
            vatTotal += num.parse(vatamtBy_2.toStringAsFixed(2));
            //                qDebug()<<" Value : "<<LedgersListTemp[CGSTLedger];
            //                qDebug()<<" Value(without ) : "<<vatAmt/2;
            //                qDebug()<<" Vat/2 (without): "<<vatamtBy_2;
            //                qDebug()<<" Vat/2 : "<<String::number(vatamtBy_2,'f',2).tonum();;
            //                qDebug()<<"grand Total Item : "<<grandTotolItem;
          }
        }

        //SGST
        if (LedgersListTemp.keys.contains(SGSTLedger)) {
          LedgersListTemp[SGSTLedger] = LedgersListTemp[SGSTLedger]! +
              num.parse(vatamtBy_2.toStringAsFixed(2));
          vatTotal += num.parse(vatamtBy_2.toStringAsFixed(2));
        } else {
          if (SGSTLedger.isNotEmpty) {
            LedgersListTemp[SGSTLedger] =
                num.parse(vatamtBy_2.toStringAsFixed(2));
            vatTotal += num.parse(vatamtBy_2.toStringAsFixed(2));
          }
        }
      }

      //        // qDebug()<<"tax amt update"<<InventoryItems[i].BaseItem.taxAmount;
      // InventoryItems![i].BaseItem.taxAmount = vatAmt.toDouble();
      //        // qDebug()<<"tax amt updated to"<<InventoryItems[i].BaseItem.taxAmount;
      // InventoryItems![i].BaseItem.grandTotal =
      //     (grandTotolItem + vatAmt).toDouble();
    }

    discountinAmount = discountTotal.toDouble();
    subTotal = subTotal;
    grossTotal = subTotal - discountinAmount!;
    taxTotalAmount = vatTotal.toDouble();

    grandTotal = grossTotal + taxTotalAmount!;

    //    // qDebug()<<"Grand Total : "<<grandTotal;

    //    if(cessTotal > 0 && ledgerObject.TRN.length()<1 ){
    //        LedgersListTemp["0x2x14xCess"] = cessAmount;
    //    }

    for (int i = 0; i < ledgersList.length; i++) {
      if (ledgersList[i].isInvoiceItem!) {
        //            qDebug()<<"removing from ledgerslist at "
        //                   <<ledgersList[i].LedgerName<<Q_FUNC_INFO;
        ledgersList.removeAt(i);
        i--;
      }
    }
    if (paymentSplit == false)
      for (int i = 0; i < ledgersList.length; i++) {
        //            // qDebug()<<" Total : "<<grandTotal << "Cr : "<<ledgersList[i].crAmount << "Dr : "<<ledgersList[i].drAmount;
        grandTotal =
            grandTotal! + ledgersList[i].crAmount! - ledgersList[i].drAmount!;
      }

    // QMapIterator<String,num>iterator(LedgersListTemp);

    for (var element in LedgersListTemp.keys) {
      var val = LedgersListTemp[element]!.toDouble();
      LedgerMasterDataModel ledger = LedgerMasterDataModel(
        crAmount: val,
        amount: val,
        LedgerID: element,
        isInvoiceItem: true,
      );
      ledgersList.add(ledger);
    }

    //    qDebug()<<"Ledger  List Length : "<<ledgersList.size();

    //    for(LedgerMasterDataModel obj:ledgersList){
    //        // qDebug()<<obj.LedgerName<<obj.crAmount<<obj.drAmount;
    //    }

    //    // qDebug()<<"grand total"<<grandTotal<<grossTotal;

    double round = grandTotal!.roundToOne;

    roundOff = round - grandTotal!;

    //    // qDebug()<<"Round off : "<<roundOff << "Total : "<<grandTotal;

    LedgerMasterDataModel roundledger = LedgerMasterDataModel(
      crAmount: roundOff! > 0 ? roundOff : 0,
      drAmount: roundOff! > 0 ? 0 : roundOff,
      LedgerID: '0x12x11',
      isInvoiceItem: true,
    );

    if (roundOff != 0) {
      ledgersList
          .add(roundledger.copyWith(amount: roundOff, LedgerName: 'Round Off'));
      grandTotal = grandTotal! + roundOff!;
    }

    BalanceAmount = grandTotal! - PaidAmount!;

    //    // qDebug()<<"Grand Total : "<<grandTotal;
    //    // qDebug()<<"Round Off: "<<roundOff;
    //for(int i=0;i<ledgersList.size();i++){
    //        // qDebug()<<"Ledger : "<<ledgersList[i].LedgerName;
    //        // qDebug()<<"Cr Amount : "<<ledgersList[i].crAmount;
    //        // qDebug()<<"Dr Amount : "<<ledgersList[i].drAmount;

    // }
    ledgerObject?.drAmount = grandTotal;
    ledgerObject?.amount = grandTotal;
    crTotal = 0;
    drTotal = 0;

    for (var element in ledgersList) {
      crTotal = crTotal! + element.crAmount!;
      drTotal = drTotal! + element.drAmount!;
    }
  }

  void calculateLedgerVoucher() {
    ledgersTotal = 0;
    crTotal = 0;
    drTotal = 0;

    double cTotal = 0;
    double lTotal = 0;
    double dTotal = 0;

    for (var obj in ledgersList) {
      double c = obj.crAmount!;
      double d = obj.drAmount!;
      cTotal = cTotal + c;
      dTotal = dTotal + d;
    }

    ledgersTotal = dTotal - cTotal;
    grandTotal = ledgersTotal!.abs();

    ledgerObject!.amount = grandTotal;
  }

  Map<String, dynamic> toMapForTransTest() {
    return {
      'Voucher_Date': VoucherDate?.millisecondsSinceEpoch,
      'Date_Created': DateCreated?.millisecondsSinceEpoch,
      'lastEditedDateTime': lastEditedDateTime?.millisecondsSinceEpoch,
      'invoiceNumber': invoiceNumber,
      'invoiceDate': invoiceDate?.millisecondsSinceEpoch,
      'Voucher_Prefix': VoucherPrefix,
      'Voucher_Type': voucherType,
      'Voucher_No': voucherNumber ?? '',
      'Narration': narration,
      'reference': reference,
      'POC_Phone': POCPhone,
      'POC_Email': POCEmail,
      'POC_Name': POCName,
      'DeliveryDate': DeliveryDate?.millisecondsSinceEpoch,
      'InventoryItems':
          InventoryItems?.map((e) => e.toMapForTransTest()).toList(),
      'ledgerObject': ledgerObject?.toMapForTransTest(),
      'ledgersList': ledgersList.map((e) => e.toMapForTransTest()).toList(),
      'Location': Location,
      'grandTotal': grandTotal,
      'grossTotal': grossTotal,
      'status': status,
      'ModeOfService': ModeOfService,
      'PriceListId': priceListId,
      'vatAmount': taxTotalAmount,
      'BillingName': BillingName,
      'Salesman_ID': SalesmanID,
      'toGodownID': toGodownID,
      'fromGodownID': fromGodownID,
      'TransactionId': TransactionId,
      'RequirementVoucherNo': RequirementVoucherNo,
      'isHidden': (QuotationDropped ?? false) ? 1 : 0,
      'Contact': Contact?.toJson(),
      'Request_Print': requestPrint ?? false,
    };
  }

  factory GeneralVoucherDataModel.fromMapForTransTest(
      Map<String, dynamic> map) {
    // print('voucher : $map');

    // print(
    //     'Date is HERE : ${map['Voucher_Date']} as ${DateTime.fromMillisecondsSinceEpoch(int.parse(map['Voucher_Date'] ?? '0'))}');
    DateTime vDate = DateTime.fromMillisecondsSinceEpoch(
        int.parse(map['Voucher_Date'] ?? '0') * 1000);

    // print(
    //     'Timestamp  is HERE : ${map['TimeStamp']} as ${DateTime.fromMillisecondsSinceEpoch(int.parse(map['TimeStamp'] ?? '0'))}');

    // print('Led List : ${map['ledgersList']}');

    GeneralVoucherDataModel v = GeneralVoucherDataModel(
      voucherNumber: map['Voucher_No'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(
          int.parse(map['TimeStamp'] ?? '0') * 1000),
      VoucherDate: vDate,
      DateCreated: DateTime.fromMillisecondsSinceEpoch(
          int.parse(map['Date_Created'] ?? '0') * 1000),
      VoucherPrefix: map['Voucher_Prefix'],
      InventoryItems: map['InventoryItems'] != null
          ? List<CompoundItemDataModel>.from(
              map['InventoryItems']?.map(
                (x) => CompoundItemDataModel.fromMapForTransTest(x),
              ),
            )
          : [],
      narration: map['Narration'] ?? '',
      voucherType: map['Voucher_Type'],
      grandTotal: double.parse(map['grandTotal'] ?? "0"),
      grossTotal: double.parse(map['grossTotal'] ?? "0"),
      paymentSplit: map['paymentSplit'] ?? false,
      // taxTotalAmount: ,
      TransactionId: map['TransactionId'] ?? "",
      RequirementVoucherNo: map['RequirementVoucherNo'] ?? '',
      POCPhone: map['POC_Phone'] ?? '',
      POCEmail: map['POC_Email'] ?? '',
      POCName: map['POC_Name'] ?? '',
      Location: map['Location'] ?? '',
      DeliveryDate: DateTime.fromMillisecondsSinceEpoch(
          int.parse(map['DeliveryDate'] ?? '0') * 1000),
      ledgerObject: LedgerMasterDataModel.fromMapGen(map['ledgerObject']),
      status: map['voucherstatus'],
      ModeOfService: int.parse(map['ModeOfService'] ?? '0'),
      priceListId: int.parse(map['ModeOfService'] ?? '0'),
      taxTotalAmount: double.parse(map['vatAmount'] ?? '0'),
      BillingName: map['BillingName'] ?? '',
      SalesmanID: int.parse(map['Salesman_ID'] ?? '0'),
      ledgersList: (map['ledgersList'] == null)
          ? []
          : List<LedgerMasterDataModel>.from(
              map['ledgersList']?.map(
                (x) => LedgerMasterDataModel.fromMapGen(x),
              ),
            ),
      toGodownID: map['toGodownID'] ?? '',
      fromGodownID: map['fromGodownID'] ?? 'GODOWN',
      Contact: ContactsDataModel.fromMap(map['Contact'] ?? {}),
      // isHidden: int.parse(map['isHidden']) == 1 ? true : false,

      reference: map['reference'] ?? '',
    );

    return v;
  }
}
