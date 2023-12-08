// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PriceListMasterHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriceListMasterHiveAdapter extends TypeAdapter<PriceListMasterHive> {
  @override
  final int typeId = 41;

  @override
  PriceListMasterHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PriceListMasterHive(
      priceListID: fields[0] as int?,
      priceListName: fields[1] as String?,
      priceListStartDate: fields[2] as DateTime?,
      priceListEndDate: fields[3] as DateTime?,
      priceListDefault: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PriceListMasterHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.priceListID)
      ..writeByte(1)
      ..write(obj.priceListName)
      ..writeByte(2)
      ..write(obj.priceListStartDate)
      ..writeByte(3)
      ..write(obj.priceListEndDate)
      ..writeByte(4)
      ..write(obj.priceListDefault);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceListMasterHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
