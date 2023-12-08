// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../../Datamodels/HiveModels/PriceList/PriceListEntriesHive.dart';
import '../../../../../Datamodels/HiveModels/UOM/UOMHiveModel.dart';

part 'InvetoryItemDataModel.g.dart';

@HiveType(typeId: 11)
class InventoryItemHive extends HiveObject with EquatableMixin {
  @HiveField(0)
  String? Item_ID;
  @HiveField(1)
  String? Item_Name;
  @HiveField(2)
  String? Item_Alias;
  @HiveField(3)
  String? Item_Code;
  @HiveField(4)
  String? Group_Id;
  @HiveField(5)
  String? Group_Name;
  @HiveField(6)
  String? Part_Number;
  @HiveField(7)
  double? Price;
  @HiveField(8)
  double? Opening_Stock;
  @HiveField(9)
  double? Opening_Balance;
  @HiveField(10)
  DateTime? Opening_Balance_Date;
  @HiveField(11)
  String? Last_Modified_By;
  @HiveField(12)
  double? Opening_Rate;
  @HiveField(13)
  double? Opening_Value;
  @HiveField(14)
  String? Narration;
  @HiveField(15)
  String? Serial_Number;
  @HiveField(16)
  double? Closing_Stock;
  @HiveField(17)
  double? Reorder_Level;
  @HiveField(18)
  double? Std_Cost;
  @HiveField(19)
  double? Vat_Rate;
  @HiveField(20)
  int? Default_UOM_ID;
  @HiveField(21)
  DateTime? Last_Modified;
  @HiveField(22)
  DateTime? Date_Created;
  @HiveField(23)
  DateTime? Timestamp;
  @HiveField(24)
  int? Warranty_Days;
  @HiveField(25)
  double? Shelf_Life;
  @HiveField(26)
  String? Brand_Id;
  @HiveField(27)
  String? Item_Description;
  @HiveField(28)
  bool? isCustomItem;
  @HiveField(29)
  String? Dimension;
  @HiveField(30)
  bool? isPurchaseItem;
  @HiveField(31)
  bool? isSalesItem;
  @HiveField(32)
  String? KOT_Printer;
  @HiveField(33)
  String? Item_Name_Arabic;
  @HiveField(34)
  bool? Favourite;
  @HiveField(35)
  bool? isStockItem;
  @HiveField(36)
  DateTime? From_Time;
  @HiveField(37)
  DateTime? To_Time;
  @HiveField(38)
  double? Price_2;
  @HiveField(39)
  String? HSN_CODE;
  @HiveField(40)
  String? Section;
  @HiveField(41)
  String? Flags;
  @HiveField(42)
  String? Category;
  @HiveField(43)
  String? DefaultLedgerID;
  @HiveField(44)
  List<UOMHiveMOdel> uomObjects;
  @HiveField(45)
  List<PriceListEntriesHive> prices;
  @HiveField(46)
  bool? isBatchProcessed;
  @HiveField(47)
  bool? isSerialNumbered;
  @HiveField(48)
  bool? isActive;

  InventoryItemHive({
    this.Item_ID,
    this.Item_Name,
    this.Item_Alias,
    this.Item_Code,
    this.Group_Id,
    this.Group_Name,
    this.Part_Number,
    this.Price,
    this.Opening_Stock,
    this.Opening_Balance,
    this.Opening_Balance_Date,
    this.Last_Modified_By,
    this.Opening_Rate,
    this.Opening_Value,
    this.Narration,
    this.Serial_Number,
    this.Closing_Stock,
    this.Reorder_Level,
    this.Std_Cost,
    this.Vat_Rate,
    this.Default_UOM_ID,
    this.Last_Modified,
    this.Date_Created,
    this.Timestamp,
    this.Warranty_Days,
    this.Shelf_Life,
    this.Brand_Id,
    this.Item_Description,
    this.isCustomItem,
    this.Dimension,
    this.isPurchaseItem,
    this.isSalesItem,
    this.KOT_Printer,
    this.Item_Name_Arabic,
    this.Favourite,
    this.isStockItem,
    this.From_Time,
    this.To_Time,
    this.Price_2,
    this.HSN_CODE,
    this.Section,
    this.Flags,
    this.Category,
    this.DefaultLedgerID,
    this.uomObjects = const [],
    this.prices = const [],
    this.isBatchProcessed,
    this.isSerialNumbered,
    this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'BaseItem': {
        'Item_ID': Item_ID,
        'Item_Name': Item_Name,
        'Item_Alias': Item_Alias,
        'Item_Code': Item_Code,
        'GroupID': Group_Id,
        'Group_Name': Group_Name,
        'Part_Number': Part_Number,
        'Price': Price,
        'Opening_Stock': Opening_Stock,
        'Opening_Balance': Opening_Balance,
        'Opening_Balance_Date': Opening_Balance_Date?.millisecondsSinceEpoch,
        'Last_Modified_By': Last_Modified_By,
        'Opening_Rate': Opening_Rate,
        'Opening_Value': Opening_Value,
        'Narration': Narration,
        'Serial_Number': Serial_Number,
        'Closing_Stock': Closing_Stock,
        'Reorder_Level': Reorder_Level,
        'Std_Cost': Std_Cost,
        'Vat_Rate': Vat_Rate,
        'Default_UOM_ID': Default_UOM_ID,
        'Last_Modified': Last_Modified?.millisecondsSinceEpoch,
        'Date_Created': Date_Created?.millisecondsSinceEpoch,
        'Timestamp': Timestamp?.millisecondsSinceEpoch,
        'Warranty_Days': Warranty_Days,
        'Shelf_Life': Shelf_Life,
        'Brand_Id': Brand_Id,
        'Item_Description': Item_Description,
        'isCustomItem': isCustomItem,
        'Dimension': Dimension,
        'isPurchaseItem': isPurchaseItem,
        'isSalesItem': isSalesItem,
        'KOT_Printer': KOT_Printer,
        'Item_Name_Arabic': Item_Name_Arabic,
        'Favourite': Favourite,
        'isStockItem': isStockItem,
        'From_Time': From_Time?.millisecondsSinceEpoch,
        'To_Time': To_Time?.millisecondsSinceEpoch,
        'Price_2': Price_2,
        'HSN_CODE': HSN_CODE,
        'Section': Section,
        'Flags': Flags,
        'Category': Category,
        'DefaultLedgerID': DefaultLedgerID,
        'uomObject': uomObjects[0].toMapMasters(),
        'PriceLists': prices.map((x) => x.toMap()).toList(),
        'isBatchProcessed': isBatchProcessed,
        'isSerailNumbered': isSerialNumbered,
      }
    };
  }

  factory InventoryItemHive.fromMap(Map<String, dynamic> map) {
    return InventoryItemHive(
      Item_ID: map['Item_ID'] ?? "",
      Item_Name: map['Item_Name'],
      Item_Alias: map['Item_Alias'],
      Item_Code: map['Item_Code'],
      Group_Id: map['GroupID'],
      Group_Name: map['GroupName'],
      Part_Number: map['Part_Number'],
      Price: double.parse(map['price'] ?? "0"),
      Opening_Stock: double.parse(map['Opening_Stock'] ?? "0"),
      Opening_Balance: double.parse(map['Opening_Balance'] ?? "0"),
      // Opening_Balance_Date:
      //     DateTime.fromMillisecondsSinceEpoch(map['Opening_Balance_Date']),
      Last_Modified_By: map['Last_Modified_By'],
      Opening_Rate: double.parse(map['Opening_Rate'] ?? "0"),
      Opening_Value: double.parse(map['Opening_Value'] ?? "0"),
      Narration: map['Narration'],
      Serial_Number: map['Serial_Number'],
      Closing_Stock: double.parse(map['Closing_Stock'] ?? "0"),
      Reorder_Level: double.parse(map['Reorder_Level'] ?? "0"),
      Std_Cost: double.parse(map['std_cost'] ?? "0"),
      Vat_Rate: double.parse(map['Vat_Rate'] ?? "0"),
      Default_UOM_ID: int.parse(map['Default_UOM_ID'] ?? "1"),
      uomObjects: map['UOMList'] != null
          ? List<UOMHiveMOdel>.from(
              (map['UOMList'] as List<dynamic>).map<UOMHiveMOdel?>(
                (x) => UOMHiveMOdel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : map['uomObject'] != null
              ? [UOMHiveMOdel.fromMap(map['uomObject'])]
              : [],
      prices: map['PriceLists'] != null
          ? List<PriceListEntriesHive>.from(
              (map['PriceLists'] as List<dynamic>).map<PriceListEntriesHive?>(
                (x) => PriceListEntriesHive.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      // Last_Modified: DateTime.fromMillisecondsSinceEpoch(map['Last_Modified']),
      // Date_Created: DateTime.fromMillisecondsSinceEpoch(map['Date_Created']),
      // Timestamp: DateTime.fromMillisecondsSinceEpoch(map['Timestamp']),
      // Warranty_Days: int.parse(['Warranty_Days'] ?? "0"),
      // Shelf_Life: double.parse(map['Shelf_Life'] ?? "0"),
      // Brand_Id: map['Brand_Id'],
      // Item_Description: map['Item_Description'],
      // isCustomItem: map['isCustomItem'],
      // Dimension: map['Dimension'],
      isPurchaseItem: (map['isPurchaseItem'] ?? "0") == "1" ? true : false,
      isSalesItem: (map['isSalesItem'] ?? "0") == "1" ? true : false,
      // KOT_Printer: map['KOT_Printer'],
      // Item_Name_Arabic: map['Item_Name_Arabic'],
      // Favourite: map['Favourite'],
      isStockItem: (map['isStockItem'] ?? "0") == "1" ? true : false,
      // // From_Time: DateTime.fromMillisecondsSinceEpoch(map['From_Time']),
      // // To_Time: DateTime.fromMillisecondsSinceEpoch(map['To_Time']),
      // Price_2: double.parse(map['Price_2'] ?? "0"),
      // HSN_CODE: map['HSN_CODE'],
      // Section: map['Section'],
      // // Flags: map['Flags'],
      // Category: map['Category'],
      // DefaultLedgerID: map['DefaultLedgerID'],
      isBatchProcessed: (map['isBatchProcessed'] ?? "0") == "1" ? true : false,
      isSerialNumbered: (map['isSerailNumbered'] ?? "0") == "1" ? true : false,
      isActive: (map['isActive'] ?? "1") == "1" ? true : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryItemHive.fromJson(String source) =>
      InventoryItemHive.fromMap(json.decode(source) as Map<String, dynamic>);

  InventoryItemHive copyWith({
    String? Item_ID,
    String? Item_Name,
    String? Item_Alias,
    String? Item_Code,
    String? Group_Id,
    String? Group_Name,
    String? Part_Number,
    double? Price,
    double? Opening_Stock,
    double? Opening_Balance,
    DateTime? Opening_Balance_Date,
    String? Last_Modified_By,
    double? Opening_Rate,
    double? Opening_Value,
    String? Narration,
    String? Serial_Number,
    double? Closing_Stock,
    double? Reorder_Level,
    double? Std_Cost,
    double? Vat_Rate,
    int? Default_UOM_ID,
    DateTime? Last_Modified,
    DateTime? Date_Created,
    DateTime? Timestamp,
    int? Warranty_Days,
    double? Shelf_Life,
    String? Brand_Id,
    String? Item_Description,
    bool? isCustomItem,
    String? Dimension,
    bool? isPurchaseItem,
    bool? isSalesItem,
    String? KOT_Printer,
    String? Item_Name_Arabic,
    bool? Favourite,
    bool? IsStockItem,
    DateTime? From_Time,
    DateTime? To_Time,
    double? Price_2,
    String? HSN_CODE,
    String? Section,
    String? Flags,
    String? Category,
    String? DefaultLedgerID,
    List<UOMHiveMOdel>? uomObjects,
    List<PriceListEntriesHive>? prices,
    bool? isBatchProcessed,
    bool? isSerialNumbered,
    bool? isActive,
  }) {
    return InventoryItemHive(
      Item_ID: Item_ID ?? this.Item_ID,
      Item_Name: Item_Name ?? this.Item_Name,
      Item_Alias: Item_Alias ?? this.Item_Alias,
      Item_Code: Item_Code ?? this.Item_Code,
      Group_Id: Group_Id ?? this.Group_Id,
      Group_Name: Group_Name ?? this.Group_Name,
      Part_Number: Part_Number ?? this.Part_Number,
      Price: Price ?? this.Price,
      Opening_Stock: Opening_Stock ?? this.Opening_Stock,
      Opening_Balance: Opening_Balance ?? this.Opening_Balance,
      Opening_Balance_Date: Opening_Balance_Date ?? this.Opening_Balance_Date,
      Last_Modified_By: Last_Modified_By ?? this.Last_Modified_By,
      Opening_Rate: Opening_Rate ?? this.Opening_Rate,
      Opening_Value: Opening_Value ?? this.Opening_Value,
      Narration: Narration ?? this.Narration,
      Serial_Number: Serial_Number ?? this.Serial_Number,
      Closing_Stock: Closing_Stock ?? this.Closing_Stock,
      Reorder_Level: Reorder_Level ?? this.Reorder_Level,
      Std_Cost: Std_Cost ?? this.Std_Cost,
      Vat_Rate: Vat_Rate ?? this.Vat_Rate,
      Default_UOM_ID: Default_UOM_ID ?? this.Default_UOM_ID,
      Last_Modified: Last_Modified ?? this.Last_Modified,
      Date_Created: Date_Created ?? this.Date_Created,
      Timestamp: Timestamp ?? this.Timestamp,
      Warranty_Days: Warranty_Days ?? this.Warranty_Days,
      Shelf_Life: Shelf_Life ?? this.Shelf_Life,
      Brand_Id: Brand_Id ?? this.Brand_Id,
      Item_Description: Item_Description ?? this.Item_Description,
      isCustomItem: isCustomItem ?? this.isCustomItem,
      Dimension: Dimension ?? this.Dimension,
      isPurchaseItem: isPurchaseItem ?? this.isPurchaseItem,
      isSalesItem: isSalesItem ?? this.isSalesItem,
      KOT_Printer: KOT_Printer ?? this.KOT_Printer,
      Item_Name_Arabic: Item_Name_Arabic ?? this.Item_Name_Arabic,
      Favourite: Favourite ?? this.Favourite,
      isStockItem: IsStockItem ?? isStockItem,
      From_Time: From_Time ?? this.From_Time,
      To_Time: To_Time ?? this.To_Time,
      Price_2: Price_2 ?? this.Price_2,
      HSN_CODE: HSN_CODE ?? this.HSN_CODE,
      Section: Section ?? this.Section,
      Flags: Flags ?? this.Flags,
      Category: Category ?? this.Category,
      DefaultLedgerID: DefaultLedgerID ?? this.DefaultLedgerID,
      uomObjects: uomObjects ?? this.uomObjects,
      prices: prices ?? this.prices,
      isBatchProcessed: isBatchProcessed ?? this.isBatchProcessed,
      isSerialNumbered: isSerialNumbered ?? this.isSerialNumbered,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props {
    return [
      Item_ID,
      Item_Name,
      Item_Alias,
      Item_Code,
      Group_Id,
      Group_Name,
      Part_Number,
      Price,
      Opening_Stock,
      Opening_Balance,
      Opening_Balance_Date,
      Last_Modified_By,
      Opening_Rate,
      Opening_Value,
      Narration,
      Serial_Number,
      Closing_Stock,
      Reorder_Level,
      Std_Cost,
      Vat_Rate,
      Default_UOM_ID,
      Last_Modified,
      Date_Created,
      Timestamp,
      Warranty_Days,
      Shelf_Life,
      Brand_Id,
      Item_Description,
      isCustomItem,
      Dimension,
      isPurchaseItem,
      isSalesItem,
      KOT_Printer,
      Item_Name_Arabic,
      Favourite,
      isStockItem,
      From_Time,
      To_Time,
      Price_2,
      HSN_CODE,
      Section,
      Flags,
      Category,
      DefaultLedgerID,
      uomObjects,
      prices,
      isBatchProcessed,
      isSerialNumbered,
      isActive,
    ];
  }
}
