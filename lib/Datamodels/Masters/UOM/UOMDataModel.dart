import 'dart:convert';

import 'package:equatable/equatable.dart';

const String TableNameUom = "Uomlist";
const String column_Uom_Id = "Uom_id";
const String column_Uom_Name = "UomName";
const String column_Uom_Symbol = "UomSymbol";
const String column_Uom_Decimal_Pofints = "decimalPofinal int?s";
const String column_Uom_Narration = "Narration";
const String column_Timestamp = "timestamp";

const String col_UOM_Conversion_TableName = "UOM_Conversion";
const String col_UOM_Conversion_id = "_id";
const String col_UOM_Conversion_BaseUnit = "BaseUnit";
const String col_UOM_Conversion_ToUnit = "ToUnit";
const String col_UOM_Conversion_Value = "ConValue";
const String col_UOM_Conversion_Narration = "Narration";
const String col_UOM_Conversion_ItemId = "itemID";

const String uom_subquery = " (SELECT distinct "
    " $col_UOM_Conversion_ItemId , "
    "+ $col_UOM_Conversion_ToUnit  as UOM, "
    " (SELECT  $column_Uom_Name  FROM  $TableNameUom   basetable where "
    " basetable.$column_Uom_Id  = contable.$col_UOM_Conversion_ToUnit ) as UomName, "
    " (SELECT $column_Uom_Symbol FROM $TableNameUom  basetable where "
    " basetable.$column_Uom_Id = contable.$col_UOM_Conversion_ToUnit "
    " ) as UomSymbol, $col_UOM_Conversion_Value  FROM $col_UOM_Conversion_TableName "
    " contable  UNION SELECT B.$col_UOM_Conversion_ItemId ,  case when cast(A."
    " $col_UOM_Conversion_BaseUnit as final int?) = cast(B.$col_UOM_Conversion_ToUnit "
    " as final int?) then A.$col_UOM_Conversion_ToUnit when cast(A.$col_UOM_Conversion_ToUnit "
    " as final int?) = cast(B.$col_UOM_Conversion_ToUnit  as final int?) then "
    " A.$col_UOM_Conversion_BaseUnit else '' END as UOM,  case when "
    " A.$col_UOM_Conversion_BaseUnit = B.$col_UOM_Conversion_ToUnit "
    " then (SELECT $column_Uom_Name FROM $TableNameUom "
    " basetable where basetable.$column_Uom_Id  = A.$col_UOM_Conversion_ToUnit "
    " ) when A.\$col_UOM_Conversion_ToUnit = B.$col_UOM_Conversion_ToUnit "
    " then (SELECT $column_Uom_Name FROM $TableNameUom  basetable where "
    " basetable.$column_Uom_Id = A.$col_UOM_Conversion_BaseUnit ) "
    " else '' END as UomName, case when A.$col_UOM_Conversion_BaseUnit "
    " = B.$col_UOM_Conversion_ToUnit then (SELECT $column_Uom_Symbol "
    " FROM  $TableNameUom  basetable where basetable.$column_Uom_Id "
    " = A.$col_UOM_Conversion_ToUnit ) when A.$col_UOM_Conversion_ToUnit "
    " = B. $col_UOM_Conversion_ToUnit  then (SELECT $column_Uom_Symbol "
    " FROM  $TableNameUom basetable where basetable.$column_Uom_Id "
    " = A.$col_UOM_Conversion_BaseUnit )  else '' END as UomSymbol, "
    " case when cast(A.$col_UOM_Conversion_BaseUnit as final int?) = cast(B."
    " $col_UOM_Conversion_ToUnit as final int?) then B.$col_UOM_Conversion_Value "
    " * A.$col_UOM_Conversion_Value when cast(A.$col_UOM_Conversion_ToUnit "
    " as final int?) = cast(B.$col_UOM_Conversion_ToUnit as final int?) then cast(B."
    "$col_UOM_Conversion_Value / A.$col_UOM_Conversion_Value as decimal(10,3))"
    " else 1 END FROM $col_UOM_Conversion_TableName  A  INNER JOIN "
    " $col_UOM_Conversion_TableName  B ON ( cast(A.$col_UOM_Conversion_BaseUnit "
    " as final int?) = cast(B.$col_UOM_Conversion_ToUnit  as final int?) OR cast(A."
    "$col_UOM_Conversion_ToUnit as final int?) = cast(B.$col_UOM_Conversion_ToUnit "
    " as final int?)) AND A.$col_UOM_Conversion_ItemId  = '' )";

class UOMDataModelObsolete extends Equatable {
  final int? id;
  final String? uomName;
  final String? uomSymbol;
  final bool? compoundIsTrue;
  final int? decimalPoints = 0;
  final double? convRate = 1;
  final String? baseItem;
  final String? compundName;
  final String? narration;
  final DateTime? timestamp;

  final bool? fromExternal = false;
  final int? action;
  const UOMDataModelObsolete({
    this.id,
    this.uomName,
    this.uomSymbol,
    this.compoundIsTrue,
    this.baseItem,
    this.compundName,
    this.narration,
    required this.timestamp,
    this.action,
  });

  UOMDataModelObsolete copyWith({
    int? id,
    String? uomName,
    String? uomSymbol,
    bool? compoundIsTrue,
    String? baseItem,
    String? compundName,
    String? narration,
    DateTime? timestamp,
    int? action,
  }) {
    return UOMDataModelObsolete(
      id: id ?? this.id,
      uomName: uomName ?? this.uomName,
      uomSymbol: uomSymbol ?? this.uomSymbol,
      compoundIsTrue: compoundIsTrue ?? this.compoundIsTrue,
      baseItem: baseItem ?? this.baseItem,
      compundName: compundName ?? this.compundName,
      narration: narration ?? this.narration,
      timestamp: timestamp ?? this.timestamp,
      action: action ?? this.action,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uomName': uomName,
      'uomSymbol': uomSymbol,
      'compoundIsTrue': compoundIsTrue,
      'baseItem': baseItem,
      'compundName': compundName,
      'narration': narration,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'action': action,
    };
  }

  factory UOMDataModelObsolete.fromMap(Map<String, dynamic> map) {
    return UOMDataModelObsolete(
      id: map['id']?.toInt(),
      uomName: map['uomName'],
      uomSymbol: map['uomSymbol'],
      compoundIsTrue: map['compoundIsTrue'],
      baseItem: map['baseItem'],
      compundName: map['compundName'],
      narration: map['narration'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      action: map['action']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UOMDataModelObsolete.fromJson(String source) =>
      UOMDataModelObsolete.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UOMDataModelObsolete(id: $id, uomName: $uomName, uomSymbol: $uomSymbol, compoundIsTrue: $compoundIsTrue, baseItem: $baseItem, compundName: $compundName, narration: $narration, timestamp: $timestamp, action: $action)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      uomName,
      uomSymbol,
      compoundIsTrue,
      baseItem,
      compundName,
      narration,
      timestamp,
      action,
    ];
  }
}
