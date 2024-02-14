import 'dart:convert';

import 'package:equatable/equatable.dart';

// import '../Accounts/LedgerMasterDataModel.dart';
import 'InventoryItemDataModel.dart';

class CompoundItemDataModel extends Equatable {
  final InventoryItemDataModel BaseItem;
  const CompoundItemDataModel({
    required this.BaseItem,
  });

  CompoundItemDataModel copyWith({
    InventoryItemDataModel? BaseItem,
  }) {
    return CompoundItemDataModel(
      BaseItem: BaseItem ?? this.BaseItem,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'BaseItem': BaseItem.toMap(),
    };
  }

  factory CompoundItemDataModel.fromMap(Map<String, dynamic> map) {
    return CompoundItemDataModel(
      BaseItem: InventoryItemDataModel.fromMap(map['BaseItem']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CompoundItemDataModel.fromJson(String source) =>
      CompoundItemDataModel.fromMap(json.decode(source));

  @override
  String toString() => 'CompoundItemDataModel(BaseItem: $BaseItem)';

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is CompoundItemDataModel && other.BaseItem == BaseItem;
  // }

  @override
  int get hashCode => BaseItem.hashCode;

  @override
  List<Object?> get props => [BaseItem];

  Map<String, dynamic> toMapForTransTest() {
    return {
      'BaseItem': BaseItem.toMapForTransTest(),
    };
  }

  factory CompoundItemDataModel.fromMapForTransTest(Map<String, dynamic>? map) {
    print('Inv Conv : $map');
    if (map == null) {
      return CompoundItemDataModel(BaseItem: InventoryItemDataModel());
    }

    return CompoundItemDataModel(
      BaseItem: InventoryItemDataModel.fromMapForTransTest(map['BaseItem']),
    );
  }
}
