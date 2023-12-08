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
  PriceListEntriesHive({
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
    return PriceListEntriesHive(
      rate: map['rate']?.toDouble(),
      priceListID: map['priceListID']?.toInt(),
      timestamp: map['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'])
          : null,
      percent: map['percent']?.toDouble(),
      uomID: map['uomID']?.toInt(),
      priceListName: map['priceListName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceListEntriesHive.fromJson(String source) =>
      PriceListEntriesHive.fromMap(json.decode(source));

  PriceListEntriesHive copyWith({
    double? rate,
    int? priceListID,
    DateTime? timestamp,
    double? percent,
    int? uomID,
    String? priceListName,
  }) {
    return PriceListEntriesHive(
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
      rate,
      priceListID,
      timestamp,
      percent,
      uomID,
      priceListName,
    ];
  }
}
