import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'UOMHiveModel.g.dart';

@HiveType(typeId: 31)
class UOMHiveMOdel extends HiveObject with EquatableMixin {
  @HiveField(0)
  int? UOM_id;
  @HiveField(1)
  String? uom_Name;
  @HiveField(2)
  String? uom_symbol;
  @HiveField(3)
  int? UOM_decimal_Points;
  @HiveField(4)
  String? UOM_Narration;
  @HiveField(5)
  DateTime? timestamp;
  @HiveField(6)
  double? convRate;
  UOMHiveMOdel({
    this.UOM_id,
    this.uom_Name,
    this.uom_symbol,
    this.UOM_decimal_Points,
    this.UOM_Narration,
    this.timestamp,
    this.convRate,
  });

  UOMHiveMOdel copyWith({
    int? UOM_id,
    String? uom_Name,
    String? uom_symbol,
    int? UOM_decimal_Points,
    String? UOM_Narration,
    DateTime? timestamp,
    double? convRate,
  }) {
    return UOMHiveMOdel(
      UOM_id: UOM_id ?? this.UOM_id,
      uom_Name: uom_Name ?? this.uom_Name,
      uom_symbol: uom_symbol ?? this.uom_symbol,
      UOM_decimal_Points: UOM_decimal_Points ?? this.UOM_decimal_Points,
      UOM_Narration: UOM_Narration ?? this.UOM_Narration,
      timestamp: timestamp ?? this.timestamp,
      convRate: convRate ?? this.convRate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'UOM_id': UOM_id,
      'uom_Name': uom_Name,
      'uom_symbol': uom_symbol,
      'UOM_decimal_Points': UOM_decimal_Points,
      'UOM_Narration': UOM_Narration,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'convRate': convRate,
    };
  }

  Map<String, dynamic> toMapMasters() {
    return {
      'Uom_id': UOM_id,
      'uom_Name': uom_Name,
      'uom_symbol': uom_symbol,
      'UOM_decimal_Points': UOM_decimal_Points,
      'UOM_Narration': UOM_Narration,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'convRate': convRate,
    };
  }

  factory UOMHiveMOdel.fromMap(Map<String, dynamic> map) {
    return UOMHiveMOdel(
      UOM_id: int.parse(map['Uom_id']),
      uom_Name: map['UomName'],
      uom_symbol: map['UomSymbol'],
      UOM_decimal_Points: int.parse(map['decimalPoints'] ?? '0'),
      UOM_Narration: map['Narration'] ?? '',
      timestamp: map['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'])
          : null,
      convRate: map['convRate'] != null ? double.parse(map['convRate']) : 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory UOMHiveMOdel.fromJson(String source) =>
      UOMHiveMOdel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UOMHiveMOdel(UOM_id: $UOM_id, uom_Name: $uom_Name, uom_symbol: $uom_symbol, UOM_decimal_Points: $UOM_decimal_Points, UOM_Narration: $UOM_Narration, timestamp: $timestamp, convRate: $convRate)';
  }

  @override
  List<Object?> get props {
    return [
      UOM_id,
      uom_Name,
      uom_symbol,
      UOM_decimal_Points,
      UOM_Narration,
      timestamp,
      convRate,
    ];
  }

  UOMHiveMOdel.fromMapTrans(Map map) {
    print('UOM conv in HIVE $map');
    map.forEach((key, value) {
      print('$key : $value - ${value.runtimeType}');
    });
    UOM_id = int.parse(map['Uom_id'] ?? '0');
    uom_Name = map['UomName'] ?? '';
    uom_symbol = map['UomSymbol'] ?? '';
    UOM_decimal_Points = int.parse(map['decimalPoints'] ?? '0');
    convRate = double.parse(map['convRate'] ?? '0');
    UOM_Narration = map['Narration'] ?? '';
    // print('thats done');
  }

  Map<String, dynamic> toMapTrans() {
    Map<String, dynamic> map = {
      'Uom_id': UOM_id,
      'UomName': uom_Name,
      'decimalPoints': UOM_decimal_Points,
      'UomSymbol': uom_symbol,
      'convRate': convRate,
    };
    return map;
  }
}
