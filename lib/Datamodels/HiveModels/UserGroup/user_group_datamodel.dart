// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_group_datamodel.g.dart';

@HiveType(typeId: 95)
class UserGroupDataModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  int id;
  @HiveField(1)
  String UserGroupName;
  @HiveField(2)
  Map? permissions;
  UserGroupDataModel({
    required this.id,
    required this.UserGroupName,
    this.permissions,
  });

  @override
  List<Object?> get props => [id, UserGroupName, permissions];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'Name': UserGroupName,
      'permissions': permissions,
    };
  }

  factory UserGroupDataModel.fromMap(Map<String, dynamic> map) {
    return UserGroupDataModel(
      id: int.parse(map['_id']),
      UserGroupName: map['Name'],
      permissions: map['permissions'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserGroupDataModel.fromJson(String source) =>
      UserGroupDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
