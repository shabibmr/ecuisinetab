// UOMConvHiveModel.dart

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'UOMConvHiveModel.g.dart';

@HiveType(typeId: 32)
class UOMConvHiveModel extends HiveObject with EquatableMixin {
  int? id;
  @HiveField(1)
  int? baseUnit;
  @HiveField(2)
  int? toUnit;
  @HiveField(3)
  double? conValue;
  @HiveField(4)
  String? itemID;
  @HiveField(5)
  String? narration;
  @HiveField(6)
  String? barcode;
  UOMConvHiveModel({
    this.id,
    this.baseUnit,
    this.toUnit,
    this.conValue,
    this.itemID,
    this.narration,
    this.barcode,
  });

  UOMConvHiveModel copyWith({
    int? id,
    int? baseUnit,
    int? toUnit,
    double? conValue,
    String? itemID,
    String? narration,
    String? barcode,
  }) {
    return UOMConvHiveModel(
      id: id ?? this.id,
      baseUnit: baseUnit ?? this.baseUnit,
      toUnit: toUnit ?? this.toUnit,
      conValue: conValue ?? this.conValue,
      itemID: itemID ?? this.itemID,
      narration: narration ?? this.narration,
      barcode: barcode ?? this.barcode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'baseUnit': baseUnit,
      'toUnit': toUnit,
      'conValue': conValue,
      'itemID': itemID,
      'narration': narration,
      'barcode': barcode,
    };
  }

  factory UOMConvHiveModel.fromMap(Map<String, dynamic> map) {
    return UOMConvHiveModel(
      id: map['id']?.toInt(),
      baseUnit: map['baseUnit']?.toInt(),
      toUnit: map['toUnit']?.toInt(),
      conValue: map['conValue']?.toDouble(),
      itemID: map['itemID'],
      narration: map['narration'],
      barcode: map['barcode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UOMConvHiveModel.fromJson(String source) =>
      UOMConvHiveModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UOMConvHiveModel(id: $id, baseUnit: $baseUnit, toUnit: $toUnit, conValue: $conValue, itemID: $itemID, narration: $narration, barcode: $barcode)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      baseUnit,
      toUnit,
      conValue,
      itemID,
      narration,
      barcode,
    ];
  }
}
