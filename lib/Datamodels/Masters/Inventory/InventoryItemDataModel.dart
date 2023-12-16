import 'dart:convert';

import '../../../../Datamodels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import 'package:equatable/equatable.dart';

import 'item_batch_datamodel.dart';
import '../../../../Datamodels/Masters/Inventory/inv_godown_datamodel.dart';
import 'package:uuid/uuid.dart';

import '../../HiveModels/UOM/UOMHiveModel.dart';
import 'bom_datamodel.dart';

const String TableName_InventoryItems = "Sales_Inventory_Items";

const String column_id = "_id";
const String column_Item_ID = "Item_ID";
const String column_Item_Name = "Item_Name";
const String column_Item_Alias = "Item_Alias";
const String column_Item_Code = "Item_Code";
const String column_Item_Group_Id = "Group_Id";
const String column_Item_Group_Name = "Group_Name";
const String column_Item_Part_Number = "Part_Number";
const String column_Item_Price = "Price";
const String column_Opening_Stock = "Opening_Stock";
const String column_Opening_Balance_Date = "Opening_Balance_Date";
const String column_Last_Modified_By = "Last_Modified_By";
const String column_Opening_Rate = "Opening_Rate";
const String column_Opening_Value = "Opening_Value";
const String column_Narration = "Narration";
const String column_Serial_Number = "Serial_Number";
const String column_Closing_Stock = "Closing_Stock";
const String column_Reorder_Level = "Reorder_Level";
const String column_Std_Cost = "Std_Cost";
const String column_Default_Sales_Ledger_id = "Default_Sales_Ledger_id";
const String column_Default_PurchaseLedger_id = "Default_PurchaseLedger_id";
const String column_Default_Input_Tax_Ledger = "Default_Input_Tax_Ledger";
const String column_Default_Output_Tax_Ledger = "Default_Output_Tax_Ledger";
const String column_Default_Sales_Return_Ledger = "Default_Sales_Return_Ledger";
const String column_Default_Purchase_Return_Ledger =
    "Default_Purchase_Return_Ledger";
const String column_Vat_Rate = "Vat_Rate";
const String column_Default_UOM_ID = "Default_UOM_ID";
const String column_Last_Modified = "Last_Modified";
const String column_Date_Created = "Date_Created";
const String column_Timestamp = "Timestamp";
const String column_Warranty_Days = "Warranty_Days";
const String column_Shelf_Life = "Shelf_Life";
const String column_Brand_Id = "Brand_Id";
const String column_Item_Description = "Item_Description";
const String column_isCustomItem = "isCustomItem";
const String column_Dimension = "Dimension";
const String column_isPurchaseItem = "isPurchaseItem";
const String column_isSalesItem = "isSalesItem";
const String column_KOT_Prfinaler = "KOT_Prfinter";
const String column_Item_Name_Arabic = "Item_Name_Arabic";
const String column_Favourite = "Favourite";
const String column_IsStockItem = "IsStockItem";
const String column_From_Time = "From_Time";
const String column_To_Time = "To_Time";
const String column_Price_2 = "Price_2";
const String column_HSN_CODE = "HSN_CODE";
const String column_Section = "Section";
const String column_Flags = "Flags";
const String column_Category = "Category";
const String column_DefaultLedgerID = "DefaultLedgerID";

class InventoryItemDataModel extends Equatable {
  // Master Data
  final String? ItemName;
  final String? ItemNameArabic;
  final String? GroupName;
  final String? GroupID;
  final String? ItemID;
  final String? ItemAlias;
  final String? ItemCode;

  final double? stdCost;
  final String? Dimension;

  final double? stdRate;
  final double? rate;
  final double? price_2;

  final double? priceLastPurchase;

  final double? moq;

  final String? PartNumber;
  final double? OpeningStock;
  final DateTime? OpeningStockDate;
  final double? OpeningStockValue;
  final double? OpeningStockPrice;
  final double? ReorderLevel;
  final String? defaultSalesLedgerID;
  final String? defaultPurchaseLedgerID;
  final String? brandID;
  final String? brandName;
  final double? taxRate;
  final String? defaultUOMID;
  final DateTime? lastModified;
  final DateTime? dateCreated;

  final DateTime? fromTime;
  final DateTime? toTime;

  final String? createdBy;
  // List<PropertyDataModel> baseProperties;

  List<BOMDataModel>? bomList;
  final String? ItemDescription;
  final double? length;

  final int? warrantyDays;
  final double? shelfLife;

  final bool? IsCompoundItem;
  final bool? isCustomItem;
  final bool? isPurchaseItem;
  final bool? isSalesItem;
  final bool? isSerailNumbered;
  final bool? isBatchProcessed;
  final bool? removeItem;
  final bool? isService;
  final bool? isProductionItem;
  final bool? setPriceBatchwise;
  final bool? isPerishable;
  final bool? favo;
  final String? DefaultInputTaxLedgerID;
  final String? DefaultOutputTaxLedgerID;
  final String? DefaultSalesReturnLedgerID;
  final String? DefaultPurchaseReturnLedgerID;
  final String? KOTPrinter;
  final String? hsnCode;
  final String? narration;
  final String? section;
  Map? flags;

  final bool? isStockItem;
  final String? category;
  final String? defaultLedgerId;
  final String? location;
  final double? weight;

  // calculated vals when item fetched
  final double? ClosingStock;
  final int? TaxClassID;

//Transaction vals

  final double? discount;
  double? discountinAmount;
  double? discountPercentage;
  double? subTotal;
  double? grossTotal;
  double? grandTotal;

  final String? ItemReqUuid;
  final int? listId;

  final String? fromGodownID;
  final String? toGodownID;

  List<ItemGodownDataModel>? godownList;
  final List<BatchDataModel>? batchList;

  final String? PriceLevel;
  final String? SerailNumber;

  final String? ProjectID;
  double? taxAmount;

  UOMHiveMOdel? uomObject;

  final String? priceListID;
  final String? priceListName;

  final bool? itemPriceEditted;

  final int? itemProductionStatus;
  final int? itemVoucherStatus;

  final int? TechnicianID;

  double? drQty;
  double? crQty;
  final double? consumedQty;
  final double? orderedQty;
  final double? quantity;
  final double? maxQuantity;
  final double? calculatedQty;
  final double? requestQty;
  final double? prevQty;
  final double? currQty;
  final double? billedQty;
  final double? actualQty;

  // TO BE PREP

  final bool? fromExternal;
  final int? action;
  final DateTime? orderCompletedDate;
  final DateTime? manufactureDate;
  final DateTime? expiry;

  InventoryItemDataModel({
    this.ItemName,
    this.ItemNameArabic,
    this.GroupName,
    this.GroupID,
    this.ItemID,
    this.ItemAlias,
    this.ItemCode,
    this.narration,
    this.stdCost,
    this.Dimension,
    this.stdRate,
    this.rate = 0,
    this.price_2,
    this.priceLastPurchase,
    this.discount = 0,
    this.discountinAmount = 0,
    this.discountPercentage = 0,
    this.subTotal = 0,
    this.grossTotal = 0,
    this.grandTotal = 0,
    this.moq,
    this.ItemReqUuid,
    this.listId,
    this.fromGodownID,
    this.toGodownID,
    this.godownList,
    this.batchList,
    this.PriceLevel,
    this.PartNumber,
    this.SerailNumber,
    this.OpeningStock,
    this.ClosingStock,
    this.OpeningStockDate,
    this.OpeningStockValue,
    this.OpeningStockPrice,
    this.ReorderLevel,
    this.defaultSalesLedgerID,
    this.defaultPurchaseLedgerID,
    this.ProjectID,
    this.brandID,
    this.brandName,
    this.taxRate,
    this.taxAmount,
    this.defaultUOMID,
    this.uomObject,
    this.priceListID,
    this.priceListName,
    this.lastModified,
    this.dateCreated,
    this.fromTime,
    this.toTime,
    this.createdBy,
    this.bomList,
    this.ItemDescription,
    this.length,
    this.warrantyDays,
    this.shelfLife,
    this.IsCompoundItem,
    this.isCustomItem,
    this.isPurchaseItem,
    this.isSalesItem,
    this.isSerailNumbered,
    this.isBatchProcessed,
    this.removeItem,
    this.isService,
    this.isProductionItem,
    this.setPriceBatchwise,
    this.isPerishable,
    this.favo,
    this.itemPriceEditted,
    this.KOTPrinter,
    this.itemProductionStatus,
    this.itemVoucherStatus,
    this.DefaultInputTaxLedgerID,
    this.DefaultOutputTaxLedgerID,
    this.DefaultSalesReturnLedgerID,
    this.DefaultPurchaseReturnLedgerID,
    this.TaxClassID,
    this.TechnicianID,
    this.drQty = 0,
    this.crQty = 0,
    this.consumedQty = 0,
    this.orderedQty = 0,
    this.quantity = 0,
    this.maxQuantity = 0,
    this.calculatedQty,
    this.requestQty,
    this.prevQty,
    this.currQty,
    this.billedQty,
    this.actualQty,
    this.hsnCode,
    this.section,
    this.flags,
    this.fromExternal,
    this.action,
    this.orderCompletedDate,
    this.manufactureDate,
    this.expiry,
    this.isStockItem,
    this.category,
    this.defaultLedgerId,
    this.location,
    this.weight = 0,
  });

  InventoryItemDataModel copyWith({
    String? ItemName,
    String? ItemNameArabic,
    String? GroupName,
    String? GroupID,
    String? ItemID,
    String? ItemAlias,
    String? ItemCode,
    String? narration,
    double? stdCost,
    String? Dimension,
    // double? price = 0,
    double? rate,
    double? price_1,
    double? price_2,
    double? priceLastPurchase,
    double? discount,
    double? discountinAmount,
    double? discountPercentage,
    double? subTotal,
    double? grossTotal,
    double? grandTotal,
    double? moq,
    String? ItemReqUuid,
    int? listId,
    String? fromGodownID,
    String? toGodownID,
    List<ItemGodownDataModel>? godownList,
    List<BatchDataModel>? batchList,
    String? PriceLevel,
    String? PartNumber,
    String? SerailNumber,
    double? OpeningStock,
    double? ClosingStock,
    DateTime? OpeningStockDate,
    double? OpeningStockValue,
    double? OpeningStockPrice,
    double? ReorderLevel,
    String? defaultSalesLedgerID,
    String? defaultPurchaseLedgerID,
    String? ProjectID,
    String? brandID,
    String? brandName,
    double? taxRate,
    double? taxAmount,
    String? defaultUOMID,
    UOMHiveMOdel? uomObject,
    String? priceListID,
    String? priceListName,
    DateTime? lastModified,
    DateTime? dateCreated,
    DateTime? fromTime,
    DateTime? toTime,
    String? createdBy,
    List<BOMDataModel>? bomList,
    String? ItemDescription,
    double? length,
    int? warrantyDays,
    double? shelfLife,
    bool? IsCompoundItem,
    bool? isCustomItem,
    bool? isPurchaseItem,
    bool? isSalesItem,
    bool? isSerailNumbered,
    bool? isBatchProcessed,
    bool? removeItem,
    bool? isService,
    bool? isProductionItem,
    bool? setPriceBatchwise,
    bool? isPerishable,
    bool? favo,
    bool? itemPriceEditted,
    String? KOTPrinter,
    int? itemProductionStatus,
    int? itemVoucherStatus,
    String? DefaultInputTaxLedgerID,
    String? DefaultOutputTaxLedgerID,
    String? DefaultSalesReturnLedgerID,
    String? DefaultPurchaseReturnLedgerID,
    int? TaxClassID,
    int? TechnicianID,
    double? drQty,
    double? crQty,
    double? consumedQty,
    double? orderedQty,
    double? quantity,
    double? maxQuantity,
    double? calculatedQty,
    double? requestQty,
    double? prevQty,
    double? currQty,
    double? discQuantity,
    double? quantityFull,
    String? hsnCode,
    String? section,
    Map? flags,
    int? salesmanID,
    bool? fromExternal,
    int? action,
    DateTime? orderCompletedDate,
    DateTime? manufactureDate,
    DateTime? expiry,
    bool? isStockItem,
    String? category,
    String? defaultLedgerId,
    String? location,
    double? weight,
  }) {
    return InventoryItemDataModel(
      ItemName: ItemName ?? this.ItemName,
      ItemNameArabic: ItemNameArabic ?? this.ItemNameArabic,
      GroupName: GroupName ?? this.GroupName,
      GroupID: GroupID ?? this.GroupID,
      ItemID: ItemID ?? this.ItemID,
      ItemAlias: ItemAlias ?? this.ItemAlias,
      ItemCode: ItemCode ?? this.ItemCode,
      narration: narration ?? this.narration,
      stdCost: stdCost ?? this.stdCost,
      Dimension: Dimension ?? this.Dimension,
      stdRate: rate ?? stdRate,
      rate: rate ?? this.rate,
      price_2: price_2 ?? this.price_2,
      priceLastPurchase: priceLastPurchase ?? this.priceLastPurchase,
      discount: discount ?? this.discount,
      discountinAmount: discountinAmount ?? this.discountinAmount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      subTotal: subTotal ?? this.subTotal,
      grossTotal: grossTotal ?? this.grossTotal,
      grandTotal: grandTotal ?? this.grandTotal,
      moq: moq ?? this.moq,
      ItemReqUuid: ItemReqUuid ?? this.ItemReqUuid,
      listId: listId ?? this.listId,
      fromGodownID: fromGodownID ?? this.fromGodownID,
      toGodownID: toGodownID ?? this.toGodownID,
      godownList: godownList ?? this.godownList,
      batchList: batchList ?? this.batchList,
      PriceLevel: PriceLevel ?? this.PriceLevel,
      PartNumber: PartNumber ?? this.PartNumber,
      SerailNumber: SerailNumber ?? this.SerailNumber,
      OpeningStock: OpeningStock ?? this.OpeningStock,
      ClosingStock: ClosingStock ?? this.ClosingStock,
      OpeningStockDate: OpeningStockDate ?? this.OpeningStockDate,
      OpeningStockValue: OpeningStockValue ?? this.OpeningStockValue,
      OpeningStockPrice: OpeningStockPrice ?? this.OpeningStockPrice,
      ReorderLevel: ReorderLevel ?? this.ReorderLevel,
      defaultSalesLedgerID: defaultSalesLedgerID ?? this.defaultSalesLedgerID,
      defaultPurchaseLedgerID:
          defaultPurchaseLedgerID ?? this.defaultPurchaseLedgerID,
      ProjectID: ProjectID ?? this.ProjectID,
      brandID: brandID ?? this.brandID,
      brandName: brandName ?? this.brandName,
      taxRate: taxRate ?? this.taxRate,
      taxAmount: taxAmount ?? this.taxAmount,
      defaultUOMID: defaultUOMID ?? this.defaultUOMID,
      uomObject: uomObject ?? this.uomObject,
      priceListID: priceListID ?? this.priceListID,
      priceListName: priceListName ?? this.priceListName,
      lastModified: lastModified ?? this.lastModified,
      dateCreated: dateCreated ?? this.dateCreated,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
      createdBy: createdBy ?? this.createdBy,
      bomList: bomList ?? this.bomList,
      ItemDescription: ItemDescription ?? this.ItemDescription,
      length: length ?? this.length,
      warrantyDays: warrantyDays ?? this.warrantyDays,
      shelfLife: shelfLife ?? this.shelfLife,
      IsCompoundItem: IsCompoundItem ?? this.IsCompoundItem,
      isCustomItem: isCustomItem ?? this.isCustomItem,
      isPurchaseItem: isPurchaseItem ?? this.isPurchaseItem,
      isSalesItem: isSalesItem ?? this.isSalesItem,
      isSerailNumbered: isSerailNumbered ?? this.isSerailNumbered,
      isBatchProcessed: isBatchProcessed ?? this.isBatchProcessed,
      removeItem: removeItem ?? this.removeItem,
      isService: isService ?? this.isService,
      isProductionItem: isProductionItem ?? this.isProductionItem,
      setPriceBatchwise: setPriceBatchwise ?? this.setPriceBatchwise,
      isPerishable: isPerishable ?? this.isPerishable,
      favo: favo ?? this.favo,
      itemPriceEditted: itemPriceEditted ?? this.itemPriceEditted,
      KOTPrinter: KOTPrinter ?? this.KOTPrinter,
      itemProductionStatus: itemProductionStatus ?? this.itemProductionStatus,
      itemVoucherStatus: itemVoucherStatus ?? this.itemVoucherStatus,
      DefaultInputTaxLedgerID:
          DefaultInputTaxLedgerID ?? this.DefaultInputTaxLedgerID,
      DefaultOutputTaxLedgerID:
          DefaultOutputTaxLedgerID ?? this.DefaultOutputTaxLedgerID,
      DefaultSalesReturnLedgerID:
          DefaultSalesReturnLedgerID ?? this.DefaultSalesReturnLedgerID,
      DefaultPurchaseReturnLedgerID:
          DefaultPurchaseReturnLedgerID ?? this.DefaultPurchaseReturnLedgerID,
      TaxClassID: TaxClassID ?? this.TaxClassID,
      TechnicianID: TechnicianID ?? this.TechnicianID,
      drQty: drQty ?? this.drQty,
      crQty: crQty ?? this.crQty,
      consumedQty: consumedQty ?? this.consumedQty,
      orderedQty: orderedQty ?? this.orderedQty,
      quantity: quantity ?? this.quantity,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      calculatedQty: calculatedQty ?? this.calculatedQty,
      requestQty: requestQty ?? this.requestQty,
      prevQty: prevQty ?? this.prevQty,
      currQty: currQty ?? this.currQty,
      billedQty: discQuantity ?? billedQty,
      actualQty: quantityFull ?? actualQty,
      hsnCode: hsnCode ?? this.hsnCode,
      section: section ?? this.section,
      flags: flags ?? this.flags,
      fromExternal: fromExternal ?? this.fromExternal,
      action: action ?? this.action,
      orderCompletedDate: orderCompletedDate ?? this.orderCompletedDate,
      manufactureDate: manufactureDate ?? this.manufactureDate,
      expiry: expiry ?? this.expiry,
      isStockItem: isStockItem ?? this.isStockItem,
      category: category ?? this.category,
      defaultLedgerId: defaultLedgerId ?? this.defaultLedgerId,
      location: location ?? this.location,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ItemName': ItemName,
      'ItemNameArabic': ItemNameArabic,
      'GroupName': GroupName,
      'GroupID': GroupID,
      'ItemID': ItemID,
      'ItemAlias': ItemAlias,
      'ItemCode': ItemCode,
      'narration': narration,
      'stdCost': stdCost,
      'Dimension': Dimension,
      'price': rate,
      'price_1': rate,
      'price_2': price_2,
      'priceLastPurchase': priceLastPurchase,
      'discount': discount,
      'discountinAmount': discountinAmount,
      'discountPercentage': discountPercentage,
      'subTotal': subTotal,
      'grandTotal': grandTotal,
      'moq': moq,
      'ItemReqUuid': ItemReqUuid,
      'listId': listId,
      'fromGodownID': fromGodownID,
      'toGodownID': toGodownID,
      'godownList': godownList?.map((x) => x.toMap()).toList(),
      'batchList': batchList?.map((x) => x.toMap()).toList(),
      'PriceLevel': PriceLevel,
      'PartNumber': PartNumber,
      'SerailNumber': SerailNumber,
      'OpeningStock': OpeningStock,
      'ClosingStock': ClosingStock,
      'OpeningStockDate': OpeningStockDate?.millisecondsSinceEpoch,
      'OpeningStockValue': OpeningStockValue,
      'OpeningStockPrice': OpeningStockPrice,
      'ReorderLevel': ReorderLevel,
      'defaultSalesLedgerID': defaultSalesLedgerID,
      'defaultPurchaseLedgerID': defaultPurchaseLedgerID,
      'ProjectID': ProjectID,
      'brandID': brandID,
      'brandName': brandName,
      'taxRate': taxRate,
      'taxAmount': taxAmount,
      'defaultUOMID': defaultUOMID,
      'uomObject': uomObject?.toMap(),
      'priceListID': priceListID,
      'priceListName': priceListName,
      'lastModified': lastModified?.millisecondsSinceEpoch,
      'dateCreated': dateCreated?.millisecondsSinceEpoch,
      'fromTime': fromTime?.millisecondsSinceEpoch,
      'toTime': toTime?.millisecondsSinceEpoch,
      'createdBy': createdBy,
      'bomList': bomList?.map((x) => x.toMap()).toList(),
      'ItemDescription': ItemDescription,
      'length': length,
      'warrantyDays': warrantyDays,
      'shelfLife': shelfLife,
      'IsCompoundItem': IsCompoundItem,
      'isCustomItem': isCustomItem,
      'isPurchaseItem': isPurchaseItem,
      'isSalesItem': isSalesItem,
      'isSerailNumbered': isSerailNumbered,
      'isBatchProcessed': isBatchProcessed,
      'removeItem': removeItem,
      'isService': isService,
      'isProductionItem': isProductionItem,
      'setPriceBatchwise': setPriceBatchwise,
      'isPerishable': isPerishable,
      'favo': favo,
      'itemPriceEditted': itemPriceEditted,
      'KOTPrinter': KOTPrinter,
      'itemProductionStatus': itemProductionStatus,
      'itemVoucherStatus': itemVoucherStatus,
      'DefaultInputTaxLedgerID': DefaultInputTaxLedgerID,
      'DefaultOutputTaxLedgerID': DefaultOutputTaxLedgerID,
      'DefaultSalesReturnLedgerID': DefaultSalesReturnLedgerID,
      'DefaultPurchaseReturnLedgerID': DefaultPurchaseReturnLedgerID,
      'TaxClassID': TaxClassID,
      'TechnicianID': TechnicianID,
      'drQty': drQty,
      'crQty': crQty,
      'consumedQty': consumedQty,
      'orderedQty': orderedQty,
      'quantity': quantity,
      'maxQuantity': maxQuantity,
      'calculatedQty': calculatedQty,
      'requestQty': requestQty,
      'prevQty': prevQty,
      'currQty': currQty,
      'discQuantity': billedQty,
      'quantityFull': actualQty,
      'hsnCode': hsnCode,
      'section': section,
      'flags': flags,
      'fromExternal': fromExternal,
      'action': action,
      'orderCompletedDate': orderCompletedDate?.millisecondsSinceEpoch,
      'manufactureDate': manufactureDate?.millisecondsSinceEpoch,
      'expiry': expiry?.millisecondsSinceEpoch,
      'isStockItem': isStockItem,
      'category': category,
      'defaultLedgerId': defaultLedgerId,
      'location': location,
      'weight': weight,
    };
  }

  factory InventoryItemDataModel.fromMap(Map<String, dynamic> map) {
    return InventoryItemDataModel(
      ItemName: map['ItemName'],
      ItemNameArabic: map['ItemNameArabic'],
      GroupName: map['GroupName'],
      GroupID: map['GroupID'],
      ItemID: map['ItemID'],
      ItemAlias: map['ItemAlias'],
      ItemCode: map['ItemCode'],
      narration: map['narration'],
      stdCost: map['stdCost']?.toDouble(),
      Dimension: map['Dimension'],
      stdRate: map['price']?.toDouble(),
      rate: map['price']?.toDouble(),
      price_2: map['price_2']?.toDouble(),
      priceLastPurchase: map['priceLastPurchase']?.toDouble(),
      discount: map['discount']?.toDouble(),
      discountinAmount: map['discountinAmount']?.toDouble(),
      discountPercentage: map['discountPercentage']?.toDouble(),
      subTotal: map['subTotal']?.toDouble(),
      grandTotal: map['grandTotal']?.toDouble(),
      moq: map['moq']?.toDouble(),
      ItemReqUuid: map['ItemReqUuid'],
      listId: map['listId']?.toInt(),
      fromGodownID: map['fromGodownID'],
      toGodownID: map['toGodownID'],
      godownList: List<ItemGodownDataModel>.from(
          map['godownList']?.map((x) => ItemGodownDataModel.fromMap(x))),
      batchList: List<BatchDataModel>.from(
          map['batchList']?.map((x) => BatchDataModel.fromMap(x))),
      PriceLevel: map['PriceLevel'],
      PartNumber: map['PartNumber'],
      SerailNumber: map['SerailNumber'],
      OpeningStock: map['OpeningStock']?.toDouble(),
      ClosingStock: map['ClosingStock']?.toDouble(),
      OpeningStockDate: map['OpeningStockDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['OpeningStockDate'])
          : null,
      OpeningStockValue: map['OpeningStockValue']?.toDouble(),
      OpeningStockPrice: map['OpeningStockPrice']?.toDouble(),
      ReorderLevel: map['ReorderLevel']?.toDouble(),
      defaultSalesLedgerID: map['defaultSalesLedgerID'],
      defaultPurchaseLedgerID: map['defaultPurchaseLedgerID'],
      ProjectID: map['ProjectID'],
      brandID: map['brandID']?.toInt(),
      brandName: map['brandName'],
      taxRate: map['taxRate']?.toDouble(),
      taxAmount: map['taxAmount']?.toDouble(),
      defaultUOMID: map['defaultUOMID'],
      uomObject: map['uomObject'] != null
          ? UOMHiveMOdel.fromMap(map['uomObject'])
          : null,
      priceListID: map['priceListID'],
      priceListName: map['priceListName'],
      lastModified: map['lastModified'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastModified'])
          : null,
      dateCreated: map['dateCreated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateCreated'])
          : null,
      fromTime: map['fromTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['fromTime'])
          : null,
      toTime: map['toTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['toTime'])
          : null,
      createdBy: map['createdBy'],
      bomList: List<BOMDataModel>.from(
          map['bomList']?.map((x) => BOMDataModel.fromMap(x))),
      ItemDescription: map['ItemDescription'],
      length: map['length']?.toDouble(),
      warrantyDays: map['warrantyDays']?.toInt(),
      shelfLife: map['shelfLife']?.toDouble(),
      IsCompoundItem: map['IsCompoundItem'],
      isCustomItem: map['isCustomItem'],
      isPurchaseItem: map['isPurchaseItem'],
      isSalesItem: map['isSalesItem'],
      isSerailNumbered: map['isSerailNumbered'],
      isBatchProcessed: map['isBatchProcessed'],
      removeItem: map['removeItem'],
      isService: map['isService'],
      isProductionItem: map['isProductionItem'],
      setPriceBatchwise: map['setPriceBatchwise'],
      isPerishable: map['isPerishable'],
      favo: map['favo'],
      itemPriceEditted: map['itemPriceEditted'],
      KOTPrinter: map['KOTPrinter'],
      itemProductionStatus: map['itemProductionStatus']?.toInt(),
      itemVoucherStatus: map['itemVoucherStatus']?.toInt(),
      DefaultInputTaxLedgerID: map['DefaultInputTaxLedgerID'],
      DefaultOutputTaxLedgerID: map['DefaultOutputTaxLedgerID'],
      DefaultSalesReturnLedgerID: map['DefaultSalesReturnLedgerID'],
      DefaultPurchaseReturnLedgerID: map['DefaultPurchaseReturnLedgerID'],
      TaxClassID: map['TaxClassID']?.toInt(),
      TechnicianID: map['TechnicianID']?.toInt(),
      drQty: map['drQty']?.toDouble(),
      crQty: map['crQty']?.toDouble(),
      consumedQty: map['consumedQty']?.toDouble(),
      orderedQty: map['orderedQty']?.toDouble(),
      quantity: map['quantity']?.toDouble(),
      maxQuantity: map['maxQuantity']?.toDouble(),
      calculatedQty: map['calculatedQty']?.toDouble(),
      requestQty: map['requestQty']?.toDouble(),
      prevQty: map['prevQty']?.toDouble(),
      currQty: map['currQty']?.toDouble(),
      billedQty: map['discQuantity']?.toDouble(),
      actualQty: map['quantityFull']?.toDouble(),
      hsnCode: map['hsnCode'],
      section: map['section'],
      flags: map['flags'],
      fromExternal: map['fromExternal'],
      action: map['action']?.toInt(),
      orderCompletedDate: map['orderCompletedDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['orderCompletedDate'])
          : null,
      manufactureDate: map['manufactureDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['manufactureDate'])
          : null,
      expiry: map['expiry'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expiry'])
          : null,
      isStockItem: map['isStockItem'],
      category: map['category'],
      defaultLedgerId: map['defaultLedgerId'],
      location: map['location'],
      weight: map['weight']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryItemDataModel.fromJson(String source) =>
      InventoryItemDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryItemDataModel(ItemName: $ItemName, ItemNameArabic: $ItemNameArabic, GroupName: $GroupName, GroupID: $GroupID, ItemID: $ItemID, ItemAlias: $ItemAlias, ItemCode: $ItemCode, narration: $narration, stdCost: $stdCost, Dimension: $Dimension, price: $stdRate, price_1: $rate, price_2: $price_2, priceLastPurchase: $priceLastPurchase, discount: $discount, discountinAmount: $discountinAmount, discountPercentage: $discountPercentage, subTotal: $subTotal, grandTotal: $grandTotal, moq: $moq, ItemReqUuid: $ItemReqUuid, listId: $listId, fromGodownID: $fromGodownID, toGodownID: $toGodownID, godownList: $godownList, batchList: $batchList, PriceLevel: $PriceLevel, PartNumber: $PartNumber, SerailNumber: $SerailNumber, OpeningStock: $OpeningStock, ClosingStock: $ClosingStock, OpeningStockDate: $OpeningStockDate, OpeningStockValue: $OpeningStockValue, OpeningStockPrice: $OpeningStockPrice, ReorderLevel: $ReorderLevel, defaultSalesLedgerID: $defaultSalesLedgerID, defaultPurchaseLedgerID: $defaultPurchaseLedgerID, ProjectID: $ProjectID, brandID: $brandID, brandName: $brandName, taxRate: $taxRate, taxAmount: $taxAmount, defaultUOMID: $defaultUOMID, uomObject: $uomObject, priceListID: $priceListID, priceListName: $priceListName, lastModified: $lastModified, dateCreated: $dateCreated, fromTime: $fromTime, toTime: $toTime, createdBy: $createdBy, bomList: $bomList, ItemDescription: $ItemDescription, length: $length, warrantyDays: $warrantyDays, shelfLife: $shelfLife, IsCompoundItem: $IsCompoundItem, isCustomItem: $isCustomItem, isPurchaseItem: $isPurchaseItem, isSalesItem: $isSalesItem, isSerailNumbered: $isSerailNumbered, isBatchProcessed: $isBatchProcessed, removeItem: $removeItem, isService: $isService, isProductionItem: $isProductionItem, setPriceBatchwise: $setPriceBatchwise, isPerishable: $isPerishable, favo: $favo, itemPriceEditted: $itemPriceEditted, KOTPrinter: $KOTPrinter, itemProductionStatus: $itemProductionStatus, itemVoucherStatus: $itemVoucherStatus, DefaultInputTaxLedgerID: $DefaultInputTaxLedgerID, DefaultOutputTaxLedgerID: $DefaultOutputTaxLedgerID, DefaultSalesReturnLedgerID: $DefaultSalesReturnLedgerID, DefaultPurchaseReturnLedgerID: $DefaultPurchaseReturnLedgerID, TaxClassID: $TaxClassID, TechnicianID: $TechnicianID, drQty: $drQty, crQty: $crQty, consumedQty: $consumedQty, orderedQty: $orderedQty, quantity: $quantity, maxQuantity: $maxQuantity, calculatedQty: $calculatedQty, requestQty: $requestQty, prevQty: $prevQty, currQty: $currQty, discQuantity: $billedQty, quantityFull: $actualQty, hsnCode: $hsnCode, section: $section, flags: $flags,  fromExternal: $fromExternal, action: $action, orderCompletedDate: $orderCompletedDate, manufactureDate: $manufactureDate, expiry: $expiry, isStockItem: $isStockItem, category: $category, defaultLedgerId: $defaultLedgerId, location: $location, weight: $weight)';
  }

  @override
  List<Object?> get props {
    return [
      ItemName,
      ItemNameArabic,
      GroupName,
      GroupID,
      ItemID,
      ItemAlias,
      ItemCode,
      narration,
      stdCost,
      Dimension,
      stdRate,
      rate,
      price_2,
      priceLastPurchase,
      discount,
      discountinAmount,
      discountPercentage,
      subTotal,
      grandTotal,
      moq,
      ItemReqUuid,
      listId,
      fromGodownID,
      toGodownID,
      godownList,
      batchList,
      PriceLevel,
      PartNumber,
      SerailNumber,
      OpeningStock,
      ClosingStock,
      OpeningStockDate,
      OpeningStockValue,
      OpeningStockPrice,
      ReorderLevel,
      defaultSalesLedgerID,
      defaultPurchaseLedgerID,
      ProjectID,
      brandID,
      brandName,
      taxRate,
      taxAmount,
      defaultUOMID,
      uomObject,
      priceListID,
      priceListName,
      lastModified,
      dateCreated,
      fromTime,
      toTime,
      createdBy,
      bomList,
      ItemDescription,
      length,
      warrantyDays,
      shelfLife,
      IsCompoundItem,
      isCustomItem,
      isPurchaseItem,
      isSalesItem,
      isSerailNumbered,
      isBatchProcessed,
      removeItem,
      isService,
      isProductionItem,
      setPriceBatchwise,
      isPerishable,
      favo,
      itemPriceEditted,
      KOTPrinter,
      itemProductionStatus,
      itemVoucherStatus,
      DefaultInputTaxLedgerID,
      DefaultOutputTaxLedgerID,
      DefaultSalesReturnLedgerID,
      DefaultPurchaseReturnLedgerID,
      TaxClassID,
      TechnicianID,
      drQty,
      crQty,
      consumedQty,
      orderedQty,
      quantity,
      maxQuantity,
      calculatedQty,
      requestQty,
      prevQty,
      currQty,
      billedQty,
      actualQty,
      hsnCode,
      section,
      flags,
      fromExternal,
      action,
      orderCompletedDate,
      manufactureDate,
      expiry,
      isStockItem,
      category,
      defaultLedgerId,
      location,
      weight,
    ];
  }

  void calculate() {
    subTotal = (rate ?? 0) * (quantity ?? 0); //* (uomObject!.convRate ?? 1)
    grossTotal = (subTotal ?? 0) - (discountinAmount ?? 0);
    taxAmount = (grossTotal ?? 0) * (taxRate ?? 0) / 100;
    grandTotal = (grossTotal ?? 0) + (taxAmount ?? 0);
  }

  Map<String, dynamic> toMapForTransTest() {
    // print('uomObject is $uomObject');
    return {
      'Item_ID': ItemID,
      'Item_Name': ItemName,
      'drQty': drQty,
      'crQty': crQty,
      'Quantity': quantity,
      'Price': rate,
      //subtotal changed
      'subTotal': subTotal,
      'Requirement_ItemID': ItemReqUuid,
      'Vat_Rate': taxRate,
      'vatAmount': taxAmount,
      'discountPercentage': discountPercentage,
      'discountinAmount': discountinAmount,
      'Narration': narration,
      'PartNumber': PartNumber,
      'Dimension': Dimension,
      'Price_2': price_2,
      'IsCompoundItem': 0,
      'uomObject': uomObject!.toMapTrans(),
      'batches': batchList?.map((e) => e.toMap()).toList(),
      'fromGodownId': fromGodownID,
      'toGodownId': toGodownID,
    };
  }

  factory InventoryItemDataModel.fromMapForTransTest(
      Map<String, dynamic>? map) {
    if (map == null) return InventoryItemDataModel();
    // print(
    //     'Item  ID is being converted : $map at qty : ${map['Quantity']} total : ${map['']}');

    InventoryItemDataModel item = InventoryItemDataModel(
      ItemID: map['Item_ID'],
      ItemName: map['Item_Name'] ?? '',
      drQty: double.parse(map['drQty'] ?? '0'),
      crQty: double.parse(map['crQty'] ?? '0'),
      quantity: double.parse(map['Quantity'] ?? '0'),
      prevQty: double.parse(map['Quantity'] ?? '0'),
      rate: double.parse(map['Price'] ?? '0'),
      taxRate: double.parse(map['Vat_Rate'] ?? '0'),
      subTotal: double.parse(map['subTotal'] ?? '0'),
      taxAmount: double.parse(map['vatAmount'] ?? '0'),
      grandTotal: double.parse(map['subTotal'] ?? '0') +
          double.parse(map['vatAmount'] ?? '0'),
      discountinAmount: double.parse(map['Discount_Percent'] ?? '0'),
      discountPercentage: double.parse(map['Discount_Amount'] ?? '0'),
      narration: (map['Narration'] ?? '0'),
      GroupName: (map['GroupName']) ?? '0',
      ClosingStock: double.parse(map['ClosingStock'] ?? '0'),
      PartNumber: map['PartNumber'],
      Dimension: map['Dimension'],
      price_2: double.parse(map['Price_2'] ?? '0'),
      ItemReqUuid: map['Requirement_ItemID'] ?? 'X',
      uomObject: UOMHiveMOdel.fromMapTrans(
          map['uomObject'] ?? map['UOMList'][0]), // Changed for Voucher Get
      batchList: map['batches'] != null
          ? List<BatchDataModel>.from(
              map['batches']?.map((x) => BatchDataModel.fromMap(x)))
          : null,
      fromGodownID: map['tromGodownId'],
      toGodownID: map['toGodownId'],
    );
    print('Item Converted');

    return item;
  }

  factory InventoryItemDataModel.fromHive(InventoryItemHive item) {
    print(' Item UOm : ${item.uomObjects}');
    print(item.uomObjects[0]);
    return InventoryItemDataModel(
      ItemID: item.Item_ID,
      ItemName: item.Item_Name,
      taxRate: item.Vat_Rate,
      GroupID: item.Group_Id,
      GroupName: item.Group_Name,
      uomObject: item.uomObjects[0],
      defaultUOMID: item.Default_UOM_ID.toString(),
      rate: item.Price,
      crQty: 0,
      drQty: 0,
      quantity: 0,
      subTotal: 0,
      ItemReqUuid: const Uuid().v4(),
      isSalesItem: item.isSalesItem,
      isPurchaseItem: item.isPurchaseItem,
      isStockItem: item.isStockItem,
      isBatchProcessed: item.isBatchProcessed,
      isSerailNumbered: item.isSerialNumbered,
      hsnCode: item.HSN_CODE,
      brandID: item.Brand_Id,
    );
  }
}
