// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'CompanyProfileHiveModel.g.dart';

@HiveType(typeId: 92)
class CompanyProfileHiveModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? CompanyName;
  @HiveField(2)
  String? Currency;

  @override
  List<Object?> get props => [id, CompanyName];
}
