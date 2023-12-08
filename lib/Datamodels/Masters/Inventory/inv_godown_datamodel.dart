import 'dart:convert';

import 'package:equatable/equatable.dart';

class ItemGodownDataModel extends Equatable {
  final String? fromGodown;
  final String? toGodown;

  final double? crQty;
  final double? drQty;
  final double? enteredQty;

  final double? crAmount;
  final double? drAmount;

  const ItemGodownDataModel({
    this.fromGodown,
    this.toGodown,
    this.crQty,
    this.drQty,
    this.enteredQty,
    this.crAmount,
    this.drAmount,
  });

  ItemGodownDataModel copyWith({
    String? fromGodown,
    String? toGodown,
    double? crQty,
    double? drQty,
    double? enteredQty,
    double? crAmount,
    double? drAmount,
  }) {
    return ItemGodownDataModel(
      fromGodown: fromGodown ?? this.fromGodown,
      toGodown: toGodown ?? this.toGodown,
      crQty: crQty ?? this.crQty,
      drQty: drQty ?? this.drQty,
      enteredQty: enteredQty ?? this.enteredQty,
      crAmount: crAmount ?? this.crAmount,
      drAmount: drAmount ?? this.drAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fromGodown': fromGodown,
      'toGodown': toGodown,
      'crQty': crQty,
      'drQty': drQty,
      'enteredQty': enteredQty,
      'crAmount': crAmount,
      'drAmount': drAmount,
    };
  }

  factory ItemGodownDataModel.fromMap(Map<String, dynamic> map) {
    return ItemGodownDataModel(
      fromGodown: map['fromGodown'],
      toGodown: map['toGodown'],
      crQty: map['crQty']?.toDouble(),
      drQty: map['drQty']?.toDouble(),
      enteredQty: map['enteredQty']?.toDouble(),
      crAmount: map['crAmount']?.toDouble(),
      drAmount: map['drAmount']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemGodownDataModel.fromJson(String source) =>
      ItemGodownDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemGodownDataModel(fromGodown: $fromGodown, toGodown: $toGodown, crQty: $crQty, drQty: $drQty, enteredQty: $enteredQty, crAmount: $crAmount, drAmount: $drAmount)';
  }

  @override
  List<Object?> get props {
    return [
      fromGodown,
      toGodown,
      crQty,
      drQty,
      enteredQty,
      crAmount,
      drAmount,
    ];
  }
}
