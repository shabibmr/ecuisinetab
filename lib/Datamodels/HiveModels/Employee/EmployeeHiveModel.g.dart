// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EmployeeHiveModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeHiveModelAdapter extends TypeAdapter<EmployeeHiveModel> {
  @override
  final int typeId = 51;

  @override
  EmployeeHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeHiveModel(
      id: fields[0] as int?,
      Name: fields[1] as String?,
      Email: fields[2] as String?,
      Phone: fields[3] as String?,
      Address: fields[4] as String?,
      Employee_ID: fields[5] as String?,
      Designation: fields[6] as String?,
      Department: fields[7] as String?,
      UserName: fields[8] as String?,
      Password: fields[9] as String?,
      UserGroupID: fields[10] as int?,
      privilege: fields[11] as int?,
      Show_Employee: fields[12] as bool?,
      BioMetricID: fields[13] as String?,
      JoinDate: fields[14] as DateTime?,
      email: fields[15] as String?,
      emergencyContact: fields[16] as String?,
      salary_ledger: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeHiveModel obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.Name)
      ..writeByte(2)
      ..write(obj.Email)
      ..writeByte(3)
      ..write(obj.Phone)
      ..writeByte(4)
      ..write(obj.Address)
      ..writeByte(5)
      ..write(obj.Employee_ID)
      ..writeByte(6)
      ..write(obj.Designation)
      ..writeByte(7)
      ..write(obj.Department)
      ..writeByte(8)
      ..write(obj.UserName)
      ..writeByte(9)
      ..write(obj.Password)
      ..writeByte(10)
      ..write(obj.UserGroupID)
      ..writeByte(11)
      ..write(obj.privilege)
      ..writeByte(12)
      ..write(obj.Show_Employee)
      ..writeByte(13)
      ..write(obj.BioMetricID)
      ..writeByte(14)
      ..write(obj.JoinDate)
      ..writeByte(15)
      ..write(obj.email)
      ..writeByte(16)
      ..write(obj.emergencyContact)
      ..writeByte(17)
      ..write(obj.salary_ledger);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
