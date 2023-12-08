import 'dart:convert';

import 'package:equatable/equatable.dart';

class ShippingDetailDataModel extends Equatable {
  final String? deliveredBy;
  final String? vehicleId;
  final String? vehicleName;
  final String? description;
  final String? driverName;
  final String? driverPhone;
  final String? shippingCompany; // voucher only
  final String? shippingCompanyTrn; // voucher only
  final String? billingAddress; // ledger
  final String? capacity;
  final double? ratePerKm;
  final double? shippingCharges;

  // log only

  final DateTime? inTime;
  final DateTime? outTime;
  final double? unloadedWeight;
  final double? loadedWeight;
  const ShippingDetailDataModel({
    this.deliveredBy,
    this.vehicleId,
    this.vehicleName,
    this.description,
    this.driverName,
    this.driverPhone,
    this.shippingCompany,
    this.shippingCompanyTrn,
    this.billingAddress,
    this.capacity,
    this.ratePerKm,
    this.shippingCharges,
    this.inTime,
    this.outTime,
    this.unloadedWeight,
    this.loadedWeight,
  });

  ShippingDetailDataModel copyWith({
    String? deliveredBy,
    String? vehicleId,
    String? vehicleName,
    String? description,
    String? driverName,
    String? driverPhone,
    String? shippingCompany,
    String? shippingCompanyTrn,
    String? billingAddress,
    String? capacity,
    double? ratePerKm,
    double? shippingCharges,
    DateTime? inTime,
    DateTime? outTime,
    double? unloadedWeight,
    double? loadedWeight,
  }) {
    return ShippingDetailDataModel(
      deliveredBy: deliveredBy ?? this.deliveredBy,
      vehicleId: vehicleId ?? this.vehicleId,
      vehicleName: vehicleName ?? this.vehicleName,
      description: description ?? this.description,
      driverName: driverName ?? this.driverName,
      driverPhone: driverPhone ?? this.driverPhone,
      shippingCompany: shippingCompany ?? this.shippingCompany,
      shippingCompanyTrn: shippingCompanyTrn ?? this.shippingCompanyTrn,
      billingAddress: billingAddress ?? this.billingAddress,
      capacity: capacity ?? this.capacity,
      ratePerKm: ratePerKm ?? this.ratePerKm,
      shippingCharges: shippingCharges ?? this.shippingCharges,
      inTime: inTime ?? this.inTime,
      outTime: outTime ?? this.outTime,
      unloadedWeight: unloadedWeight ?? this.unloadedWeight,
      loadedWeight: loadedWeight ?? this.loadedWeight,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deliveredBy': deliveredBy,
      'vehicleId': vehicleId,
      'vehicleName': vehicleName,
      'description': description,
      'driverName': driverName,
      'driverPhone': driverPhone,
      'shippingCompany': shippingCompany,
      'shippingCompanyTrn': shippingCompanyTrn,
      'billingAddress': billingAddress,
      'capacity': capacity,
      'ratePerKm': ratePerKm,
      'shippingCharges': shippingCharges,
      'inTime': inTime?.millisecondsSinceEpoch,
      'outTime': outTime?.millisecondsSinceEpoch,
      'unloadedWeight': unloadedWeight,
      'loadedWeight': loadedWeight,
    };
  }

  factory ShippingDetailDataModel.fromMap(Map<String, dynamic> map) {
    return ShippingDetailDataModel(
      deliveredBy: map['deliveredBy'],
      vehicleId: map['vehicleId'],
      vehicleName: map['vehicleName'],
      description: map['description'],
      driverName: map['driverName'],
      driverPhone: map['driverPhone'],
      shippingCompany: map['shippingCompany'],
      shippingCompanyTrn: map['shippingCompanyTrn'],
      billingAddress: map['billingAddress'],
      capacity: map['capacity'],
      ratePerKm: map['ratePerKm']?.toDouble(),
      shippingCharges: map['shippingCharges']?.toDouble(),
      inTime: map['inTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['inTime'])
          : null,
      outTime: map['outTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['outTime'])
          : null,
      unloadedWeight: map['unloadedWeight']?.toDouble(),
      loadedWeight: map['loadedWeight']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShippingDetailDataModel.fromJson(String source) =>
      ShippingDetailDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShippingDetailDataModel(deliveredBy: $deliveredBy, vehicleId: $vehicleId, vehicleName: $vehicleName, description: $description, driverName: $driverName, driverPhone: $driverPhone, shippingCompany: $shippingCompany, shippingCompanyTrn: $shippingCompanyTrn, billingAddress: $billingAddress, capacity: $capacity, ratePerKm: $ratePerKm, shippingCharges: $shippingCharges, inTime: $inTime, outTime: $outTime, unloadedWeight: $unloadedWeight, loadedWeight: $loadedWeight)';
  }

  @override
  List<Object?> get props {
    return [
      deliveredBy,
      vehicleId,
      vehicleName,
      description,
      driverName,
      driverPhone,
      shippingCompany,
      shippingCompanyTrn,
      billingAddress,
      capacity,
      ratePerKm,
      shippingCharges,
      inTime,
      outTime,
      unloadedWeight,
      loadedWeight,
    ];
  }
}
