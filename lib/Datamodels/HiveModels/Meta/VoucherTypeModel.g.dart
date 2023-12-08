// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VoucherTypeModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VoucherTypeModelAdapter extends TypeAdapter<VoucherTypeModel> {
  @override
  final int typeId = 18;

  @override
  VoucherTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VoucherTypeModel(
      id: fields[0] as int,
      voucherType: fields[1] as String?,
      voucherPrefix: fields[2] as String?,
      data: (fields[3] as Map?)?.cast<dynamic, dynamic>(),
      timeStamp: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, VoucherTypeModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.voucherType)
      ..writeByte(2)
      ..write(obj.voucherPrefix)
      ..writeByte(3)
      ..write(obj.data)
      ..writeByte(4)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VoucherTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
