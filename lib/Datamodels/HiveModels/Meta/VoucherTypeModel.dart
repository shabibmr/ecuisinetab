// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'VoucherTypeModel.g.dart';

@HiveType(typeId: 18)
class VoucherTypeModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  int id;
  @HiveField(1)
  final String? voucherType;
  @HiveField(2)
  final String? voucherPrefix;
  @HiveField(3)
  final Map? data;
  @HiveField(4)
  final DateTime? timeStamp;

  VoucherTypeModel({
    required this.id,
    this.voucherType,
    this.voucherPrefix,
    this.data,
    this.timeStamp,
  });

  @override
  List<Object?> get props => [id, voucherType, voucherPrefix, data, timeStamp];

  VoucherTypeModel copyWith({
    int? id,
    String? voucherType,
    String? voucherPrefix,
    Map? data,
    DateTime? timeStamp,
  }) {
    return VoucherTypeModel(
      id: id ?? this.id,
      voucherType: voucherType ?? this.voucherType,
      voucherPrefix: voucherPrefix ?? this.voucherPrefix,
      data: data ?? this.data,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }
}
