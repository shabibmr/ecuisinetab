import 'dart:convert';

import 'package:equatable/equatable.dart';

const String TableName_InventoryGroups = "Sales_Inventory_Groups";

const String column_Inv_ID = "_id";
const String column_Inv_GroupID = "Group_ID";
const String column_Inv_GroupName = "Group_Name";
const String column_Inv_GroupNameArabic = "GroupNameArabic";
const String column_Inv_ParentGroupID = "Parent_ID";
const String column_Inv_GroupType = "Group_Type";
const String column_Inv_fromExternal = "fromExternal";
const String column_Inv_action = "action";
const String column_Inv_parentGroupName = "parentGroupName";

class InventoryGroupDataModel extends Equatable {
  final String? GroupID;
  final String? GroupName;
  final String? GroupNameArabic;
  final String? ParentGroupId;
  final String? GroupType;
  final String? parentGroupName;

  final bool? fromExternal;
  final int? action;
  const InventoryGroupDataModel({
    this.GroupID,
    this.GroupName,
    this.GroupNameArabic,
    this.ParentGroupId,
    this.GroupType,
    this.parentGroupName,
    this.fromExternal = false,
    this.action,
  });

  InventoryGroupDataModel copyWith({
    String? GroupID,
    String? GroupName,
    String? GroupNameArabic,
    String? ParentGroupId,
    String? GroupType,
    String? parentGroupName,
    bool? fromExternal,
    int? action,
  }) {
    return InventoryGroupDataModel(
      GroupID: GroupID ?? this.GroupID,
      GroupName: GroupName ?? this.GroupName,
      GroupNameArabic: GroupNameArabic ?? this.GroupNameArabic,
      ParentGroupId: ParentGroupId ?? this.ParentGroupId,
      GroupType: GroupType ?? this.GroupType,
      parentGroupName: parentGroupName ?? this.parentGroupName,
      fromExternal: fromExternal ?? this.fromExternal,
      action: action ?? this.action,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'GroupID': GroupID,
      'GroupName': GroupName,
      'GroupNameArabic': GroupNameArabic,
      'ParentGroupId': ParentGroupId,
      'GroupType': GroupType,
      'parentGroupName': parentGroupName,
      'fromExternal': fromExternal,
      'action': action,
    };
  }

  factory InventoryGroupDataModel.fromMap(Map<String, dynamic> map) {
    return InventoryGroupDataModel(
      GroupID: map['GroupID'],
      GroupName: map['GroupName'],
      GroupNameArabic: map['GroupNameArabic'],
      ParentGroupId: map['ParentGroupId'],
      GroupType: map['GroupType'],
      parentGroupName: map['parentGroupName'],
      fromExternal: map['fromExternal'],
      action: map['action']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryGroupDataModel.fromJson(String source) =>
      InventoryGroupDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryGroupDataModel(GroupID: $GroupID, GroupName: $GroupName, GroupNameArabic: $GroupNameArabic, ParentGroupId: $ParentGroupId, GroupType: $GroupType, parentGroupName: $parentGroupName, fromExternal: $fromExternal, action: $action)';
  }

  @override
  List<Object?> get props {
    return [
      GroupID,
      GroupName,
      GroupNameArabic,
      ParentGroupId,
      GroupType,
      parentGroupName,
      fromExternal,
      action,
    ];
  }
}
