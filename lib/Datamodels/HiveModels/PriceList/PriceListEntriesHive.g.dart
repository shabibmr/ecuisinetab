// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PriceListEntriesHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriceListEntriesHiveAdapter extends TypeAdapter<PriceListEntriesHive> {
  @override
  final int typeId = 42;

  @override
  PriceListEntriesHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PriceListEntriesHive(
      rate: fields[0] as double?,
      priceListID: fields[1] as int?,
      timestamp: fields[2] as DateTime?,
      percent: fields[3] as double?,
      uomID: fields[4] as int?,
      priceListName: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PriceListEntriesHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.rate)
      ..writeByte(1)
      ..write(obj.priceListID)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.percent)
      ..writeByte(4)
      ..write(obj.uomID)
      ..writeByte(5)
      ..write(obj.priceListName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceListEntriesHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
