import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'contacts_data_model.g.dart';

@HiveType(typeId: 81)
class ContactsDataModel extends HiveObject implements EquatableMixin {
  @HiveField(0)
  final int? id = 0;
  @HiveField(1)
  final String? addressId;
  @HiveField(2)
  final String? ContactName;
  @HiveField(3)
  final String? ContactUuid;
  @HiveField(4)
  final String? PhoneNumber;
  @HiveField(5)
  final String? email;
  @HiveField(6)
  final String? address;
  @HiveField(7)
  final String? route;
  @HiveField(8)
  final String? code;
  @HiveField(9)
  final String? city;
  @HiveField(10)
  final String? country;
  @HiveField(11)
  final String? ledgerId;
  @HiveField(12)
  final String? CompanyName;
  @HiveField(13)
  final String? location;
  @HiveField(14)
  final String? EmployeeId;
  @HiveField(15)
  final DateTime? DateOfBirth;
  @HiveField(16)
  final String? mobileNumber;
  @HiveField(17)
  final String? notes;
  @HiveField(18)
  final String? Designation;
  @HiveField(19)
  final String? DesignationID;
  @HiveField(20)
  final String? Building;
  @HiveField(21)
  final bool? isCompanyEmployee;
  @HiveField(22)
  final bool? isIndividual;
  @HiveField(23)
  final int? Type;
  @HiveField(24)
  final String? POBox;
  @HiveField(25)
  final String? Street;
  @HiveField(26)
  final String? Fax;
  @HiveField(27)
  List<String> LocationDetails;
  ContactsDataModel({
    this.addressId,
    this.ContactName,
    this.ContactUuid,
    this.PhoneNumber,
    this.email,
    this.address,
    this.route,
    this.code,
    this.city,
    this.country,
    this.ledgerId,
    this.CompanyName,
    this.location,
    this.EmployeeId,
    this.DateOfBirth,
    this.mobileNumber,
    this.notes,
    this.Designation,
    this.DesignationID,
    this.Building,
    this.isCompanyEmployee,
    this.isIndividual,
    this.Type,
    this.POBox,
    this.Street,
    this.Fax,
    required this.LocationDetails,
  });
  final bool? isActive = false;
  final double? deliveryCharges = 0;

  ContactsDataModel copyWith({
    String? addressId,
    String? ContactName,
    String? ContactUuid,
    String? PhoneNumber,
    String? email,
    String? address,
    String? route,
    String? code,
    String? city,
    String? country,
    String? ledgerId,
    String? CompanyName,
    String? location,
    String? EmployeeId,
    DateTime? DateOfBirth,
    String? mobileNumber,
    String? notes,
    String? Designation,
    String? DesignationID,
    String? Building,
    bool? isCompanyEmployee,
    bool? isIndividual,
    int? Type,
    String? POBox,
    String? Street,
    String? Fax,
    List<String>? LocationDetails,
  }) {
    return ContactsDataModel(
      addressId: addressId ?? this.addressId,
      ContactName: ContactName ?? this.ContactName,
      ContactUuid: ContactUuid ?? this.ContactUuid,
      PhoneNumber: PhoneNumber ?? this.PhoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      route: route ?? this.route,
      code: code ?? this.code,
      city: city ?? this.city,
      country: country ?? this.country,
      ledgerId: ledgerId ?? this.ledgerId,
      CompanyName: CompanyName ?? this.CompanyName,
      location: location ?? this.location,
      EmployeeId: EmployeeId ?? this.EmployeeId,
      DateOfBirth: DateOfBirth ?? this.DateOfBirth,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      notes: notes ?? this.notes,
      Designation: Designation ?? this.Designation,
      DesignationID: DesignationID ?? this.DesignationID,
      Building: Building ?? this.Building,
      isCompanyEmployee: isCompanyEmployee ?? this.isCompanyEmployee,
      isIndividual: isIndividual ?? this.isIndividual,
      Type: Type ?? this.Type,
      POBox: POBox ?? this.POBox,
      Street: Street ?? this.Street,
      Fax: Fax ?? this.Fax,
      LocationDetails: LocationDetails ?? this.LocationDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Address_id': addressId,
      'ContactName': ContactName,
      'ContactUuid': ContactUuid,
      'PhoneNumber': PhoneNumber,
      'email': email,
      'address': address,
      'route': route,
      'code': code,
      'city': city,
      'country': country,
      'ledgerId': ledgerId,
      'CompanyName': CompanyName,
      'location': location,
      'EmployeeId': EmployeeId,
      'DateOfBirth': DateOfBirth?.millisecondsSinceEpoch,
      'mobileNumber': mobileNumber,
      'notes': notes,
      'Designation': Designation,
      'DesignationID': DesignationID,
      'Building': Building,
      'isCompanyEmployee': isCompanyEmployee,
      'isIndividual': isIndividual,
      'Type': Type,
      'POBox': POBox,
      'Street': Street,
      'Fax': Fax,
      'LocationDetails': LocationDetails,
    };
  }

  factory ContactsDataModel.fromMap(Map<String, dynamic> map) {
    map.keys.forEach((key) {
      // print('$key - ${map[key]} - ${map[key].runtimeType}');
    });
    return ContactsDataModel(
      addressId: map['Address_id'] ?? '',
      ContactName: map['ContactName'] ?? '',
      ContactUuid: map['ContactUuid'] ?? '',
      PhoneNumber: map['PhoneNumber'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      route: map['route'] ?? '',
      code: map['code'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      ledgerId: map['ledgerId'] ?? '',
      CompanyName: map['CompanyName'] ?? '',
      location: map['location'] ?? '',
      EmployeeId: map['EmployeeId'] ?? '',
      // DateOfBirth: map['DateOfBirth'] != null
      //     ? DateTime.fromMillisecondsSinceEpoch(map['DateOfBirth'])
      //     : null,
      mobileNumber: map['mobileNumber'] ?? '',
      notes: map['notes'] ?? '',
      Designation: map['Designation'] ?? '',
      DesignationID: map['DesignationID'] ?? '',
      Building: map['Building'] ?? '',
      isCompanyEmployee:
          map['isCompanyEmployee'].toString() == "1" ? true : false,
      isIndividual: map['isIndividual'].toString() == "1" ? true : false,
      Type: int.parse(map['Type'] ?? '0'),
      POBox: map['POBox'] ?? '',
      Street: map['Street'] ?? '',
      Fax: map['Fax'] ?? '',
      LocationDetails: map['LocationDetails'] != null
          ? List<String>.from(map['LocationDetails'])
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactsDataModel.fromJson(String source) =>
      ContactsDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContactsDataModel(ContactName: $ContactName, ContactUuid: $ContactUuid, PhoneNumber: $PhoneNumber, email: $email, address: $address, route: $route, code: $code, city: $city, country: $country, ledgerId: $ledgerId, CompanyName: $CompanyName, location: $location, EmployeeId: $EmployeeId, DateOfBirth: $DateOfBirth, mobileNumber: $mobileNumber, notes: $notes, Designation: $Designation, DesignationID: $DesignationID, Building: $Building, isCompanyEmployee: $isCompanyEmployee, isIndividual: $isIndividual, Type: $Type, POBox: $POBox, Street: $Street, Fax: $Fax, LocationDetails: $LocationDetails)';
  }

  @override
  List<Object?> get props {
    return [
      ContactName,
      ContactUuid,
      PhoneNumber,
      email,
      address,
      route,
      code,
      city,
      country,
      ledgerId,
      CompanyName,
      location,
      EmployeeId,
      DateOfBirth,
      mobileNumber,
      notes,
      Designation,
      DesignationID,
      Building,
      isCompanyEmployee,
      isIndividual,
      Type,
      POBox,
      Street,
      Fax,
      LocationDetails,
    ];
  }

  @override
  bool? get stringify => throw UnimplementedError();
}
