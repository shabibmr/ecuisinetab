import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'PriceListEntriesHive.g.dart';

@HiveType(typeId: 42)
class PriceListEntriesHive extends HiveObject with EquatableMixin {
  // @HiveField(0)
  // String priceListName;
  @HiveField(0)
  double? rate;
  @HiveField(1)
  int? priceListID;
  @HiveField(2)
  DateTime? timestamp;
  @HiveField(3)
  double? percent;
  @HiveField(4)
  int? uomID;
  @HiveField(5)
  String? priceListName;
  @HiveField(6)
  String? itemID;
  PriceListEntriesHive({
    this.itemID,
    this.rate,
    this.priceListID,
    this.timestamp,
    this.percent,
    this.uomID,
    this.priceListName,
  });

  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
      'priceListID': priceListID,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'percent': percent,
      'uomID': uomID,
      'priceListName': priceListName,
    };
  }

  factory PriceListEntriesHive.fromMap(Map<String, dynamic> map) {
    PriceListEntriesHive p = PriceListEntriesHive(
      itemID: map['Item_ID'] ?? '',
      rate: double.parse(map['price'] ?? "0"),
      priceListID: int.parse(map['Price_List_ID'] ?? '0'),
      timestamp: map['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'])
          : null,
      percent: double.parse(map['percent'] ?? '0'),
      uomID: int.parse(map['Uom_id'] ?? "1"),
      priceListName: map['Price_List_Name'],
    );

    return p;
  }

  String toJson() => json.encode(toMap());

  factory PriceListEntriesHive.fromJson(String source) =>
      PriceListEntriesHive.fromMap(json.decode(source));

  PriceListEntriesHive copyWith({
    String? itemID,
    double? rate,
    int? priceListID,
    DateTime? timestamp,
    double? percent,
    int? uomID,
    String? priceListName,
  }) {
    return PriceListEntriesHive(
      itemID: itemID ?? this.itemID,
      rate: rate ?? this.rate,
      priceListID: priceListID ?? this.priceListID,
      timestamp: timestamp ?? this.timestamp,
      percent: percent ?? this.percent,
      uomID: uomID ?? this.uomID,
      priceListName: priceListName ?? this.priceListName,
    );
  }

  @override
  String toString() {
    return 'PriceListEntriesHive(rate: $rate, priceListID: $priceListID, timestamp: $timestamp, percent: $percent, uomID: $uomID, priceListName: $priceListName)';
  }

  @override
  List<Object?> get props {
    return [
      itemID,
      rate,
      priceListID,
      timestamp,
      percent,
      uomID,
      priceListName,
    ];
  }
}
