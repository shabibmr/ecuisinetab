// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AccountGroupHiveModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountGroupHiveModelAdapter extends TypeAdapter<AccountGroupHiveModel> {
  @override
  final int typeId = 26;

  @override
  AccountGroupHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountGroupHiveModel(
      Group_ID: fields[0] as String?,
      Group_Name: fields[1] as String?,
      Parent_ID: fields[2] as String?,
      Group_Type: fields[3] as String?,
      Group_Category: fields[4] as String?,
      DefaultRecord: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, AccountGroupHiveModel obj) {
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
      ..write(obj.Group_Category)
      ..writeByte(5)
      ..write(obj.DefaultRecord);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountGroupHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
