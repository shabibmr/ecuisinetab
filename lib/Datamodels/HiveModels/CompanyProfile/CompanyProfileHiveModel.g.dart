// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CompanyProfileHiveModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompanyProfileHiveModelAdapter
    extends TypeAdapter<CompanyProfileHiveModel> {
  @override
  final int typeId = 92;

  @override
  CompanyProfileHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyProfileHiveModel()
      ..id = fields[0] as String?
      ..CompanyName = fields[1] as String?
      ..Currency = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, CompanyProfileHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.CompanyName)
      ..writeByte(2)
      ..write(obj.Currency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyProfileHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
