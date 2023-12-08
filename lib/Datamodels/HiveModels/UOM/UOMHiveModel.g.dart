// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UOMHiveModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UOMHiveMOdelAdapter extends TypeAdapter<UOMHiveMOdel> {
  @override
  final int typeId = 31;

  @override
  UOMHiveMOdel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UOMHiveMOdel(
      UOM_id: fields[0] as int?,
      uom_Name: fields[1] as String?,
      uom_symbol: fields[2] as String?,
      UOM_decimal_Points: fields[3] as int?,
      UOM_Narration: fields[4] as String?,
      timestamp: fields[5] as DateTime?,
      convRate: fields[6] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, UOMHiveMOdel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.UOM_id)
      ..writeByte(1)
      ..write(obj.uom_Name)
      ..writeByte(2)
      ..write(obj.uom_symbol)
      ..writeByte(3)
      ..write(obj.UOM_decimal_Points)
      ..writeByte(4)
      ..write(obj.UOM_Narration)
      ..writeByte(5)
      ..write(obj.timestamp)
      ..writeByte(6)
      ..write(obj.convRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UOMHiveMOdelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
