// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UOMConvHiveModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UOMConvHiveModelAdapter extends TypeAdapter<UOMConvHiveModel> {
  @override
  final int typeId = 32;

  @override
  UOMConvHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UOMConvHiveModel(
      baseUnit: fields[1] as int?,
      toUnit: fields[2] as int?,
      conValue: fields[3] as double?,
      itemID: fields[4] as String?,
      narration: fields[5] as String?,
      barcode: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UOMConvHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.baseUnit)
      ..writeByte(2)
      ..write(obj.toUnit)
      ..writeByte(3)
      ..write(obj.conValue)
      ..writeByte(4)
      ..write(obj.itemID)
      ..writeByte(5)
      ..write(obj.narration)
      ..writeByte(6)
      ..write(obj.barcode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UOMConvHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
