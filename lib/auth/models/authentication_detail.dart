// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthenticationDetail extends Equatable {
  final bool? isValid;
  final String? uid;
  final String? photoUrl;
  final String? email;
  final String? name;
  final String? phoneNumber;
  final String? username;
  final String? password;

  AuthenticationDetail({
    this.username,
    this.password,
    this.isValid,
    this.uid,
    this.photoUrl,
    this.email,
    this.name,
    this.phoneNumber,
  });

  AuthenticationDetail copyWith({
    bool? isValid,
    String? uid,
    String? photoUrl,
    String? email,
    String? name,
    String? phoneNumber,
    String? username,
    String? password,
  }) {
    return AuthenticationDetail(
      isValid: isValid ?? this.isValid,
      uid: uid ?? this.uid,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isValid': isValid,
      'uid': uid,
      'photoUrl': photoUrl,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  factory AuthenticationDetail.fromMap(Map<String, dynamic> map) {
    return AuthenticationDetail(
        isValid: map['isValid'],
        uid: map['uid'],
        photoUrl: map['photoUrl'],
        email: map['email'],
        name: map['name'],
        phoneNumber: map['phoneNumber']);
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationDetail.fromJson(String source) =>
      AuthenticationDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthenticationDetail(isValid: $isValid, uid: $uid, photoUrl: $photoUrl, email: $email, name: $name, phone : $phoneNumber)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AuthenticationDetail &&
        o.isValid == isValid &&
        o.uid == uid &&
        o.photoUrl == photoUrl &&
        o.email == email &&
        o.name == name;
  }

  @override
  int get hashCode {
    return isValid.hashCode ^
        uid.hashCode ^
        photoUrl.hashCode ^
        email.hashCode ^
        name.hashCode;
  }

  @override
  List<Object?> get props {
    return [
      isValid,
      uid,
      photoUrl,
      email,
      name,
      phoneNumber,
    ];
  }
}
