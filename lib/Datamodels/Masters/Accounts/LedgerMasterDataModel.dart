import 'dart:convert';

import '../../../../../Datamodels/HiveModels/Ledgers/LedMasterHiveModel.dart';
import 'package:equatable/equatable.dart';

import '../../../../../Datamodels/Masters/Accounts/billwise_records_datamodel.dart';

const String column_sl_no = "sl_no";
const String column_LEDGER_ID = "LEDGER_ID";
const String column_Ledger_Name = "Ledger_Name";
const String column_Ledger_Type = "Ledger_Type";
const String column_Group_Id = "Group_Id";
const String column_Opening_Balance = "Opening_Balance";
const String column_Opening_Balance_Date = "Opening_Balance_Date";
const String column_Closing_Balance = "Closing_Balance";
const String column_Turn_Over = "Turn_Over";
const String column_isIndividual = "isIndividual";
const String column_Narration = "Narration";
const String column_City = "City";
const String column_Address = "Address";
const String column_Email = "Email";
const String column_Phone_Number = "Phone_Number";
const String column_Contact_Person_Name = "Contact_Person_Name";
const String column_Mobile_Number = "Mobile_Number";
const String column_Website = "Website";
const String column_Contact_Person = "Contact_Person";
const String column_Contant_Person_Number = "Contant_Person_Number";
const String column_PoBox = "PoBox";
const String column_Country = "Country";
const String column_Registration_Number = "Registration_Number";
const String column_Default_Price_List_Id = "Default_Price_List_Id";
const String column_State = "State";
const String column_Birth_Date = "Birth_Date";
const String column_Credit_Period = "Credit_Period";
const String column_ParentCompany = "ParentCompany";
const String column_Fax = "Fax";
const String column_creditAllowed = "creditAllowed";
const String column_paymentTerms = "paymentTerms";
const String column_Tax_Rate = "Tax_Rate";
const String column_Type_Of_Supply = "Type_Of_Supply";
const String column_Default_Tax_Ledger = "Default_Tax_Ledger";
const String column_TRN = "TRN";
const String column_DefaultRecord = "DefaultRecord";
const String column_DbName = "DbName";

const String TableName_Ledger_Master = "Ledger_Master";

class LedgerMasterDataModel extends Equatable {
  // Master Data
  final String? LedgerID;
  final String? LedgerName;
  final String? ledgerNameArabic;
  final String? LedgerGroupId;
  final String? LedgerGroupName;
  final double? openingBalance;
  final DateTime? openingBalanceDate;

  final String? LedgerType;
  final String? narration;
  final String? City;
  final String? Address;
  final String? emailAddress;
  final String? shippingAddress;
  final String? phoneNumber;
  final String? fax;
  final String? parentCompany;
  final String? mobileNumber;
  final String? website;

  final String? ContactPersonName;
  final String? ContactPersonNumber;
  final String? ContactPersonEmail;
  final String? PoBox;
  final String? Country;
  final String? TRN;
  final String? registrationNumber;

  final String? defaultPriceListID;

  final String? State;
  final DateTime? Birth_Date;
  final int? Credit_Period;
  final double? Credit_Limit;
  final bool? isIndividual;

  final String? routeId;
  final double? distance;
  final double? deliveryRate;

  final String? GPSLatitude;
  final String? GPSLongitude;

  final int? defaultSalesMan;
  final bool? isFrequent;

  final int? TaxClassID;

  final String? DefaultTaxLedger;
  final String? TypeOfSupply;
  final double? taxRate;
  final String? AgainstLedger;
  final bool? hasBillwiseMappings;

  final String? dbName;

  // calulated
  final double? closingBalance; //calulate
  final double? totalTurnover; //calulate

  // transaction vals
  double? amount;

  final int? listid;

  double? crAmount;
  double? drAmount;
  final String? voucherNo;
  final DateTime? voucherDate;
  final String? voucherType;
  final String? voucherPrefix;

  final DateTime? timestamp;

  final bool? isInvoiceItem;

  final double? discountPercent;

  List<BillwiseMappingModel>? mapList;

  final String? GPSLocation;

  // Extras

  final bool? fromExternal;
  final int? action;

  LedgerMasterDataModel({
    this.LedgerID,
    this.LedgerName,
    this.ledgerNameArabic,
    this.LedgerGroupId,
    this.LedgerGroupName,
    this.openingBalance,
    this.openingBalanceDate,
    this.closingBalance,
    this.totalTurnover,
    this.LedgerType,
    this.narration,
    this.City,
    this.Address,
    this.emailAddress,
    this.shippingAddress,
    this.phoneNumber,
    this.fax,
    this.parentCompany,
    this.mobileNumber,
    this.website,
    this.ContactPersonName,
    this.ContactPersonNumber,
    this.ContactPersonEmail,
    this.PoBox,
    this.Country,
    this.TRN,
    this.registrationNumber,
    this.defaultPriceListID,
    this.amount,
    this.listid,
    this.State,
    this.Birth_Date,
    this.Credit_Period,
    this.Credit_Limit,
    this.isIndividual,
    this.crAmount = 0,
    this.drAmount = 0,
    this.voucherNo,
    this.voucherDate,
    this.voucherType,
    this.voucherPrefix,
    this.timestamp,
    this.isInvoiceItem,
    this.discountPercent,
    this.isFrequent,
    this.TaxClassID,
    this.DefaultTaxLedger,
    this.TypeOfSupply,
    this.taxRate,
    this.AgainstLedger,
    this.hasBillwiseMappings,
    this.mapList,
    this.dbName,
    this.fromExternal,
    this.action,
    this.routeId,
    this.distance,
    this.deliveryRate,
    this.GPSLatitude,
    this.GPSLongitude,
    this.defaultSalesMan,
    this.GPSLocation,
  });

  LedgerMasterDataModel copyWith({
    String? LedgerID,
    String? LedgerName,
    String? ledgerNameArabic,
    String? LedgerGroupId,
    String? LedgerGroupName,
    double? openingBalance,
    DateTime? openingBalanceDate,
    double? closingBalance,
    double? totalTurnover,
    String? LedgerType,
    String? narration,
    String? City,
    String? Address,
    String? emailAddress,
    String? shippingAddress,
    String? phoneNumber,
    String? fax,
    String? parentCompany,
    String? mobileNumber,
    String? website,
    String? ContactPersonName,
    String? ContactPersonNumber,
    String? ContactPersonEmail,
    String? PoBox,
    String? Country,
    String? TRN,
    String? registrationNumber,
    String? defaultPriceListID,
    double? amount,
    int? listid,
    String? State,
    DateTime? Birth_Date,
    int? Credit_Period,
    double? Credit_Limit,
    bool? isIndividual,
    double? crAmount,
    double? drAmount,
    String? voucherNo,
    DateTime? voucherDate,
    String? voucherType,
    String? voucherPrefix,
    DateTime? timestamp,
    bool? isInvoiceItem,
    double? discountPercent,
    bool? isFrequent,
    int? TaxClassID,
    String? DefaultTaxLedger,
    String? TypeOfSupply,
    double? taxRate,
    String? AgainstLedger,
    bool? hasBillwiseMappings,
    List<BillwiseMappingModel>? mapList,
    String? dbName,
    bool? fromExternal,
    int? action,
    String? routeId,
    double? distance,
    double? deliveryRate,
    String? GPSLatitude,
    String? GPSLongitude,
    int? defaultSalesMan,
  }) {
    return LedgerMasterDataModel(
      LedgerID: LedgerID ?? this.LedgerID,
      LedgerName: LedgerName ?? this.LedgerName,
      ledgerNameArabic: ledgerNameArabic ?? this.ledgerNameArabic,
      LedgerGroupId: LedgerGroupId ?? this.LedgerGroupId,
      LedgerGroupName: LedgerGroupName ?? this.LedgerGroupName,
      openingBalance: openingBalance ?? this.openingBalance,
      openingBalanceDate: openingBalanceDate ?? this.openingBalanceDate,
      closingBalance: closingBalance ?? this.closingBalance,
      totalTurnover: totalTurnover ?? this.totalTurnover,
      LedgerType: LedgerType ?? this.LedgerType,
      narration: narration ?? this.narration,
      City: City ?? this.City,
      Address: Address ?? this.Address,
      emailAddress: emailAddress ?? this.emailAddress,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fax: fax ?? this.fax,
      parentCompany: parentCompany ?? this.parentCompany,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      website: website ?? this.website,
      ContactPersonName: ContactPersonName ?? this.ContactPersonName,
      ContactPersonNumber: ContactPersonNumber ?? this.ContactPersonNumber,
      ContactPersonEmail: ContactPersonEmail ?? this.ContactPersonEmail,
      PoBox: PoBox ?? this.PoBox,
      Country: Country ?? this.Country,
      TRN: TRN ?? this.TRN,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      defaultPriceListID: defaultPriceListID ?? this.defaultPriceListID,
      amount: amount ?? this.amount,
      listid: listid ?? this.listid,
      State: State ?? this.State,
      Birth_Date: Birth_Date ?? this.Birth_Date,
      Credit_Period: Credit_Period ?? this.Credit_Period,
      Credit_Limit: Credit_Limit ?? this.Credit_Limit,
      isIndividual: isIndividual ?? this.isIndividual,
      crAmount: crAmount ?? this.crAmount,
      drAmount: drAmount ?? this.drAmount,
      voucherNo: voucherNo ?? this.voucherNo,
      voucherDate: voucherDate ?? this.voucherDate,
      voucherType: voucherType ?? this.voucherType,
      voucherPrefix: voucherPrefix ?? this.voucherPrefix,
      timestamp: timestamp ?? this.timestamp,
      isInvoiceItem: isInvoiceItem ?? this.isInvoiceItem,
      discountPercent: discountPercent ?? this.discountPercent,
      isFrequent: isFrequent ?? this.isFrequent,
      TaxClassID: TaxClassID ?? this.TaxClassID,
      DefaultTaxLedger: DefaultTaxLedger ?? this.DefaultTaxLedger,
      TypeOfSupply: TypeOfSupply ?? this.TypeOfSupply,
      taxRate: taxRate ?? this.taxRate,
      AgainstLedger: AgainstLedger ?? this.AgainstLedger,
      hasBillwiseMappings: hasBillwiseMappings ?? this.hasBillwiseMappings,
      mapList: mapList ?? this.mapList,
      dbName: dbName ?? this.dbName,
      fromExternal: fromExternal ?? this.fromExternal,
      action: action ?? this.action,
      routeId: routeId ?? this.routeId,
      distance: distance ?? this.distance,
      deliveryRate: deliveryRate ?? this.deliveryRate,
      GPSLatitude: GPSLatitude ?? this.GPSLatitude,
      GPSLongitude: GPSLongitude ?? this.GPSLongitude,
      defaultSalesMan: defaultSalesMan ?? this.defaultSalesMan,
    );
  }

  Map<String, dynamic> toMapforMasters() {
    return {
      'Ledger_Id': LedgerID,
      'Ledger_Name': LedgerName,
      'Group_Id': LedgerGroupId,
      'Address': Address,
      'Phone_Number': phoneNumber,
      'GPSLocation': '',
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'LedgerID': LedgerID,
      'LedgerName': LedgerName,
      'ledgerNameArabic': ledgerNameArabic,
      'LedgerGroupId': LedgerGroupId,
      'LedgerGroupName': LedgerGroupName,
      'openingBalance': openingBalance,
      'openingBalanceDate': openingBalanceDate?.millisecondsSinceEpoch,
      'closingBalance': closingBalance,
      'totalTurnover': totalTurnover,
      'LedgerType': LedgerType,
      'narration': narration,
      'City': City,
      'Address': Address,
      'emailAddress': emailAddress,
      'shippingAddress': shippingAddress,
      'phoneNumber': phoneNumber,
      'fax': fax,
      'parentCompany': parentCompany,
      'mobileNumber': mobileNumber,
      'website': website,
      'ContactPersonName': ContactPersonName,
      'ContactPersonNumber': ContactPersonNumber,
      'ContactPersonEmail': ContactPersonEmail,
      'PoBox': PoBox,
      'Country': Country,
      'TRN': TRN,
      'registrationNumber': registrationNumber,
      'defaultPriceListID': defaultPriceListID,
      'amount': amount,
      'listid': listid,
      'State': State,
      'Birth_Date': Birth_Date?.millisecondsSinceEpoch,
      'Credit_Period': Credit_Period,
      'Credit_Limit': Credit_Limit,
      'isIndividual': isIndividual,
      'crAmount': crAmount,
      'drAmount': drAmount,
      'voucherNo': voucherNo,
      'voucherDate': voucherDate?.millisecondsSinceEpoch,
      'voucherType': voucherType,
      'voucherPrefix': voucherPrefix,
      'timestamp': timestamp!.millisecondsSinceEpoch,
      'isInvoiceItem': isInvoiceItem,
      'discountPercent': discountPercent,
      'isFrequent': isFrequent,
      'TaxClassID': TaxClassID,
      'DefaultTaxLedger': DefaultTaxLedger,
      'TypeOfSupply': TypeOfSupply,
      'taxRate': taxRate,
      'AgainstLedger': AgainstLedger,
      'hasBillwiseMappings': hasBillwiseMappings,
      'mapList': mapList!.map((x) => x.toMap()).toList(),
      'dbName': dbName,
      'fromExternal': fromExternal,
      'action': action,
      'routeId': routeId,
      'distance': distance,
      'deliveryRate': deliveryRate,
      'GPSLatitude': GPSLatitude,
      'GPSLongitude': GPSLongitude,
      'defaultSalesMan': defaultSalesMan,
    };
  }

  factory LedgerMasterDataModel.fromMap(Map<String, dynamic> map) {
    return LedgerMasterDataModel(
      LedgerID: map['LedgerID'],
      LedgerName: map['LedgerName'],
      ledgerNameArabic: map['ledgerNameArabic'],
      LedgerGroupId: map['LedgerGroupId'],
      LedgerGroupName: map['LedgerGroupName'],
      openingBalance: map['openingBalance']?.toDouble(),
      openingBalanceDate: map['openingBalanceDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['openingBalanceDate'])
          : null,
      closingBalance: map['closingBalance']?.toDouble(),
      totalTurnover: map['totalTurnover']?.toDouble(),
      LedgerType: map['LedgerType'],
      narration: map['narration'],
      City: map['City'],
      Address: map['Address'],
      emailAddress: map['emailAddress'],
      shippingAddress: map['shippingAddress'],
      phoneNumber: map['phoneNumber'],
      fax: map['fax'],
      parentCompany: map['parentCompany'],
      mobileNumber: map['mobileNumber'],
      website: map['website'],
      ContactPersonName: map['ContactPersonName'],
      ContactPersonNumber: map['ContactPersonNumber'],
      ContactPersonEmail: map['ContactPersonEmail'],
      PoBox: map['PoBox'],
      Country: map['Country'],
      TRN: map['TRN'],
      registrationNumber: map['registrationNumber'],
      defaultPriceListID: map['defaultPriceListID'],
      amount: map['amount']?.toDouble(),
      listid: map['listid']?.toInt(),
      State: map['State'],
      Birth_Date: map['Birth_Date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['Birth_Date'])
          : null,
      Credit_Period: map['Credit_Period']?.toInt(),
      Credit_Limit: map['Credit_Limit']?.toDouble(),
      isIndividual: map['isIndividual'],
      crAmount: map['crAmount']?.toDouble(),
      drAmount: map['drAmount']?.toDouble(),
      voucherNo: map['voucherNo'],
      voucherDate: map['voucherDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['voucherDate'])
          : null,
      voucherType: map['voucherType'],
      voucherPrefix: map['voucherPrefix'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      isInvoiceItem: map['isInvoiceItem'],
      discountPercent: map['discountPercent']?.toDouble(),
      isFrequent: map['isFrequent'],
      TaxClassID: map['TaxClassID']?.toInt(),
      DefaultTaxLedger: map['DefaultTaxLedger'],
      TypeOfSupply: map['TypeOfSupply'],
      taxRate: map['taxRate']?.toDouble(),
      AgainstLedger: map['AgainstLedger'],
      hasBillwiseMappings: map['hasBillwiseMappings'],
      mapList: List<BillwiseMappingModel>.from(
          map['mapList']?.map((x) => BillwiseMappingModel.fromMap(x))),
      dbName: map['dbName'],
      fromExternal: map['fromExternal'],
      action: map['action']?.toInt(),
      routeId: map['routeId'],
      distance: map['distance']?.toDouble(),
      deliveryRate: map['deliveryRate']?.toDouble(),
      GPSLatitude: map['GPSLatitude'],
      GPSLongitude: map['GPSLongitude'],
      defaultSalesMan: map['defaultSalesMan']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory LedgerMasterDataModel.fromJson(String source) =>
      LedgerMasterDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LedgerMasterDataModel(LedgerID: $LedgerID, LedgerName: $LedgerName, ledgerNameArabic: $ledgerNameArabic, LedgerGroupId: $LedgerGroupId, LedgerGroupName: $LedgerGroupName, openingBalance: $openingBalance, openingBalanceDate: $openingBalanceDate, closingBalance: $closingBalance, totalTurnover: $totalTurnover, LedgerType: $LedgerType, narration: $narration, City: $City, Address: $Address, emailAddress: $emailAddress, shippingAddress: $shippingAddress, phoneNumber: $phoneNumber, fax: $fax, parentCompany: $parentCompany, mobileNumber: $mobileNumber, website: $website, ContactPersonName: $ContactPersonName, ContactPersonNumber: $ContactPersonNumber, ContactPersonEmail: $ContactPersonEmail, PoBox: $PoBox, Country: $Country, TRN: $TRN, registrationNumber: $registrationNumber, defaultPriceListID: $defaultPriceListID, amount: $amount, listid: $listid, State: $State, Birth_Date: $Birth_Date, Credit_Period: $Credit_Period, Credit_Limit: $Credit_Limit, isIndividual: $isIndividual, crAmount: $crAmount, drAmount: $drAmount, voucherNo: $voucherNo, voucherDate: $voucherDate, voucherType: $voucherType, voucherPrefix: $voucherPrefix, timestamp: $timestamp, isInvoiceItem: $isInvoiceItem, discountPercent: $discountPercent, isFrequent: $isFrequent, TaxClassID: $TaxClassID, DefaultTaxLedger: $DefaultTaxLedger, TypeOfSupply: $TypeOfSupply, taxRate: $taxRate, AgainstLedger: $AgainstLedger, hasBillwiseMappings: $hasBillwiseMappings, mapList: $mapList, dbName: $dbName, fromExternal: $fromExternal, action: $action, routeId: $routeId, distance: $distance, deliveryRate: $deliveryRate, GPSLatitude: $GPSLatitude, GPSLongitude: $GPSLongitude, defaultSalesMan: $defaultSalesMan)';
  }

  @override
  List<Object?> get props {
    return [
      LedgerID,
      LedgerName,
      ledgerNameArabic,
      LedgerGroupId,
      LedgerGroupName,
      openingBalance,
      openingBalanceDate,
      closingBalance,
      totalTurnover,
      LedgerType,
      narration,
      City,
      Address,
      emailAddress,
      shippingAddress,
      phoneNumber,
      fax,
      parentCompany,
      mobileNumber,
      website,
      ContactPersonName,
      ContactPersonNumber,
      ContactPersonEmail,
      PoBox,
      Country,
      TRN,
      registrationNumber,
      defaultPriceListID,
      amount,
      listid,
      State,
      Birth_Date,
      Credit_Period,
      Credit_Limit,
      isIndividual,
      crAmount,
      drAmount,
      voucherNo,
      voucherDate,
      voucherType,
      voucherPrefix,
      timestamp,
      isInvoiceItem,
      discountPercent,
      isFrequent,
      TaxClassID,
      DefaultTaxLedger,
      TypeOfSupply,
      taxRate,
      AgainstLedger,
      hasBillwiseMappings,
      mapList,
      dbName,
      fromExternal,
      action,
      routeId,
      distance,
      deliveryRate,
      GPSLatitude,
      GPSLongitude,
      defaultSalesMan,
    ];
  }

  Map<String, dynamic> toMapForTransTest() {
    Map<String, dynamic> map = {
      'Ledger_Id': LedgerID,
      'Ledger_Name': LedgerName,
      'crAmount': crAmount,
      'drAmount': drAmount,
      'amount': amount,
      'DbName': dbName,
      'isInvoiceItem': (isInvoiceItem ?? false) ? 1 : 0,
      'AgainstLedger': AgainstLedger,
    };
    return map;
  }

  factory LedgerMasterDataModel.fromMapGen(Map<String, dynamic>? map) {
    if (map == null) return LedgerMasterDataModel();

    // double crmt = map['crAmount'];
    // map['ce'].toDouble();
    print(
        'Converting ${map['Ledger_Id']} cr is ${map['crAmount'].runtimeType} of $map');
    LedgerMasterDataModel led = LedgerMasterDataModel(
      LedgerID: map['Ledger_Id'] ?? "",
      LedgerName: map['Ledger_Name'] ?? "",
      crAmount: (map['crAmount'] ?? 0).toDouble(),
      drAmount: (map['drAmount'] ?? 0).toDouble(),
      amount: (map['amount'] ?? 0).toDouble(),
      isInvoiceItem: map['isInvoiceItem'] ?? true,
      dbName: map['DbName'],
    );

    print('Converted new Ledger ${led.LedgerName} - ${led.LedgerID}');
    return led;
  }

  factory LedgerMasterDataModel.fromHive(LedgerMasterHiveModel? led) {
    if (led == null) return LedgerMasterDataModel();
    return LedgerMasterDataModel(
      LedgerID: led.LEDGER_ID,
      LedgerName: led.Ledger_Name,
      dbName: led.DbName,
    );
  }
}
