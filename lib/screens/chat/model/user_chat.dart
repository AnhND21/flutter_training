import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserChat {
  final String? displayName;
  final String email;
  final String? phoneNumber;
  final String uid;
  final String firstName;
  final String? lastName;
  final String? photoURL;

  UserChat({
    this.displayName,
    required this.email,
    this.phoneNumber,
    required this.uid,
    required this.firstName,
    this.lastName,
    this.photoURL,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'photoURL': photoURL,
    };
  }

  factory UserChat.fromSnapshot(DocumentSnapshot snapshot) {
    return UserChat.fromMap(
        json.decode(snapshot.data().toString()) as Map<String, dynamic>);
  }

  factory UserChat.fromMap(Map<String, dynamic> map) {
    return UserChat(
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      email: map['email'] != null ? map['email'] as String : '',
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      uid: map['uid'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserChat.fromJson(Map<String, dynamic>? source) =>
      UserChat.fromMap(source as Map<String, dynamic>);

  UserChat copyWith({
    String? displayName,
    String? email,
    String? phoneNumber,
    String? uid,
    String? firstName,
    String? lastName,
    String? photoURL,
  }) {
    return UserChat(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  @override
  String toString() {
    return 'UserChat(displayName: $displayName, email: $email, phoneNumber: $phoneNumber, uid: $uid, firstName: $firstName, lastName: $lastName, photoURL: $photoURL)';
  }

  @override
  bool operator ==(covariant UserChat other) {
    if (identical(this, other)) return true;

    return other.displayName == displayName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.uid == uid &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode {
    return displayName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        uid.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        photoURL.hashCode;
  }
}
