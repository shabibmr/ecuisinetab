// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InventorygroupHiveModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InventorygroupHiveModelAdapter
    extends TypeAdapter<InventorygroupHiveModel> {
  @override
  final int typeId = 12;

  @override
  InventorygroupHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InventorygroupHiveModel(
      Group_ID: fields[0] as String?,
      Group_Name: fields[1] as String?,
      Parent_ID: fields[2] as String?,
      Group_Type: fields[3] as String?,
      GroupNameArabic: fields[4] as String?,
      Group_Name_Arabic: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InventorygroupHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.Group_ID)
      ..writeByte(1)
      ..write(obj.Group_Name)
      ..writeByte(2)
      ..write(obj.Parent_ID)
      ..writeByte(3)
      ..write(obj.Group_Type)
      ..writeByte(4)
      ..write(obj.GroupNameArabic)
      ..writeByte(5)
      ..write(obj.Group_Name_Arabic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventorygroupHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
