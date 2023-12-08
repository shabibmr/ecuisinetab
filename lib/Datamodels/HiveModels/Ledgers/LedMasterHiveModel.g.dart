// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LedMasterHiveModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LedgerMasterHiveModelAdapter extends TypeAdapter<LedgerMasterHiveModel> {
  @override
  final int typeId = 21;

  @override
  LedgerMasterHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LedgerMasterHiveModel(
      LEDGER_ID: fields[0] as String?,
      Ledger_Name: fields[1] as String?,
      Ledger_Type: fields[2] as String?,
      Group_Id: fields[3] as String?,
      Opening_Balance: fields[4] as double?,
      Opening_Balance_Date: fields[5] as DateTime?,
      Closing_Balance: fields[6] as double?,
      Turn_Over: fields[7] as double?,
      isIndividual: fields[8] as bool?,
      Narration: fields[9] as String?,
      City: fields[10] as String?,
      Address: fields[11] as String?,
      Email: fields[12] as String?,
      Phone_Number: fields[13] as String?,
      Contact_Person_Name: fields[14] as String?,
      Mobile_Number: fields[15] as String?,
      Website: fields[16] as String?,
      Primary_Contact_PersonID: fields[17] as String?,
      Contant_Person_Number: fields[18] as String?,
      PoBox: fields[19] as String?,
      Country: fields[20] as String?,
      Registration_Number: fields[21] as String?,
      Default_Price_List_Id: fields[22] as String?,
      State: fields[23] as String?,
      Birth_Date: fields[24] as DateTime?,
      Credit_Period: fields[25] as int?,
      ParentCompany: fields[26] as String?,
      Fax: fields[27] as String?,
      creditAllowed: fields[28] as double?,
      paymentTerms: fields[29] as String?,
      Tax_Rate: fields[30] as double?,
      Type_Of_Supply: fields[31] as String?,
      Default_Tax_Ledger: fields[32] as String?,
      TRN: fields[33] as String?,
      DefaultRecord: fields[34] as bool?,
      DbName: fields[35] as String?,
      crAmount: fields[36] as double?,
      drAmount: fields[37] as double?,
      amount: fields[38] as double?,
      latitude: fields[39] as num?,
      longitude: fields[40] as num?,
      defaultDiscount: fields[41] as double?,
      isFrequent: fields[42] as bool?,
      routeID: fields[43] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LedgerMasterHiveModel obj) {
    writer
      ..writeByte(44)
      ..writeByte(0)
      ..write(obj.LEDGER_ID)
      ..writeByte(1)
      ..write(obj.Ledger_Name)
      ..writeByte(2)
      ..write(obj.Ledger_Type)
      ..writeByte(3)
      ..write(obj.Group_Id)
      ..writeByte(4)
      ..write(obj.Opening_Balance)
      ..writeByte(5)
      ..write(obj.Opening_Balance_Date)
      ..writeByte(6)
      ..write(obj.Closing_Balance)
      ..writeByte(7)
      ..write(obj.Turn_Over)
      ..writeByte(8)
      ..write(obj.isIndividual)
      ..writeByte(9)
      ..write(obj.Narration)
      ..writeByte(10)
      ..write(obj.City)
      ..writeByte(11)
      ..write(obj.Address)
      ..writeByte(12)
      ..write(obj.Email)
      ..writeByte(13)
      ..write(obj.Phone_Number)
      ..writeByte(14)
      ..write(obj.Contact_Person_Name)
      ..writeByte(15)
      ..write(obj.Mobile_Number)
      ..writeByte(16)
      ..write(obj.Website)
      ..writeByte(17)
      ..write(obj.Primary_Contact_PersonID)
      ..writeByte(18)
      ..write(obj.Contant_Person_Number)
      ..writeByte(19)
      ..write(obj.PoBox)
      ..writeByte(20)
      ..write(obj.Country)
      ..writeByte(21)
      ..write(obj.Registration_Number)
      ..writeByte(22)
      ..write(obj.Default_Price_List_Id)
      ..writeByte(23)
      ..write(obj.State)
      ..writeByte(24)
      ..write(obj.Birth_Date)
      ..writeByte(25)
      ..write(obj.Credit_Period)
      ..writeByte(26)
      ..write(obj.ParentCompany)
      ..writeByte(27)
      ..write(obj.Fax)
      ..writeByte(28)
      ..write(obj.creditAllowed)
      ..writeByte(29)
      ..write(obj.paymentTerms)
      ..writeByte(30)
      ..write(obj.Tax_Rate)
      ..writeByte(31)
      ..write(obj.Type_Of_Supply)
      ..writeByte(32)
      ..write(obj.Default_Tax_Ledger)
      ..writeByte(33)
      ..write(obj.TRN)
      ..writeByte(34)
      ..write(obj.DefaultRecord)
      ..writeByte(35)
      ..write(obj.DbName)
      ..writeByte(36)
      ..write(obj.crAmount)
      ..writeByte(37)
      ..write(obj.drAmount)
      ..writeByte(38)
      ..write(obj.amount)
      ..writeByte(39)
      ..write(obj.latitude)
      ..writeByte(40)
      ..write(obj.longitude)
      ..writeByte(41)
      ..write(obj.defaultDiscount)
      ..writeByte(42)
      ..write(obj.isFrequent)
      ..writeByte(43)
      ..write(obj.routeID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LedgerMasterHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
