// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_group_datamodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserGroupDataModelAdapter extends TypeAdapter<UserGroupDataModel> {
  @override
  final int typeId = 95;

  @override
  UserGroupDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserGroupDataModel(
      id: fields[0] as int,
      UserGroupName: fields[1] as String,
      permissions: (fields[2] as Map?)?.cast<dynamic, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserGroupDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.UserGroupName)
      ..writeByte(2)
      ..write(obj.permissions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserGroupDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
