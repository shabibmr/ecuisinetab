import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'PriceListMasterHive.g.dart';

@HiveType(typeId: 41)
class PriceListMasterHive extends HiveObject with EquatableMixin {
  @HiveField(0)
  int? priceListID;
  @HiveField(1)
  String? priceListName;
  @HiveField(2)
  DateTime? priceListStartDate;
  @HiveField(3)
  DateTime? priceListEndDate;
  @HiveField(4)
  bool? priceListDefault;
  PriceListMasterHive({
    this.priceListID,
    this.priceListName,
    this.priceListStartDate,
    this.priceListEndDate,
    this.priceListDefault,
  });

  Map<String, dynamic> toMap() {
    return {
      'Price_List_ID': priceListID,
      'Price_List_Name': priceListName,
      'Price_List_Start_Date': priceListStartDate!.millisecondsSinceEpoch,
      'Price_List_End_Date': priceListEndDate!.millisecondsSinceEpoch,
      'Price_List_Default': priceListDefault,
    };
  }

  factory PriceListMasterHive.fromMap(Map<String, dynamic> map) {
    
    return PriceListMasterHive(
      priceListID: int.parse(map['Price_List_ID'] ?? 0),
      priceListName: map['Price_List_Name'] ?? '',
      // priceListStartDate:
      //     DateTime.fromMillisecondsSinceEpoch(map['Price_List_Start_Date']) ??
      //         null,
      // priceListEndDate:
      //     DateTime.fromMillisecondsSinceEpoch(map['Price_List_End_Date']) ??
      //         null,
      // priceListDefault: map['Price_List_Default'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceListMasterHive.fromJson(String source) =>
      PriceListMasterHive.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PriceListMasterHive(priceListID: $priceListID, priceListName: $priceListName, priceListStartDate: $priceListStartDate, priceListEndDate: $priceListEndDate, priceListDefault: $priceListDefault)';
  }

  @override
  List<Object?> get props {
    return [
      priceListID,
      priceListName,
      priceListStartDate,
      priceListEndDate,
      priceListDefault,
    ];
  }
}
