import 'dart:convert';

import 'package:equatable/equatable.dart';

// final String columnAccid = "_id";
// final String columngroupName = "Group_Name";
// final String columngroupNameArabic = "groupNameArabic";
// final String columngroupID = "Group_ID";
// final String columngroupType = "Group_Type";
// final String columngroupAlias = "groupAlias";
// final String columncategory = "category";
// final String columnparentGroupId = "Parent_ID";
// final String columnparentGroupName = "parentGroupName";
// final String columnfromExternal = "";
// final String columnaction = "";

// final String tableNameAccountGroups = "Account_Groups";

class AccountGroupDataModel extends Equatable {
  final String? groupName;
  final String? groupNameArabic;
  final String? groupID;
  final String? groupType;
  final String? groupAlias;
  final String? category;
  final String? parentGroupId;
  final String? parentGroupName;
  final bool? fromExternal = false;
  final int? action;
  const AccountGroupDataModel({
    this.groupName,
    this.groupNameArabic,
    this.groupID,
    this.groupType,
    this.groupAlias,
    this.category,
    this.parentGroupId,
    this.parentGroupName,
    this.action,
  });

  AccountGroupDataModel copyWith({
    String? groupName,
    String? groupNameArabic,
    String? groupID,
    String? groupType,
    String? groupAlias,
    String? category,
    String? parentGroupId,
    String? parentGroupName,
    int? action,
  }) {
    return AccountGroupDataModel(
      groupName: groupName ?? this.groupName,
      groupNameArabic: groupNameArabic ?? this.groupNameArabic,
      groupID: groupID ?? this.groupID,
      groupType: groupType ?? this.groupType,
      groupAlias: groupAlias ?? this.groupAlias,
      category: category ?? this.category,
      parentGroupId: parentGroupId ?? this.parentGroupId,
      parentGroupName: parentGroupName ?? this.parentGroupName,
      action: action ?? this.action,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'groupName': groupName,
      'groupNameArabic': groupNameArabic,
      'groupID': groupID,
      'groupType': groupType,
      'groupAlias': groupAlias,
      'category': category,
      'parentGroupId': parentGroupId,
      'parentGroupName': parentGroupName,
      'action': action,
    };
  }

  factory AccountGroupDataModel.fromMap(Map<String, dynamic> map) {
    return AccountGroupDataModel(
      groupName: map['groupName'],
      groupNameArabic: map['groupNameArabic'],
      groupID: map['groupID'],
      groupType: map['groupType'],
      groupAlias: map['groupAlias'],
      category: map['category'],
      parentGroupId: map['parentGroupId'],
      parentGroupName: map['parentGroupName'],
      action: map['action']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountGroupDataModel.fromJson(String source) =>
      AccountGroupDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AccountGroupDataModel(groupName: $groupName, groupNameArabic: $groupNameArabic, groupID: $groupID, groupType: $groupType, groupAlias: $groupAlias, category: $category, parentGroupId: $parentGroupId, parentGroupName: $parentGroupName, action: $action)';
  }

  @override
  List<Object?> get props {
    return [
      groupName,
      groupNameArabic,
      groupID,
      groupType,
      groupAlias,
      category,
      parentGroupId,
      parentGroupName,
      action,
    ];
  }
}
