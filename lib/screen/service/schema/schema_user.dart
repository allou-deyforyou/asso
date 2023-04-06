import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '_schema.dart';

class UserSchema extends Equatable {
  const UserSchema({
    required this.uid,
    required this.name,
    required this.phone,
    required this.isDriver,
    required this.country,
    this.profileImage,
    this.reference,
  });

  static const String schema = 'users';

  static const String uidKey = 'uid';
  static const String nameKey = 'name';
  static const String phoneKey = 'phone';
  static const String countryKey = 'country';
  static const String isDriverKey = 'is_driver';
  static const String profileImageKey = 'profile_image';

  final DocumentReference<UserSchema?>? reference;

  final String uid;
  final String name;
  final String phone;
  final bool isDriver;
  final String? profileImage;
  final DocumentReference<CountrySchema?> country;

  @override
  List<Object?> get props {
    return [
      uid,
      name,
      phone,
      country,
      isDriver,
      reference,
      profileImage,
    ];
  }

  UserSchema copyWith({
    String? uid,
    String? name,
    String? phone,
    bool? isDriver,
    String? profileImage,
    DocumentReference<UserSchema?>? reference,
    DocumentReference<CountrySchema?>? country,
  }) {
    return UserSchema(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      isDriver: isDriver ?? this.isDriver,
      reference: reference ?? this.reference,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  UserSchema clone() {
    return copyWith(
      uid: uid,
      name: name,
      phone: phone,
      country: country,
      isDriver: isDriver,
      reference: reference,
      profileImage: profileImage,
    );
  }

  static UserSchema fromMap(Map<String, dynamic> data) {
    return UserSchema(
      uid: data[uidKey],
      name: data[nameKey],
      phone: data[phoneKey],
      isDriver: data[isDriverKey],
      profileImage: data[profileImageKey],
      country: CountrySchema.toFirestoreDocument(data[countryKey]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      uidKey: uid,
      nameKey: name,
      phoneKey: phone,
      countryKey: country,
      isDriverKey: isDriver,
      profileImageKey: profileImage,
    }..removeWhere((key, value) => value == null);
  }

  static List<UserSchema> fromListJson(String source) {
    return List.of((jsonDecode(source) as List).map((value) => fromMap(value)));
  }

  static UserSchema fromJson(String source) {
    return fromMap(jsonDecode(source));
  }

  static String toListJson(List<UserSchema> values) {
    return jsonEncode(values.map((value) => value.toMap()));
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static DocumentReference<UserSchema?> toFirestoreDocument(DocumentReference<Map<String, dynamic>> reference) {
    return reference.withConverter<UserSchema?>(
      toFirestore: (value, options) {
        return value!.toMap();
      },
      fromFirestore: (snapshot, options) {
        final data = snapshot.data();
        return data != null ? fromMap(data) : null;
      },
    );
  }

  static CollectionReference<UserSchema?> toFirestoreCollection(CollectionReference<Map<String, dynamic>> reference) {
    return reference.withConverter<UserSchema?>(
      toFirestore: (value, options) {
        return value!.toMap();
      },
      fromFirestore: (snapshot, options) {
        final data = snapshot.data();
        return data != null ? fromMap(data) : null;
      },
    );
  }
}
