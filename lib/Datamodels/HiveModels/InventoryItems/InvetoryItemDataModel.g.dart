// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InvetoryItemDataModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InventoryItemHiveAdapter extends TypeAdapter<InventoryItemHive> {
  @override
  final int typeId = 11;

  @override
  InventoryItemHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InventoryItemHive(
      Item_ID: fields[0] as String?,
      Item_Name: fields[1] as String?,
      Item_Alias: fields[2] as String?,
      Item_Code: fields[3] as String?,
      Group_Id: fields[4] as String?,
      Group_Name: fields[5] as String?,
      Part_Number: fields[6] as String?,
      Price: fields[7] as double?,
      Opening_Stock: fields[8] as double?,
      Opening_Balance: fields[9] as double?,
      Opening_Balance_Date: fields[10] as DateTime?,
      Last_Modified_By: fields[11] as String?,
      Opening_Rate: fields[12] as double?,
      Opening_Value: fields[13] as double?,
      Narration: fields[14] as String?,
      Serial_Number: fields[15] as String?,
      Closing_Stock: fields[16] as double?,
      Reorder_Level: fields[17] as double?,
      Std_Cost: fields[18] as double?,
      Vat_Rate: fields[19] as double?,
      Default_UOM_ID: fields[20] as int?,
      Last_Modified: fields[21] as DateTime?,
      Date_Created: fields[22] as DateTime?,
      Timestamp: fields[23] as DateTime?,
      Warranty_Days: fields[24] as int?,
      Shelf_Life: fields[25] as double?,
      Brand_Id: fields[26] as String?,
      Item_Description: fields[27] as String?,
      isCustomItem: fields[28] as bool?,
      Dimension: fields[29] as String?,
      isPurchaseItem: fields[30] as bool?,
      isSalesItem: fields[31] as bool?,
      KOT_Printer: fields[32] as String?,
      Item_Name_Arabic: fields[33] as String?,
      Favourite: fields[34] as bool?,
      isStockItem: fields[35] as bool?,
      From_Time: fields[36] as DateTime?,
      To_Time: fields[37] as DateTime?,
      Price_2: fields[38] as double?,
      HSN_CODE: fields[39] as String?,
      Section: fields[40] as String?,
      Flags: fields[41] as String?,
      Category: fields[42] as String?,
      DefaultLedgerID: fields[43] as String?,
      uomObjects: (fields[44] as List).cast<UOMHiveMOdel>(),
      prices: (fields[45] as List).cast<PriceListEntriesHive>(),
      isBatchProcessed: fields[46] as bool?,
      isSerialNumbered: fields[47] as bool?,
      isActive: fields[48] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, InventoryItemHive obj) {
    writer
      ..writeByte(49)
      ..writeByte(0)
      ..write(obj.Item_ID)
      ..writeByte(1)
      ..write(obj.Item_Name)
      ..writeByte(2)
      ..write(obj.Item_Alias)
      ..writeByte(3)
      ..write(obj.Item_Code)
      ..writeByte(4)
      ..write(obj.Group_Id)
      ..writeByte(5)
      ..write(obj.Group_Name)
      ..writeByte(6)
      ..write(obj.Part_Number)
      ..writeByte(7)
      ..write(obj.Price)
      ..writeByte(8)
      ..write(obj.Opening_Stock)
      ..writeByte(9)
      ..write(obj.Opening_Balance)
      ..writeByte(10)
      ..write(obj.Opening_Balance_Date)
      ..writeByte(11)
      ..write(obj.Last_Modified_By)
      ..writeByte(12)
      ..write(obj.Opening_Rate)
      ..writeByte(13)
      ..write(obj.Opening_Value)
      ..writeByte(14)
      ..write(obj.Narration)
      ..writeByte(15)
      ..write(obj.Serial_Number)
      ..writeByte(16)
      ..write(obj.Closing_Stock)
      ..writeByte(17)
      ..write(obj.Reorder_Level)
      ..writeByte(18)
      ..write(obj.Std_Cost)
      ..writeByte(19)
      ..write(obj.Vat_Rate)
      ..writeByte(20)
      ..write(obj.Default_UOM_ID)
      ..writeByte(21)
      ..write(obj.Last_Modified)
      ..writeByte(22)
      ..write(obj.Date_Created)
      ..writeByte(23)
      ..write(obj.Timestamp)
      ..writeByte(24)
      ..write(obj.Warranty_Days)
      ..writeByte(25)
      ..write(obj.Shelf_Life)
      ..writeByte(26)
      ..write(obj.Brand_Id)
      ..writeByte(27)
      ..write(obj.Item_Description)
      ..writeByte(28)
      ..write(obj.isCustomItem)
      ..writeByte(29)
      ..write(obj.Dimension)
      ..writeByte(30)
      ..write(obj.isPurchaseItem)
      ..writeByte(31)
      ..write(obj.isSalesItem)
      ..writeByte(32)
      ..write(obj.KOT_Printer)
      ..writeByte(33)
      ..write(obj.Item_Name_Arabic)
      ..writeByte(34)
      ..write(obj.Favourite)
      ..writeByte(35)
      ..write(obj.isStockItem)
      ..writeByte(36)
      ..write(obj.From_Time)
      ..writeByte(37)
      ..write(obj.To_Time)
      ..writeByte(38)
      ..write(obj.Price_2)
      ..writeByte(39)
      ..write(obj.HSN_CODE)
      ..writeByte(40)
      ..write(obj.Section)
      ..writeByte(41)
      ..write(obj.Flags)
      ..writeByte(42)
      ..write(obj.Category)
      ..writeByte(43)
      ..write(obj.DefaultLedgerID)
      ..writeByte(44)
      ..write(obj.uomObjects)
      ..writeByte(45)
      ..write(obj.prices)
      ..writeByte(46)
      ..write(obj.isBatchProcessed)
      ..writeByte(47)
      ..write(obj.isSerialNumbered)
      ..writeByte(48)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryItemHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
