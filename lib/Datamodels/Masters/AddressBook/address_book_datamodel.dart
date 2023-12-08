import 'dart:convert';

import 'package:equatable/equatable.dart';

class ContactsDataModelOLD extends Equatable {
  final int? id = 0;
  final String? addressId = "";
  final String? ContactName;
  final String? ContactUuid;
  final String? PhoneNumber;
  final String? email;
  final String? address;
  final String? route;
  final String? code;
  final String? city;
  final String? country;
  final String? ledgerId;
  final String? CompanyName;
  final String? location;
  final String? EmployeeId;
  final DateTime? DateOfBirth;
  final String? mobileNumber;
  final String? notes;
  final String? Designation;
  final String? DesignationID;
  final String? Building;
  final bool? isCompanyEmployee;
  final bool? isIndividual;
  final int? Type;
  final String? POBox;
  final String? Street;
  final String? Fax;
  List<String> LocationDetails;
  ContactsDataModelOLD({
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

  ContactsDataModelOLD copyWith({
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
    return ContactsDataModelOLD(
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

  factory ContactsDataModelOLD.fromMap(Map<String, dynamic> map) {
    return ContactsDataModelOLD(
      ContactName: map['ContactName'],
      ContactUuid: map['ContactUuid'],
      PhoneNumber: map['PhoneNumber'],
      email: map['email'],
      address: map['address'],
      route: map['route'],
      code: map['code'],
      city: map['city'],
      country: map['country'],
      ledgerId: map['ledgerId'],
      CompanyName: map['CompanyName'],
      location: map['location'],
      EmployeeId: map['EmployeeId'],
      DateOfBirth: map['DateOfBirth'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['DateOfBirth'])
          : null,
      mobileNumber: map['mobileNumber'],
      notes: map['notes'],
      Designation: map['Designation'],
      DesignationID: map['DesignationID'],
      Building: map['Building'],
      isCompanyEmployee: map['isCompanyEmployee'],
      isIndividual: map['isIndividual'],
      Type: map['Type']?.toInt(),
      POBox: map['POBox'],
      Street: map['Street'],
      Fax: map['Fax'],
      LocationDetails: List<String>.from(map['LocationDetails']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactsDataModelOLD.fromJson(String source) =>
      ContactsDataModelOLD.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContactsDataModelOLD(ContactName: $ContactName, ContactUuid: $ContactUuid, PhoneNumber: $PhoneNumber, email: $email, address: $address, route: $route, code: $code, city: $city, country: $country, ledgerId: $ledgerId, CompanyName: $CompanyName, location: $location, EmployeeId: $EmployeeId, DateOfBirth: $DateOfBirth, mobileNumber: $mobileNumber, notes: $notes, Designation: $Designation, DesignationID: $DesignationID, Building: $Building, isCompanyEmployee: $isCompanyEmployee, isIndividual: $isIndividual, Type: $Type, POBox: $POBox, Street: $Street, Fax: $Fax, LocationDetails: $LocationDetails)';
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
}
