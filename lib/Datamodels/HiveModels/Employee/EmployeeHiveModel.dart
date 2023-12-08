// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'EmployeeHiveModel.g.dart';

@HiveType(typeId: 51)
class EmployeeHiveModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? Name;
  @HiveField(2)
  String? Email;
  @HiveField(3)
  String? Phone;
  @HiveField(4)
  String? Address;
  @HiveField(5)
  String? Employee_ID;
  @HiveField(6)
  String? Designation;
  @HiveField(7)
  String? Department;
  @HiveField(8)
  String? UserName;
  @HiveField(9)
  String? Password;
  @HiveField(10)
  int? UserGroupID;
  @HiveField(11)
  int? privilege;
  @HiveField(12)
  bool? Show_Employee;
  @HiveField(13)
  String? BioMetricID;
  @HiveField(14)
  DateTime? JoinDate;
  @HiveField(15)
  String? email;
  @HiveField(16)
  String? emergencyContact;
  @HiveField(17)
  String? salary_ledger;

  EmployeeHiveModel({
    this.id,
    this.Name,
    this.Email,
    this.Phone,
    this.Address,
    this.Employee_ID,
    this.Designation,
    this.Department,
    this.UserName,
    this.Password,
    this.UserGroupID,
    this.privilege,
    this.Show_Employee,
    this.BioMetricID,
    this.JoinDate,
    this.email,
    this.emergencyContact,
    this.salary_ledger,
  });

  EmployeeHiveModel copyWith({
    int? id,
    String? Name,
    String? Email,
    String? Phone,
    String? Address,
    String? Employee_ID,
    String? Designation,
    String? Department,
    String? UserName,
    String? Password,
    int? UserGroupID,
    int? privilege,
    bool? Show_Employee,
    String? BioMetricID,
    DateTime? JoinDate,
    String? email,
    String? emergencyContact,
    String? salary_ledger,
  }) {
    return EmployeeHiveModel(
      id: id ?? this.id,
      Name: Name ?? this.Name,
      Email: Email ?? this.Email,
      Phone: Phone ?? this.Phone,
      Address: Address ?? this.Address,
      Employee_ID: Employee_ID ?? this.Employee_ID,
      Designation: Designation ?? this.Designation,
      Department: Department ?? this.Department,
      UserName: UserName ?? this.UserName,
      Password: Password ?? this.Password,
      UserGroupID: UserGroupID ?? this.UserGroupID,
      privilege: privilege ?? this.privilege,
      Show_Employee: Show_Employee ?? this.Show_Employee,
      BioMetricID: BioMetricID ?? this.BioMetricID,
      JoinDate: JoinDate ?? this.JoinDate,
      email: email ?? this.email,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      salary_ledger: salary_ledger ?? this.salary_ledger,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'Name': Name,
      'Email': Email,
      'Phone': Phone,
      'Address': Address,
      'Employee_ID': Employee_ID,
      'Designation': Designation,
      'Department': Department,
      'UserName': UserName,
      'Password': Password,
      'UserGroupID': UserGroupID,
      'privilege': privilege,
      'Show_Employee': Show_Employee,
      'email': email,
      'Emergency_Contact_No': emergencyContact,
      'salary_ledger': salary_ledger ?? '',
    };
  }

  factory EmployeeHiveModel.fromMap(Map<String, dynamic> map) {
    return EmployeeHiveModel(
      id: int.parse(map['_id'] ?? "0"),
      Name: map['Name'],
      Email: map['Email'],
      Phone: map['Phone'],
      Address: map['Address'],
      Employee_ID: map['Employee_ID'],
      Designation: map['Designation'],
      Department: map['Department'],
      UserName: map['UserName'],
      Password: map['Password'],
      UserGroupID: int.parse(map['UserGroupID'] ?? "0"),
      privilege: int.parse(map['privilege'] ?? "0"),
      Show_Employee: (map['Show_Employee'] ?? "0") == "1" ? true : false,
      email: map['email'] ?? '',
      emergencyContact: map['Emergency_Contact_No'],
      salary_ledger: map['salary_ledger'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeHiveModel.fromJson(String source) =>
      EmployeeHiveModel.fromMap(json.decode(source));

  @override
  List<Object?> get props {
    return [
      id,
      Name,
      Email,
      Phone,
      Address,
      Employee_ID,
      Designation,
      Department,
      UserName,
      Password,
      UserGroupID,
      privilege,
      Show_Employee,
      email,
      emergencyContact,
      JoinDate,
      salary_ledger,
    ];
  }
}
