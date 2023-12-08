// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GodownHiveModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GodownHiveModelAdapter extends TypeAdapter<GodownHiveModel> {
  @override
  final int typeId = 61;

  @override
  GodownHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GodownHiveModel(
      Godown_ID: fields[0] as String?,
      Godown_Name: fields[1] as String?,
      Godown_Location: fields[2] as String?,
      Godown_Narration: fields[3] as String?,
      isProfitCentre: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, GodownHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.Godown_ID)
      ..writeByte(1)
      ..write(obj.Godown_Name)
      ..writeByte(2)
      ..write(obj.Godown_Location)
      ..writeByte(3)
      ..write(obj.Godown_Narration)
      ..writeByte(4)
      ..write(obj.isProfitCentre);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GodownHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
