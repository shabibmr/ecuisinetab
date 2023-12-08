import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'InventorygroupHiveModel.g.dart';

@HiveType(typeId: 12)
class InventorygroupHiveModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  String? Group_ID;
  @HiveField(1)
  String? Group_Name;
  @HiveField(2)
  String? Parent_ID;
  @HiveField(3)
  String? Group_Type;
  @HiveField(4)
  String? GroupNameArabic;
  @HiveField(5)
  String? Group_Name_Arabic;
  InventorygroupHiveModel({
    this.Group_ID,
    this.Group_Name,
    this.Parent_ID,
    this.Group_Type,
    this.GroupNameArabic,
    this.Group_Name_Arabic,
  });

  @override
  List<Object?> get props {
    return [
      Group_ID,
      Group_Name,
      Parent_ID,
      Group_Type,
      GroupNameArabic,
      Group_Name_Arabic,
    ];
  }

  InventorygroupHiveModel copyWith({
    String? Group_ID,
    String? Group_Name,
    String? Parent_ID,
    String? Group_Type,
    String? GroupNameArabic,
    String? Group_Name_Arabic,
  }) {
    return InventorygroupHiveModel(
      Group_ID: Group_ID ?? this.Group_ID,
      Group_Name: Group_Name ?? this.Group_Name,
      Parent_ID: Parent_ID ?? this.Parent_ID,
      Group_Type: Group_Type ?? this.Group_Type,
      GroupNameArabic: GroupNameArabic ?? this.GroupNameArabic,
      Group_Name_Arabic: Group_Name_Arabic ?? this.Group_Name_Arabic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Group_Id': Group_ID,
      'Group_Name': Group_Name,
      'Parent_Id': Parent_ID,
      'Group_Type': Group_Type,
      'GroupNameArabic': GroupNameArabic,
      'Group_Name_Arabic': Group_Name_Arabic,
    };
  }

  factory InventorygroupHiveModel.fromMap(Map<String, dynamic> map) {
    return InventorygroupHiveModel(
      Group_ID: map['Group_Id'],
      Group_Name: map['Group_Name'],
      Parent_ID: map['Parent_ID'],
      Group_Type: map['Group_Type'],
      GroupNameArabic: map['GroupNameArabic'],
      Group_Name_Arabic: map['Group_Name_Arabic'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InventorygroupHiveModel.fromJson(String source) =>
      InventorygroupHiveModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventorygroupHiveModel(Group_ID: $Group_ID, Group_Name: $Group_Name, Parent_ID: $Parent_ID, Group_Type: $Group_Type, GroupNameArabic: $GroupNameArabic, Group_Name_Arabic: $Group_Name_Arabic)';
  }
}
