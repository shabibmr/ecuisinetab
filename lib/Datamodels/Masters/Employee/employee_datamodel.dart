import 'dart:convert';

import 'package:equatable/equatable.dart';

const String TableName_Employee_Details = "Employee_Details";

const String column_Employee_Details_id = "_id";
const String column_Employee_Details_TimeStamp = "TimeStamp";
const String column_Employee_Details_Name = "Name";
const String column_Employee_Details_Fathers_Name = "Fathers_Name";
const String column_Employee_Details_Date_of_Birth = "Date_of_Birth";
const String column_Employee_Details_Gender = "Gender";
const String column_Employee_Details_Nationality = "Nationality";
const String column_Employee_Details_Marital_Status = "Marital_Status";
const String column_Employee_Details_Email = "Email";
const String column_Employee_Details_Phone = "Phone";
const String column_Employee_Details_Address = "Address";
const String column_Employee_Details_Username = "UserName";
const String column_Employee_Details_Password = "Password";
const String column_Employee_Details_Employee_ID = "Employee_ID";
const String column_Employee_Details_Designation = "Designation";
const String column_Employee_Details_Department = "Department";
const String column_Employee_Details_Date_of_Joining = "Date_of_Joining";
const String column_Employee_Details_Passport_No = "Passport_No";
const String column_Employee_Details_Passport_Expiry = "Passport_Expiry";
const String column_Employee_Details_Visa_No = "Visa_No";
const String column_Employee_Details_Visa_Expiry = "Visa_Expiry";
const String column_Employee_Details_Bank_Account_No = "Bank_Account_No";
const String column_Employee_Details_Bank_Name = "Bank_Name";
const String column_Employee_Details_Bank_Branch = "Bank_Branch";
const String column_Employee_Details_Bank_Code = "Bank_Code";
const String column_Employee_Details_Highest_Qualification =
    "Highest_Qualification";
const String column_Employee_Details_Date_of_Qualification =
    "Date_of_Qualification";
const String column_Employee_Details_Emergency_Contact_Name =
    "Emergency_Contact_Name";
const String column_Employee_Details_Emergency_Contact_No =
    "Emergency_Contact_No";
const String column_Employee_Details_Emergency_Contact_Relation =
    "Emergency_Contact_Relation";
const String column_Employee_Details_User_Group = "UserGroupID";
const String column_Employee_Details_Show_Emp = "Show_Employee";

class EmployeeProfileDataModel extends Equatable {
  final int? id;
  final String? name;
  final String? fathersname;
  final DateTime? timestamp;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? nationality;
  final String? maritalStatus;
  final String? email;
  final String? phone;
  final String? address;
  final String? username;
  final String? password;
  final int? userGroup;
  final String? employeeID;
  final String? designation;
  final String? department;
  final DateTime? dateOfJoining;
  final String? passportNo;
  final DateTime? passportExpiry;
  final String? visaNo;
  final DateTime? visaExpiry;
  final String? bankAccountNo;
  final String? bankName;
  final String? bankBranch;
  final String? bankCode;
  final String? highestQualification;
  final DateTime? dateOfQualification;
  final String? emergencyContactName;
  final String? emergencyContactNo;
  final String? emergencyContactRelation;
  final bool? showEmployee;

  final bool? fromExternal = false;
  final int? action;
  const EmployeeProfileDataModel({
    this.id,
    this.name,
    this.fathersname,
    this.timestamp,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    this.maritalStatus,
    this.email,
    this.phone,
    this.address,
    this.username,
    this.password,
    this.userGroup,
    this.employeeID,
    this.designation,
    this.department,
    this.dateOfJoining,
    this.passportNo,
    this.passportExpiry,
    this.visaNo,
    this.visaExpiry,
    this.bankAccountNo,
    this.bankName,
    this.bankBranch,
    this.bankCode,
    this.highestQualification,
    this.dateOfQualification,
    this.emergencyContactName,
    this.emergencyContactNo,
    this.emergencyContactRelation,
    this.showEmployee,
    this.action,
  });

  EmployeeProfileDataModel copyWith({
    int? id,
    String? name,
    String? fathersname,
    DateTime? timestamp,
    DateTime? dateOfBirth,
    String? gender,
    String? nationality,
    String? maritalStatus,
    String? email,
    String? phone,
    String? address,
    String? username,
    String? password,
    int? userGroup,
    String? employeeID,
    String? designation,
    String? department,
    DateTime? dateOfJoining,
    String? passportNo,
    DateTime? passportExpiry,
    String? visaNo,
    DateTime? visaExpiry,
    String? bankAccountNo,
    String? bankName,
    String? bankBranch,
    String? bankCode,
    String? highestQualification,
    DateTime? dateOfQualification,
    String? emergencyContactName,
    String? emergencyContactNo,
    String? emergencyContactRelation,
    bool? showEmployee,
    int? action,
  }) {
    return EmployeeProfileDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      fathersname: fathersname ?? this.fathersname,
      timestamp: timestamp ?? this.timestamp,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      username: username ?? this.username,
      password: password ?? this.password,
      userGroup: userGroup ?? this.userGroup,
      employeeID: employeeID ?? this.employeeID,
      designation: designation ?? this.designation,
      department: department ?? this.department,
      dateOfJoining: dateOfJoining ?? this.dateOfJoining,
      passportNo: passportNo ?? this.passportNo,
      passportExpiry: passportExpiry ?? this.passportExpiry,
      visaNo: visaNo ?? this.visaNo,
      visaExpiry: visaExpiry ?? this.visaExpiry,
      bankAccountNo: bankAccountNo ?? this.bankAccountNo,
      bankName: bankName ?? this.bankName,
      bankBranch: bankBranch ?? this.bankBranch,
      bankCode: bankCode ?? this.bankCode,
      highestQualification: highestQualification ?? this.highestQualification,
      dateOfQualification: dateOfQualification ?? this.dateOfQualification,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactNo: emergencyContactNo ?? this.emergencyContactNo,
      emergencyContactRelation:
          emergencyContactRelation ?? this.emergencyContactRelation,
      showEmployee: showEmployee ?? this.showEmployee,
      action: action ?? this.action,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'fathersname': fathersname,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'dateOfBirth': dateOfBirth?.millisecondsSinceEpoch,
      'gender': gender,
      'nationality': nationality,
      'maritalStatus': maritalStatus,
      'email': email,
      'phone': phone,
      'address': address,
      'username': username,
      'password': password,
      'userGroup': userGroup,
      'employeeID': employeeID,
      'designation': designation,
      'department': department,
      'dateOfJoining': dateOfJoining?.millisecondsSinceEpoch,
      'passportNo': passportNo,
      'passportExpiry': passportExpiry?.millisecondsSinceEpoch,
      'visaNo': visaNo,
      'visaExpiry': visaExpiry?.millisecondsSinceEpoch,
      'bankAccountNo': bankAccountNo,
      'bankName': bankName,
      'bankBranch': bankBranch,
      'bankCode': bankCode,
      'highestQualification': highestQualification,
      'dateOfQualification': dateOfQualification?.millisecondsSinceEpoch,
      'emergencyContactName': emergencyContactName,
      'emergencyContactNo': emergencyContactNo,
      'emergencyContactRelation': emergencyContactRelation,
      'showEmployee': showEmployee,
      'action': action,
    };
  }

  factory EmployeeProfileDataModel.fromMap(Map<String, dynamic> map) {
    return EmployeeProfileDataModel(
      id: map['id']?.toInt(),
      name: map['name'],
      fathersname: map['fathersname'],
      timestamp: map['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'])
          : null,
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'])
          : null,
      gender: map['gender'],
      nationality: map['nationality'],
      maritalStatus: map['maritalStatus'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      username: map['username'],
      password: map['password'],
      userGroup: map['userGroup']?.toInt(),
      employeeID: map['employeeID'],
      designation: map['designation'],
      department: map['department'],
      dateOfJoining: map['dateOfJoining'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateOfJoining'])
          : null,
      passportNo: map['passportNo'],
      passportExpiry: map['passportExpiry'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['passportExpiry'])
          : null,
      visaNo: map['visaNo'],
      visaExpiry: map['visaExpiry'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['visaExpiry'])
          : null,
      bankAccountNo: map['bankAccountNo'],
      bankName: map['bankName'],
      bankBranch: map['bankBranch'],
      bankCode: map['bankCode'],
      highestQualification: map['highestQualification'],
      dateOfQualification: map['dateOfQualification'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateOfQualification'])
          : null,
      emergencyContactName: map['emergencyContactName'],
      emergencyContactNo: map['emergencyContactNo'],
      emergencyContactRelation: map['emergencyContactRelation'],
      showEmployee: map['showEmployee'],
      action: map['action']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeProfileDataModel.fromJson(String source) =>
      EmployeeProfileDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EmployeeProfileDataModel(id: $id, name: $name, fathersname: $fathersname, timestamp: $timestamp, dateOfBirth: $dateOfBirth, gender: $gender, nationality: $nationality, maritalStatus: $maritalStatus, email: $email, phone: $phone, address: $address, username: $username, password: $password, userGroup: $userGroup, employeeID: $employeeID, designation: $designation, department: $department, dateOfJoining: $dateOfJoining, passportNo: $passportNo, passportExpiry: $passportExpiry, visaNo: $visaNo, visaExpiry: $visaExpiry, bankAccountNo: $bankAccountNo, bankName: $bankName, bankBranch: $bankBranch, bankCode: $bankCode, highestQualification: $highestQualification, dateOfQualification: $dateOfQualification, emergencyContactName: $emergencyContactName, emergencyContactNo: $emergencyContactNo, emergencyContactRelation: $emergencyContactRelation, showEmployee: $showEmployee, action: $action)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      fathersname,
      timestamp,
      dateOfBirth,
      gender,
      nationality,
      maritalStatus,
      email,
      phone,
      address,
      username,
      password,
      userGroup,
      employeeID,
      designation,
      department,
      dateOfJoining,
      passportNo,
      passportExpiry,
      visaNo,
      visaExpiry,
      bankAccountNo,
      bankName,
      bankBranch,
      bankCode,
      highestQualification,
      dateOfQualification,
      emergencyContactName,
      emergencyContactNo,
      emergencyContactRelation,
      showEmployee,
      action,
    ];
  }
}
