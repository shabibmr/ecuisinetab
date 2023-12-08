import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'AccountGroupHiveModel.g.dart';

@HiveType(typeId: 26)
class AccountGroupHiveModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  String? Group_ID;
  @HiveField(1)
  String? Group_Name;
  @HiveField(2)
  String? Parent_ID;
  @HiveField(3)
  String? Group_Type;
  @HiveField(4)
  String? Group_Category;
  @HiveField(5)
  bool? DefaultRecord;
  AccountGroupHiveModel({
    this.Group_ID,
    this.Group_Name,
    this.Parent_ID,
    this.Group_Type,
    this.Group_Category,
    this.DefaultRecord,
  });

  Map<String, dynamic> toMap() {
    return {
      'Group_ID': Group_ID,
      'Group_Name': Group_Name,
      'Parent_ID': Parent_ID,
      'Group_Type': Group_Type,
      'Group_Category': Group_Category,
      'DefaultRecord': DefaultRecord,
    };
  }

  factory AccountGroupHiveModel.fromMap(Map<String, dynamic> map) {
    return AccountGroupHiveModel(
      Group_ID: map['Group_ID'],
      Group_Name: map['Group_Name'],
      Parent_ID: map['Parent_ID'],
      Group_Type: map['Group_Type'],
      Group_Category: map['Group_Category'],
      DefaultRecord: map['DefaultRecord'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountGroupHiveModel.fromJson(String source) =>
      AccountGroupHiveModel.fromMap(json.decode(source));

  AccountGroupHiveModel copyWith({
    String? Group_ID,
    String? Group_Name,
    String? Parent_ID,
    String? Group_Type,
    String? Group_Category,
    bool? DefaultRecord,
  }) {
    return AccountGroupHiveModel(
      Group_ID: Group_ID ?? this.Group_ID,
      Group_Name: Group_Name ?? this.Group_Name,
      Parent_ID: Parent_ID ?? this.Parent_ID,
      Group_Type: Group_Type ?? this.Group_Type,
      Group_Category: Group_Category ?? this.Group_Category,
      DefaultRecord: DefaultRecord ?? this.DefaultRecord,
    );
  }

  @override
  String toString() {
    return 'AccountGroupHiveModel(Group_ID: $Group_ID, Group_Name: $Group_Name, Parent_ID: $Parent_ID, Group_Type: $Group_Type, Group_Category: $Group_Category, DefaultRecord: $DefaultRecord)';
  }

  @override
  List<Object?> get props => [
        Group_ID,
        Group_Name,
        Parent_ID,
        Group_Type,
        Group_Category,
        DefaultRecord
      ];
}
