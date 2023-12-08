// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactsDataModelAdapter extends TypeAdapter<ContactsDataModel> {
  @override
  final int typeId = 81;

  @override
  ContactsDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactsDataModel(
      addressId: fields[1] as String?,
      ContactName: fields[2] as String?,
      ContactUuid: fields[3] as String?,
      PhoneNumber: fields[4] as String?,
      email: fields[5] as String?,
      address: fields[6] as String?,
      route: fields[7] as String?,
      code: fields[8] as String?,
      city: fields[9] as String?,
      country: fields[10] as String?,
      ledgerId: fields[11] as String?,
      CompanyName: fields[12] as String?,
      location: fields[13] as String?,
      EmployeeId: fields[14] as String?,
      DateOfBirth: fields[15] as DateTime?,
      mobileNumber: fields[16] as String?,
      notes: fields[17] as String?,
      Designation: fields[18] as String?,
      DesignationID: fields[19] as String?,
      Building: fields[20] as String?,
      isCompanyEmployee: fields[21] as bool?,
      isIndividual: fields[22] as bool?,
      Type: fields[23] as int?,
      POBox: fields[24] as String?,
      Street: fields[25] as String?,
      Fax: fields[26] as String?,
      LocationDetails: (fields[27] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ContactsDataModel obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.addressId)
      ..writeByte(2)
      ..write(obj.ContactName)
      ..writeByte(3)
      ..write(obj.ContactUuid)
      ..writeByte(4)
      ..write(obj.PhoneNumber)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.route)
      ..writeByte(8)
      ..write(obj.code)
      ..writeByte(9)
      ..write(obj.city)
      ..writeByte(10)
      ..write(obj.country)
      ..writeByte(11)
      ..write(obj.ledgerId)
      ..writeByte(12)
      ..write(obj.CompanyName)
      ..writeByte(13)
      ..write(obj.location)
      ..writeByte(14)
      ..write(obj.EmployeeId)
      ..writeByte(15)
      ..write(obj.DateOfBirth)
      ..writeByte(16)
      ..write(obj.mobileNumber)
      ..writeByte(17)
      ..write(obj.notes)
      ..writeByte(18)
      ..write(obj.Designation)
      ..writeByte(19)
      ..write(obj.DesignationID)
      ..writeByte(20)
      ..write(obj.Building)
      ..writeByte(21)
      ..write(obj.isCompanyEmployee)
      ..writeByte(22)
      ..write(obj.isIndividual)
      ..writeByte(23)
      ..write(obj.Type)
      ..writeByte(24)
      ..write(obj.POBox)
      ..writeByte(25)
      ..write(obj.Street)
      ..writeByte(26)
      ..write(obj.Fax)
      ..writeByte(27)
      ..write(obj.LocationDetails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactsDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
